//
//  SKTNetworkingConfiguration.h
//  shangketong
//
//  Created by sungoin-zbs on 16/3/7.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#ifndef SKTNetworkingConfiguration_h
#define SKTNetworkingConfiguration_h

#define kApiBaseUrl @"http://app.sunke.com"
#define kApiPort @""
#define kApiProjectName @"user"

typedef NS_ENUM(NSUInteger, SKTURLResponseStatus) {
    SKTURLResponseStatusSuccess,    // 作为底层，请求是否成功只考虑是否成功接收到服务器反馈。至于签名是否正确，返回的数据数据是否完整，由上层的SKTApiBaseManager来决定。
    SKTURLResponseStatusErrorTimeout,
    SKTURLResponseStatusErrorNoNetwork  // 默认除了超时以外的错误都是无网络错误。
};

static NSTimeInterval kSKTNetworkingTimeoutSeconds = 20.0f;

extern NSString * const kSKTServiceLogin;
extern NSString * const kSKTServiceSelectCompany;
extern NSString * const kSKTServiceCaptcha;
extern NSString * const kSKTServiceCheckAccount;


#endif /* SKTNetworkingConfiguration_h */
