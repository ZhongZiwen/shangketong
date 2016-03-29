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
        _nextPageNumber = 1;
    }
    return self;
}

#pragma mark - Public method
- (void)loadNextPage {
    if (self.isLoading) {
        return;
    }

    [self loadData];
}

- (void)beforePerformSuccessWithResponse:(SKTURLResponse *)response {
    [super beforePerformSuccessWithResponse:response];

    self.nextPageNumber ++;
}

- (void)beforePerformFailWithResponse:(SKTURLResponse *)response {
    [super beforePerformFailWithResponse:response];

    if (self.nextPageNumber > 0) {
        self.nextPageNumber --;
    }
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

- (NSDictionary *)reformParams:(NSDictionary *)params {
    NSMutableDictionary *tempParams = [NSMutableDictionary dictionaryWithDictionary:@{@"pageNo" : @(_nextPageNumber), @"pageSize" : @20}];
    [tempParams addEntriesFromDictionary:params];
    return tempParams;
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
