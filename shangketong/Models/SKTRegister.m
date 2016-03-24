//
//  SKTRegister.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/22.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTRegister.h"

@implementation SKTRegister

- (NSDictionary *)params {
    return @{@"accountName" : _accountString,
             @"captcha" : _captchaString};
}

- (NSDictionary *)paramsForFirstRegisterCompany {
    return @{@"companyName" : _companyName,
             @"position" : _position,
             @"userName" : _name,
             @"contact" : _emailOrPhone,
             @"password" : _registerCompanyPassword};
}

- (NSDictionary *)paramsForRegisterCompany {
    return @{@"companyName" : _companyName,
             @"position" : _position,
             @"userName" : _name,
             @"contact" : _emailOrPhone};
}
@end
