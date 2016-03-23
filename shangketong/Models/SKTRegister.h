//
//  SKTRegister.h
//  shangketong
//
//  Created by sungoin-zbs on 16/3/22.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKTRegister : NSObject

@property (nonatomic, copy) NSString *accountString;
@property (nonatomic, copy) NSString *captchaString;
@property (nonatomic, copy) NSString *password;  // 注册,选择公司的登录密码
@property (nonatomic, copy) NSString *checkAccountLoginPassword;  // 注册,创建公司前的登录密码
@property (nonatomic, copy) NSString *companyId;

- (NSDictionary *)params;
@end
