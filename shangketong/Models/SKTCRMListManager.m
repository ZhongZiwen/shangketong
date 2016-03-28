//
//  SKTCRMListManager.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/28.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTCRMListManager.h"

@implementation SKTCRMListManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}

#pragma mark - SKTApiManager
- (NSString *)methodName {
    switch (_listManagerType) {
        case SKTCRMListManagerTypeActivity:
            return kNetPath_Activity_List;
        case SKTCRMListManagerTypeSaleLeads:
            return nil;
        case SKTCRMListManagerTypeCustomer:
            return nil;
        case SKTCRMListManagerTypeContacts:
            return nil;
        case SKTCRMListManagerTypeSalesOpportunities:
            return nil;
        default:
            return nil;
    }
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
