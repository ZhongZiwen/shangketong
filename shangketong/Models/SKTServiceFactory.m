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

@property (nonatomic, strong) NSCache *serviceStorage;
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
    
    if (![self.serviceStorage objectForKey:identifier]) {
        [self.serviceStorage setObject:[self newServiceWithIdentifier:identifier] forKey:identifier];
    }
    return [self.serviceStorage objectForKey:identifier];
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
- (NSCache *)serviceStorage {
    if (!_serviceStorage) {
        _serviceStorage = [[NSCache alloc] init];
        _serviceStorage.countLimit = 5;  // 我在这里随意定了一个，具体的值还是要取决于各自App的要求。
    }
    return _serviceStorage;
}
@end
