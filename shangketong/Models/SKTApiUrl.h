//
//  SKTApiUrl.h
//  shangketong
//
//  Created by sungoin-zbs on 16/3/18.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#ifndef SKTApiUrl_h
#define SKTApiUrl_h
#endif /* SKTApiUrl_h */

// 登录
#define kNetPath_Login @"j_spring_security_check"
// 选择公司登录 参数：tenantId（公司ID）
#define kNetPath_SelectCompany @"user/chooseCompany.do"
// 获取验证码
#define kNetPath_SendCaptcha @"user/sendCaptcha.do"
// 注册，提交账户和验证码
#define kNetPath_CheckAccountName @"user/validate/checkAccountName.do"
// 注册，提交账户和密码
#define kNetPath_CheckAccountPassword @"user/checkAccountPassword.do"