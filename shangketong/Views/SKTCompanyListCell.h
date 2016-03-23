//
//  SKTCompanyListCell.h
//  shangketong
//
//  Created by sungoin-zbs on 16/3/21.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCellIdentifier_login @"SKTCompanyListCell_Login"
#define kCellIdentifier_register @"SKTCompanyListCell_Register"

@interface SKTCompanyListCell : UITableViewCell

- (void)configWithCompanyName:(NSString *)name;
- (void)configForLoginWithCompanyName:(NSString *)name isSelected:(BOOL)isSelected;
@end
