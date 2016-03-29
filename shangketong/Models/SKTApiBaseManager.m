//
//  SKTApiBaseManager.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/7.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTApiBaseManager.h"
#import "SKTAppContext.h"
#import "SKTApiProxy.h"

#define kCallApi(request_method, request_id)    \
{                                               \
    request_id = [[SKTApiProxy sharedInstance] call##request_method##WithParams:apiParams serviceIdentifier:self.child.serviceType methodName:self.child.methodName success:^(SKTURLResponse *response) {   \
        [self successedOnCallingApi:response];  \
    } fail:^(SKTURLResponse *response) {    \
        [self failedOnCallingApi:response errorType:SKTApiManagerErrorTypeDefault]; \
    }]; \
    [self.requestIdList addObject:@(request_id)];   \
}

@interface SKTApiBaseManager ()

@property (strong, readwrite, nonatomic) id fetchedRawData; // 获取的原始数据
@property (copy, readwrite, nonatomic) NSString *errorMessage;
@property (readwrite, nonatomic) SKTApiManagerErrorType errorType;
@property (strong, nonatomic) NSMutableArray *requestIdList;
@end

@implementation SKTApiBaseManager

- (void)dealloc {
    [self cancelAllRequests];
    self.requestIdList = nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _delegate = nil;
        _validator = nil;
        _paramSource = nil;
        
        _fetchedRawData = nil;
        
        _errorMessage = nil;
        _errorType = SKTApiManagerErrorTypeDefault;
        
        if ([self conformsToProtocol:@protocol(SKTApiManager)]) {
            self.child = (id<SKTApiManager>)self;
        }
    }
    return self;
}

#pragma mark - public method
- (void)cancelAllRequests {
    [[SKTApiProxy sharedInstance] cancelRequestWithRequestIDList:self.requestIdList];
    [self.requestIdList removeAllObjects];
}

- (void)cancelRequestWithRequestId:(NSInteger)requestId {
    [self removeRequestIdWithRequestId:requestId];
    [[SKTApiProxy sharedInstance] cancelRequestWithRequestID:@(requestId)];
}

- (id)fetchDataWithReformer:(id<SKTApiManagerCallBackDataReformer>)reformer {
    id resultData = nil;
    if ([reformer respondsToSelector:@selector(manager:reformData:)]) {
        resultData = [reformer manager:self reformData:self.fetchedRawData];
    }
    else {
        resultData = [self.fetchedRawData mutableCopy];
    }
    return resultData;
}

#pragma mark - private method
- (void)removeRequestIdWithRequestId:(NSInteger)requestId {
    NSNumber *requestIdToRemove = nil;
    for (NSNumber *tempRequestId in self.requestIdList) {
        if ([tempRequestId isEqualToNumber:@(requestId)]) {
            requestIdToRemove = tempRequestId;
            break;
        }
    }
    
    if (requestIdToRemove) {
        [self.requestIdList removeObject:requestIdToRemove];
    }
}

#pragma mark - call api
- (NSInteger)loadData {
    NSDictionary *params = [self.paramSource paramsForApi:self];
    NSInteger requestId = [self loadDataWithParams:params];
    return requestId;
}

- (NSInteger)loadDataWithParams:(NSDictionary *)params {
    NSInteger requestId = 0;
    NSDictionary *apiParams = [self reformParams:params];
    if ([self shouldCallApiWithParams:apiParams]) {
        if ([self.validator manager:self isCorrectWithParamsData:apiParams]) {
            // 网络请求
            if ([self isReachable]) {
                switch (self.child.requestType) {
                    case SKTApiManagerRequestTypeGet:
                        kCallApi(Get, requestId);
                        break;
                    case SKTApiManagerRequestTypePost:
                        kCallApi(Post, requestId);
                        break;
                    default:
                        break;
                }
                
                NSMutableDictionary *params = [apiParams mutableCopy];
                params[kSKTApiBaseManagerRequestID] = @(requestId);
                [self afterCallApiWithParams:params];
                return requestId;
            }
            else {  // 网络不可用
                [self failedOnCallingApi:nil errorType:SKTApiManagerErrorTypeNoNetwork];
                return requestId;
            }
        }
        else {  // 参数错误
            [self failedOnCallingApi:nil errorType:SKTApiManagerErrorTypeParamsError];
            return requestId;
        }
    }
    
    return requestId;
}

