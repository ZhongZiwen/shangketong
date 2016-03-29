//
//  SKTApiBaseManager.h
//  shangketong
//
//  Created by sungoin-zbs on 16/3/7.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKTApiUrl.h"
#import "SKTURLResponse.h"

@class SKTApiBaseManager;

// 在成功调用之后的params字典里面，用这个key可以取出requestID
static NSString * const kSKTApiBaseManagerRequestID = @"kSKTApiBaseManagerRequestID";

/**************************api回调**************************/
@protocol SKTApiManagerApiCallBackDelegate <NSObject>
@required
- (void)managerCallApiDidSuccess:(SKTApiBaseManager *)manager;
- (void)managerCallApiDidFailed:(SKTApiBaseManager *)manager;
@end

/**************************重新组装**************************/
// 负责重新组装api返回的数据的对象
@protocol SKTApiManagerCallBackDataReformer <NSObject>
@required
- (id)manager:(SKTApiBaseManager *)manager reformData:(NSDictionary *)data;
@end

/**************************验证**************************/
// 用于验证API的返回或者调用API的参数是否正确
@protocol SKTApiManagerValidator <NSObject>
@required
// 所有的callBack数据都应该在这个函数里面进行检查，事实上，到了回调delegate的函数里面是不需要再额外验证返回数据是否为空的。因为判断逻辑都在这里做掉了。而且本来判断返回数据是否正确的逻辑就应该交给manager去做，不要放到回调到controller的delegate方法里面去做。
- (BOOL)manager:(SKTApiBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data;
// 请求参数params的验证
- (BOOL)manager:(SKTApiBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data;
@end

/**************************获取params**************************/
// 调用api所需要的参数params
@protocol SKTApiManagerParamSourceDelegate <NSObject>
@required
- (NSDictionary *)paramsForApi:(SKTApiBaseManager *)manager;
@end


typedef NS_ENUM(NSUInteger, SKTApiManagerErrorType) {
    SKTApiManagerErrorTypeDefault,      // 没有产生过api请求，这个是manager的默认状态
    SKTApiManagerErrorTypeSuccess,      // api请求成功且返回正确数据，此时manager的数据是可以直接拿来使用的
    SKTApiManagerErrorTypeNoContent,    // api请求成功但返回数据不正确。如果回调数据验证函数返回值为NO，manager的状态就会使这个
    SKTApiManagerErrorTypeParamsError,  // 参数错误，此时manager不会调用api，因为参数验证是在调用api之前做的
    SKTApiManagerErrorTypeTimeOut,      // 请求超时。SKTApiProxy设置的是20秒超时
    SKTApiManagerErrorTypeNoNetwork     // 网络不通。在调用api之前会判断一下当前网络是否畅通，这个也是在调用api之前验证的，和上面超时的状态是有区别的。
};

typedef NS_ENUM(NSUInteger, SKTApiManagerRequestType) {
    SKTApiManagerRequestTypeGet,
    SKTApiManagerRequestTypePost
};


/**************************SKTApiManager**************************/
// SKTApiManager的派生类必须符合这些protocol
@protocol SKTApiManager <NSObject>

@required
- (NSString *)methodName;
- (NSString *)serviceType;
- (SKTApiManagerRequestType)requestType;

@optional
- (void)cleanData;
- (NSDictionary *)reformParams:(NSDictionary *)params;
- (BOOL)shouldCache;
@end

/**************************拦截器**************************/
// interceptor 拦截器
// SKTApiBaseManager的派生类必须符合该protocol
@protocol SKTApiManagerInterceptor <NSObject>

@optional
- (void)manager:(SKTApiBaseManager *)manager beforePerformSuccessWithResponse:(SKTURLResponse *)response;
- (void)manager:(SKTApiBaseManager *)manager afterPerformSuccessWithResponse:(SKTURLResponse *)response;

- (void)manager:(SKTApiBaseManager *)manager beforePerformFailWithResponse:(SKTURLResponse *)response;
- (void)manager:(SKTApiBaseManager *)manager afterPerformFailWithResponse:(SKTURLResponse *)response;

- (BOOL)manager:(SKTApiBaseManager *)manager shouldCallApiWithParams:(NSDictionary *)params;
- (void)manager:(SKTApiBaseManager *)manager afterCallApiWithParams:(NSDictionary *)params;
@end

@interface SKTApiBaseManager : NSObject

@property (weak, nonatomic) id<SKTApiManagerApiCallBackDelegate> delegate;
@property (weak, nonatomic) id<SKTApiManagerParamSourceDelegate> paramSource;
@property (weak, nonatomic) id<SKTApiManagerValidator> validator;
@property (weak, nonatomic) NSObject<SKTApiManager> *child;     // 里面会调用到NSObject的方法，所以这里不用id
@property (weak, nonatomic) id<SKTApiManagerInterceptor> interceptor;

/**
 * 1:baseManage是不会去设置errorMessage的，派生的子类manager可能需要给controller提供错误信息。所以为了统一外部调用的入口，设置了这个变量。
 * 2:派生的子类需要通过extension来在保证errorMessage在对外只读的情况下使派生的manager子类对errorMessage具有写权限*/
@property (copy, readonly, nonatomic) NSString *errorMessage;
@property (readonly, nonatomic) SKTApiManagerErrorType errorType;

@property (assign, readonly, nonatomic) BOOL isReachable;
@property (assign, readonly, nonatomic) BOOL isLoading;

- (id)fetchDataWithReformer:(id<SKTApiManagerCallBackDataReformer>)reformer;

- (NSInteger)loadData;

- (void)cancelAllRequests;
- (void)cancelRequestWithRequestId:(NSInteger)requestId;

// 拦截方法，继承之后需要调用一下super
- (BOOL)shouldCallApiWithParams:(NSDictionary *)params;
- (void)afterCallApiWithParams:(NSDictionary *)params;

- (void)beforePerformSuccessWithResponse:(SKTURLResponse *)response;
- (void)afterPerformSuccessWithResponse:(SKTURLResponse *)response;

- (void)beforePerformFailWithResponse:(SKTURLResponse *)response;
- (void)afterPerformFailWithResponse:(SKTURLResponse *)response;

- (NSDictionary *)reformParams:(NSDictionary *)params;
- (void)cleanData;
@end
