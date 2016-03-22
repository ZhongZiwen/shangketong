//
//  SKTTextFieldCell.h
//  shangketong
//
//  Created by sungoin-zbs on 16/3/17.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#define kCellIdentifier_text @"SKTTextFieldCell_text"
#define kCellIdentifier_password @"SKTTextFieldCell_password"
#define kCellIdentifier_captcha @"SKTTextFieldCell_captcha"

#import <UIKit/UIKit.h>
#import "SKTCaptchaButton.h"

@interface SKTTextFieldCell : UITableViewCell

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) SKTCaptchaButton *captchaButton;  // 获取验证码
@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, copy) void(^textValueChangedBlock) (NSString *);
@property (nonatomic, copy) void(^textValueEditDidBeginBlock) (NSString *);
@property (nonatomic, copy) void(^textValueEditDidEndBlock) (NSString *);
@property (nonatomic, copy) void(^captchaButtonClickBlock) (SKTCaptchaButton *);

- (void)setPlaceholder:(NSString *)placeholder value:(NSString *)value;
@end
