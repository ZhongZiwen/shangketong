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

@property (nonatomic, copy) NSString *companyName;  // 新建公司,公司名
@property (nonatomic, copy) NSString *position;  // 新建公司,职务
@property (nonatomic, copy) NSString *name;  // 新建公司,姓名
@property (nonatomic, copy) NSString *registerCompanyPassword;  // 初次注册,新建公司的密码
@property (nonatomic, copy) NSString *emailOrPhone;  // 新建公司,邮箱或手机号

- (NSDictionary *)params;  // 注册,提交账号和验证码
- (NSDictionary *)paramsForFirstRegisterCompany;  // 初次注册,创建新公司
- (NSDictionary *)paramsForRegisterCompany;  // 注册,创建新公司
@end
