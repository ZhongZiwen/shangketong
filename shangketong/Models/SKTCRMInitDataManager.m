//
//  SKTCRMInitDataManager.m
//  shangketong
//
//  Created by 钟必胜 on 16/3/27.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTCRMInitDataManager.h"

@implementation SKTCRMInitDataManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

#pragma mark - SKTApiManager
- (NSString *)methodName {
    if (_managerType == SKTCRMInitDataManagerTypeActivity) {
        return kNetPath_Activity_InitData;
    }
    
    return nil;
}

- (NSString *)serviceType {
    return kSKTServiceCRM;
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
