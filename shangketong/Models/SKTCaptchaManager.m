//
//  SKTCaptchaManager.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/22.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTCaptchaManager.h"

@interface SKTCaptchaManager ()<SKTApiManagerValidator>

@end

@implementation SKTCaptchaManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

#pragma mark - SKTApiManager
- (NSString *)methodName {
    return kNetPath_SendCaptcha;
}

- (NSString *)serviceType {
    return kSKTServiceCaptcha;
}

- (SKTApiManagerRequestType)requestType {
    return SKTApiManagerRequestTypePost;
}

#pragma mark - SKTApiManagerValidator
- (BOOL)manager:(SKTApiBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data {
    return YES;
}

- (BOOL)manager:(SKTApiBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data {
    return YES;
}
@end
