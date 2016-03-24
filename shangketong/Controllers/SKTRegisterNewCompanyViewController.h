//
//  SKTRegisterNewCompanyViewController.h
//  shangketong
//
//  Created by sungoin-zbs on 16/3/23.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import <XLForm/XLForm.h>

@class SKTRegister;

@interface SKTRegisterNewCompanyViewController : XLFormViewController

@property (nonatomic, strong) SKTRegister *aRegister;
@property (nonatomic, assign) BOOL isFirstRegister;
@end
