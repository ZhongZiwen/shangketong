//
//  SKTRegisterCompanyManager.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/24.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTRegisterCompanyManager.h"

@implementation SKTRegisterCompanyManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

#pragma mark - SKTApiManager
- (NSString *)methodName {
    return kNetPath_RegisterCompany;
}

- (NSString *)serviceType {
    return kSKTServiceRegisterCompany;
}

- (SKTApiManagerRequestType)requestType {
    return SKTApiManagerRequestTypePost;
}

#pragma mark - SKTApiManagerValidator
- (BOOL)manager:(SKTApiBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data {
    if ([data[@"contact"] containsString:@"@"]) {
        if ([data[@"contact"] isEmail]) {
            return YES;
        }
        else {
            [NSObject showHudTipStr:@"邮箱格式有误"];
            return NO;
        }
    }
    else {
        if ([data[@"contact"] isPhoneNumber]) {
            return YES;
        }
        else {
            [NSObject showHudTipStr:@"手机号码格式有误"];
            return NO;
        }
    }
}

- (BOOL)manager:(SKTApiBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data {
    if (![data[@"status"] integerValue]) {
        return YES;
    }

    [NSObject showHudTipStr:data[@"desc"]];
    return NO;
}
@end
