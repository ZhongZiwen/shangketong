//
//  SKTLoginManager.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/18.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTLoginManager.h"

@interface SKTLoginManager ()<SKTApiManagerValidator>

@end

@implementation SKTLoginManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

#pragma mark - SKTApiManagerValidator
- (BOOL)manager:(SKTApiBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data {
    return YES;
}

- (BOOL)manager:(SKTApiBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data {
    return YES;
}

#pragma mark - SKTApiManager
- (NSString *)serviceType {
    return kSKTServiceLogin;
}

- (NSString *)methodName {
    return kNetPath_Login;
}

- (SKTApiManagerRequestType)requestType {
    return SKTApiManagerRequestTypePost;
}
@end
