//
//  SKTRegisterCompanyListViewController.h
//  shangketong
//
//  Created by 钟必胜 on 16/3/23.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKTRegister;

@interface SKTRegisterCompanyListViewController : UIViewController

@property (nonatomic, copy) NSArray *companyListArray;
@property (nonatomic, strong) SKTRegister *mRegister;
@end