#pragma mark - api callBack
- (void)successedOnCallingApi:(SKTURLResponse *)response {
    
    // 发送验证码，返回的是字符串类型
    if ([response.request.URL isEqual:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@/%@", kApiBaseUrl, kApiPort, kApiProjectName, kNetPath_SendCaptcha]]]) {
        self.fetchedRawData = [response.contentString copy];
    }
    // 新建公司前登录，验证账号密码
    else if ([response.request.URL isEqual:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@/%@", kApiBaseUrl, kApiPort, kApiProjectName, kNetPath_CheckAccountPassword]]]) {
        self.fetchedRawData = [response.contentString copy];
    }
    else if (response.content) {
        self.fetchedRawData = [response.content copy];
    }
    else {
        self.fetchedRawData = [response.responseData copy];
    }
    
    [self removeRequestIdWithRequestId:response.requestId];
    if ([self.validator manager:self isCorrectWithCallBackData:response.content]) {
        [self beforePerformSuccessWithResponse:response];
        [self.delegate managerCallApiDidSuccess:self];
        [self afterPerformSuccessWithResponse:response];
    }
    else {
        [self failedOnCallingApi:response errorType:SKTApiManagerErrorTypeNoContent];
    }
}

- (void)failedOnCallingApi:(SKTURLResponse *)response errorType:(SKTApiManagerErrorType)errorType {
    self.errorType = errorType;
    [self removeRequestIdWithRequestId:response.requestId];
    [self beforePerformFailWithResponse:response];
    [self.delegate managerCallApiDidFailed:self];
    [self afterPerformFailWithResponse:response];
}

#pragma mark - method for interceptor
/*
    拦截器的功能可以由子类通过继承实现，也可以由其它对象实现，两种做法可以共存；
    当两种情况共存的时候，子类重载的方法一定得调用一下super，然后它们的调用顺序是baseManager会先调用子类重载的实现，再调用外部interceptor的实现。
    notes:
    正常情况下，拦截器是通过代理的方式实现的，因此可以不需要以下这些代码，但为了将来拓展方便，
    如果在调用拦截器之前manager又希望自己能够先做一些事情，所以这些方法还是需要能够被继承重载的。
    所有重载的方法，都要调用一下super，这样才能保证外部interceptor能够被调到，这就是decorate pattern
 */

// 只有返回YES才会继续调用API
- (BOOL)shouldCallApiWithParams:(NSDictionary *)params {
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:shouldCallApiWithParams:)]) {
        return [self.interceptor manager:self shouldCallApiWithParams:params];
    }
    else {
        return YES;
    }
}

- (void)afterCallApiWithParams:(NSDictionary *)params {
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterCallApiWithParams:)]) {
        [self.interceptor manager:self afterCallApiWithParams:params];
    }
}

- (void)beforePerformSuccessWithResponse:(SKTURLResponse *)response {
    self.errorType = SKTApiManagerErrorTypeSuccess;
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:beforePerformSuccessWithResponse:)]) {
        [self.interceptor manager:self beforePerformSuccessWithResponse:response];
    }
}

- (void)afterPerformSuccessWithResponse:(SKTURLResponse *)response {
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterPerformSuccessWithResponse:)]) {
        [self.interceptor manager:self afterPerformSuccessWithResponse:response];
    }
}

- (void)beforePerformFailWithResponse:(SKTURLResponse *)response {
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:beforePerformFailWithResponse:)]) {
        [self.interceptor manager:self beforePerformFailWithResponse:response];
    }
}

- (void)afterPerformFailWithResponse:(SKTURLResponse *)response {
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterPerformFailWithResponse:)]) {
        [self.interceptor manager:self afterPerformFailWithResponse:response];
    }
}

#pragma mark - method for child
// 如果需要在调用api之前额外添加一些参数，比如pageNumber和pageSize之类的就在这里添加
// 子类中覆盖这个函数的时候就不需要调用[super reformParams:params]了。
- (NSDictionary *)reformParams:(NSDictionary *)params {
    IMP childIMP = [self.child methodForSelector:@selector(reformParams:)];
    IMP selfIMP = [self methodForSelector:@selector(reformParams:)];
    if (childIMP == selfIMP) {
        return params;
    }
    else {
        // 如果child是继承得来的，那么这里就不会跑到，会直接跑子类中的IMP。
        // 如果child是另一个对象，就会跑到这里
        NSDictionary *result = nil;
        result = [self.child reformParams:params];
        if (result) {
            return result;
        }
        else {
            return params;
        }
    }
}

- (void)cleanData {
    IMP childIMP = [self.child methodForSelector:@selector(cleanData)];
    IMP selfIMP = [self methodForSelector:@selector(cleanData)];
    
    if (childIMP == selfIMP) {
        self.fetchedRawData = nil;
        self.errorMessage = nil;
        self.errorType = SKTApiManagerErrorTypeDefault;
    } else {
        if ([self.child respondsToSelector:@selector(cleanData)]) {
            [self.child cleanData];
        }
    }
}

#pragma mark - setters and getters
- (NSMutableArray *)requestIdList {
    if (!_requestIdList) {
        _requestIdList = [[NSMutableArray alloc] init];
    }
    return _requestIdList;
}

- (BOOL)isReachable {
    BOOL isReachability = [SKTAppContext sharedInstance].isReachable;
    if (!isReachability) {
        self.errorType = SKTApiManagerErrorTypeNoNetwork;
    }
    return isReachability;
}

- (BOOL)isLoading {
    return self.requestIdList.count > 0;
}
@end
