//
//  SKTServiceFactory.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/14.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTServiceFactory.h"

// login
#import "SKTLoginService.h"
// selectCompany
#import "SKTSelectCompanyService.h"
// send captcha
#import "SKTCaptchaService.h"
// 注册，提交用户名和验证码
#import "SKTCheckAccountService.h"
// 注册，创建公司前登录
#import "SKTCheckAccountLoginService.h"
// 注册新公司
#import "SKTRegisterCompanyService.h"
// crm service
#import "SKTCRMService.h"

NSString * const kSKTServiceLogin = @"kSKTServiceLogin";
NSString * const kSKTServiceSelectCompany = @"kSKTServiceSelectCompany";
NSString * const kSKTServiceCaptcha = @"kSKTServiceCaptcha";
NSString * const kSKTServiceCheckAccount = @"kSKTServiceCheckAccount";
NSString * const kSKTServiceCheckAccountLogin = @"kSKTServiceCheckAccountLogin";
NSString * const kSKTServiceRegisterCompany = @"kSKTServiceRegisterCompany";
NSString * const kSKTServiceCRM = @"kSKTServiceCRM";

@interface SKTServiceFactory ()

@property (strong, nonatomic) NSMutableDictionary *serviceStorage;
@end

@implementation SKTServiceFactory

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static SKTServiceFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SKTServiceFactory alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public method
- (SKTService<SKTServiceProtocol> *)serviceWithIdentifier:(NSString *)identifier {
    if (!self.serviceStorage[identifier]) {
        self.serviceStorage[identifier] = [self newServiceWithIdentifier:identifier];
    }
    return self.serviceStorage[identifier];
}

#pragma mark - private method
- (SKTService<SKTServiceProtocol> *)newServiceWithIdentifier:(NSString *)identifier {
    
    if ([identifier isEqualToString:kSKTServiceLogin]) {
        SKTLoginService *loginService = [[SKTLoginService alloc] init];
        return loginService;
    }
    else if ([identifier isEqualToString:kSKTServiceSelectCompany]) {
        SKTSelectCompanyService *selectCompanyService = [[SKTSelectCompanyService alloc] init];
        return selectCompanyService;
    }
    else if ([identifier isEqualToString:kSKTServiceCaptcha]) {
        SKTCaptchaService *captchaService = [[SKTCaptchaService alloc] init];
        return captchaService;
    }
    else if ([identifier isEqualToString:kSKTServiceCheckAccount]) {
        SKTCheckAccountService *checkAccountService = [[SKTCheckAccountService alloc] init];
        return checkAccountService;
    }
    else if ([identifier isEqualToString:kSKTServiceCheckAccountLogin]) {
        SKTCheckAccountLoginService *checkAccountLoginService = [[SKTCheckAccountLoginService alloc] init];
        return checkAccountLoginService;
    }
    else if ([identifier isEqualToString:kSKTServiceRegisterCompany]) {
        SKTRegisterCompanyService *registerCompanyService = [[SKTRegisterCompanyService alloc] init];
        return registerCompanyService;
    }
    else if ([identifier isEqualToString:kSKTServiceCRM]) {
        SKTCRMService *crmService = [[SKTCRMService alloc] init];
        return crmService;
    }
    
    return nil;
}

#pragma mark - setters and getters
- (NSMutableDictionary *)serviceStorage {
    if (!_serviceStorage) {
        _serviceStorage = [[NSMutableDictionary alloc] init];
    }
    return _serviceStorage;
}
@end
