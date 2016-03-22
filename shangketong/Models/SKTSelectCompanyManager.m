//
//  SKTSelectCompanyManager.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/22.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTSelectCompanyManager.h"

@interface SKTSelectCompanyManager ()<SKTApiManagerValidator>

@end

@implementation SKTSelectCompanyManager

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
- (NSString *)methodName {
    return kNetPath_SelectCompany;
}

- (NSString *)serviceType {
    return kSKTServiceSelectCompany;
}

- (SKTApiManagerRequestType)requestType {
    return SKTApiManagerRequestTypePost;
}
@end
