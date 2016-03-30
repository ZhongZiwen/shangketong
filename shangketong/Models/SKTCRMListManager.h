//
//  SKTCRMListManager.h
//  shangketong
//
//  Created by sungoin-zbs on 16/3/28.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTApiBaseManager.h"

typedef NS_ENUM(NSUInteger, SKTCRMListManagerType) {
    SKTCRMListManagerTypeActivity,  // 市场活动
    SKTCRMListManagerTypeSaleLeads,  // 销售线索
    SKTCRMListManagerTypeCustomer,  // 客户
    SKTCRMListManagerTypeContacts,  // 联系人
    SKTCRMListManagerTypeSalesOpportunities  // 销售机会
};

@interface SKTCRMListManager : SKTApiBaseManager<SKTApiManager, SKTApiManagerValidator>

@property (nonatomic, assign) SKTCRMListManagerType listManagerType;
@property (nonatomic, assign) NSInteger nextPageNumber;

- (void)loadFirstPage;
- (void)loadNextPage;
@end
