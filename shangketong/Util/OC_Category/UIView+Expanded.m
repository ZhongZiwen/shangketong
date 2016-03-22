//
//  UIView+Expanded.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/22.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "UIView+Expanded.h"
#import <objc/runtime.h>

@implementation UIView (Expanded)
static char loadingViewKey;

#pragma mark - loadingView
- (void)setHud:(MBProgressHUD *)hud {
    [self willChangeValueForKey:@"loadingViewKey"];
    objc_setAssociatedObject(self, &loadingViewKey, hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"loadingViewKey"];
}

- (MBProgressHUD *)hud {
    return objc_getAssociatedObject(self, &loadingViewKey);
}

- (void)beginLoading {
    if (!self.hud) {
        MBProgressHUD *hudView = [[MBProgressHUD alloc] initWithView:self];
        self.hud = hudView;
    }
    
    [self addSubview:self.hud];
    [self.hud show:YES];
}

- (void)endLoading {
    if (self.hud) {
        [self.hud hide:YES];
    }
    
    [self.hud removeFromSuperview];
}
@end
