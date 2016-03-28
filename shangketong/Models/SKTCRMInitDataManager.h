//
//  SKTCRMInitDataManager.h
//  shangketong
//
//  Created by 钟必胜 on 16/3/27.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTApiBaseManager.h"

typedef NS_ENUM(NSUInteger, SKTCRMInitDataManagerType) {
    SKTCRMInitDataManagerTypeActivity,  // 市场活动
    SKTCRMInitDataManagerTypeSaleLeads,  // 销售线索
    SKTCRMInitDataManagerTypeCustomer,  // 客户
    SKTCRMInitDataManagerTypeContacts,  // 联系人
    SKTCRMInitDataManagerTypeSalesOpportunities  // 销售机会
};

@interface SKTCRMInitDataManager : SKTApiBaseManager<SKTApiManager, SKTApiManagerValidator>

@property (nonatomic, assign) SKTCRMInitDataManagerType managerType;
@end
