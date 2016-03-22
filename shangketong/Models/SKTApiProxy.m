//
//  SKTApiProxy.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/7.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTApiProxy.h"
#import <AFNetworking.h>
#import "SKTServiceFactory.h"
#import "SKTRequestGenerator.h"
#import "NSURLRequest+SKTNetworkingMethods.h"

static NSString * const kApiProxyDispatchItemKeyCallBackSuccess = @"kApiProxyDispatchItemKeyCallBackSuccess";
static NSString * const kApiProxyDispatchItemKeyCallBackFail = @"kApiProxyDispatchItemKeyCallBackFail";

@interface SKTApiProxy ()

@property (strong, nonatomic) NSMutableDictionary *dispatchTable;
@property (strong, nonatomic) NSNumber *recordedRequestId;
@property (strong, nonatomic) AFHTTPRequestOperationManager *operationManager;
@end

@implementation SKTApiProxy

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static SKTApiProxy *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SKTApiProxy alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public method
- (NSInteger)callGetWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName success:(ApiCallBack)success fail:(ApiCallBack)fail {
    
    NSURLRequest *request = [[SKTRequestGenerator sharedInstance] generatorGetRequestWithServiceIdentifier:serviceIdentifier requestParams:params methodName:methodName];
    
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    
    return [requestId integerValue];
}

- (NSInteger)callPostWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)serviceIdentifier methodName:(NSString *)methodName success:(ApiCallBack)success fail:(ApiCallBack)fail {
    
    NSURLRequest *request = [[SKTRequestGenerator sharedInstance] generatorPostRequestWithServiceIdentifier:serviceIdentifier requestParams:params methodName:methodName];
    
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    
    return [requestId integerValue];
}

- (void)cancelRequestWithRequestID:(NSNumber *)requestID {
    NSOperation *requestOperation = self.dispatchTable[requestID];
    [requestOperation cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList {
    for (NSNumber *requestId in requestIDList) {
        [self cancelRequestWithRequestID:requestId];
    }
}

#pragma mark - private method
- (NSNumber *)callApiWithRequest:(NSURLRequest *)request success:(ApiCallBack)success fail:(ApiCallBack)fail {
    
    // 生成requestId
    NSNumber *requestId = [self generateRequestId];
    
    AFHTTPRequestOperation *httpRequestOperation = [self.operationManager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 取出存储在列表的operation
        AFHTTPRequestOperation *storedOperation = self.dispatchTable[requestId];
        if (!storedOperation) {
            // 如果这个operation是被cancel的，那就不用处理回调了.
            return;
        }
        else {
            [self.dispatchTable removeObjectForKey:requestId];
        }
        
        SKTURLResponse *response = [[SKTURLResponse alloc] initWithResponseString:operation.responseString requestId:requestId request:operation.request responseData:operation.responseData status:SKTURLResponseStatusSuccess];
        
        success ? success(response) : nil;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        AFHTTPRequestOperation *storedOperation = self.dispatchTable[requestId];
        if (!storedOperation) {
            // 如果这个operation是被cancel的，那就不用处理回调了。
            return;
        }
        else {
            [self.dispatchTable removeObjectForKey:requestId];
        }
        
        SKTURLResponse *response = [[SKTURLResponse alloc] initWithResponseString:operation.responseString requestId:requestId request:operation.request responseData:operation.responseData error:error];
        
        fail ? fail(response) : nil;
    }];
    
    self.dispatchTable[requestId] = httpRequestOperation;
    [[self.operationManager operationQueue] addOperation:httpRequestOperation];
    return requestId;
}

- (NSNumber *)generateRequestId {
    if (!_recordedRequestId) {
        _recordedRequestId = @1;
    }
    else {
        if ([_recordedRequestId integerValue] == NSIntegerMax) {
            _recordedRequestId = @1;
        }
        else {
            _recordedRequestId = @([_recordedRequestId integerValue] + 1);
        }
    }
    return _recordedRequestId;
}

#pragma mark - setters and getters
- (NSMutableDictionary *)dispatchTable {
    if (!_dispatchTable) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}

- (AFHTTPRequestOperationManager *)operationManager {
    if (!_operationManager) {
        _operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:nil];
        
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"text/plain", nil];
        responseSerializer.removesKeysWithNullValues = YES;
        _operationManager.responseSerializer = responseSerializer;
        _operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _operationManager;
}
@end
