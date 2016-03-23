//
//  SKTCheckAccountLoginManager.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/23.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTCheckAccountLoginManager.h"

@implementation SKTCheckAccountLoginManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

#pragma mark - SKTApiManager
- (NSString *)methodName {
    return kNetPath_CheckAccountPassword;
}

- (NSString *)serviceType {
    return kSKTServiceCheckAccountLogin;
}

- (SKTApiManagerRequestType)requestType {
    return SKTApiManagerRequestTypePost;
}

#pragma mark - SKTApiManagerValidator
- (BOOL)manager:(SKTApiBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data {
    return YES;
}

- (BOOL)manager:(SKTApiBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data {
    if (![data[@"status"] integerValue]) {
        return YES;
    }
    
    return NO;
}
@end
