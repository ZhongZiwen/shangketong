//
//  SKTAppContext.h
//  shangketong
//
//  Created by sungoin-zbs on 16/3/7.
//  Copyright © 2016年 sungoin. All rights reserved.
//

/**
 * 负责生成参数项
 */
#import <Foundation/Foundation.h>

@interface SKTAppContext : NSObject

@property (copy, readonly, nonatomic) NSString *version;    // 版本号
@property (copy, readonly, nonatomic) NSString *systemVersion;  // 系统版本
@property (copy, readonly, nonatomic) NSString *deviceModel;    // 手机型号
@property (assign, readonly, nonatomic) BOOL isReachable;

+ (instancetype)sharedInstance;
@end
