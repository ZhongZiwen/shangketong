//
//  SKTCaptchaButton.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/18.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTCaptchaButton.h"

@interface SKTCaptchaButton ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSTimeInterval durationTovalidity;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation SKTCaptchaButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.enabled = YES;
        
        [self addSubview:self.lineView];
    }
    return self;
}

#pragma mark - event response
- (void)redrawTimer:(NSTimer *)timer {
    _durationTovalidity --;
    if (_durationTovalidity > 0) {
        // 防止button_title闪烁
        self.titleLabel.text = [NSString stringWithFormat:@"%.0f 秒", _durationTovalidity];
        [self setTitle:[NSString stringWithFormat:@"%.0f 秒", _durationTovalidity] forState:UIControlStateNormal];
    }
    else {
        [self invalidateTimer];
    }
}

#pragma mark - public method
- (void)startUpTimer {
    _durationTovalidity = 60;
    
    if (self.isEnabled) {
        self.enabled = NO;
    }
    
    [self setTitle:[NSString stringWithFormat:@"%.0f 秒", _durationTovalidity] forState:UIControlStateNormal];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(redrawTimer:) userInfo:nil repeats:YES];
}

- (void)invalidateTimer {
    if (!self.isEnabled) {
        self.enabled = YES;
    }
    
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - getters and setters
- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    
    UIColor *titleColor = [UIColor colorWithHexString:enabled ? @"0x3BBD79" : @"0xCCCCCC"];
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    
    if (enabled) {
        [self setTitle:@"发送验证码" forState:UIControlStateNormal];
    }
    else if ([self.titleLabel.text isEqualToString:@"发送验证码"]) {
        [self setTitle:@"正在发送..." forState:UIControlStateNormal];
    }
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(-10, 5, 0.5, CGRectGetHeight(self.bounds) - 2 * 5)];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"0xD8D8D8"];
    }
    return _lineView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
