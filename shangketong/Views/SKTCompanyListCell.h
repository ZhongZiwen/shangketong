//
//  SKTCompanyListCell.h
//  shangketong
//
//  Created by sungoin-zbs on 16/3/21.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCellIdentifier @"SKTCompanyListCell"

@interface SKTCompanyListCell : UITableViewCell

@property (nonatomic, assign) BOOL isSelected;

- (void)configWithCompanyName:(NSString *)name;
@end
