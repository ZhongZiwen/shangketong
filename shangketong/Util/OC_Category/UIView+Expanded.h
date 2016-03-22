//
//  UIView+Expanded.h
//  shangketong
//
//  Created by sungoin-zbs on 16/3/22.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

@interface UIView (Expanded)

// MBProgressHUD_loadingView
@property (nonatomic, strong) MBProgressHUD *hud;
- (void)beginLoading;
- (void)endLoading;
@end
