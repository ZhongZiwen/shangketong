//
//  SKTRegisterViewController.h
//  shangketong
//
//  Created by sungoin-zbs on 16/3/17.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SKTRegisterViewControllerType) {
    SKTRegisterViewControllerTypeRegister,
    SKTRegisterViewControllerTypeFindPassword
};

@interface SKTRegisterViewController : UIViewController

@property (nonatomic, assign) SKTRegisterViewControllerType type;
@end
