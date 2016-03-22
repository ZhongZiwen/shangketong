//
//  SKTTextFieldCell.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/17.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTTextFieldCell.h"

@interface SKTTextFieldCell ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *passwordButton;         // 密码可见过不可见
@end

@implementation SKTTextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.textField];
        
        if ([reuseIdentifier isEqualToString:kCellIdentifier_text]) {
            [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(20);
                make.left.equalTo(self.contentView).offset(kLoginPaddingLeftWidth);
                make.right.equalTo(self.contentView).offset(-kLoginPaddingLeftWidth);
                make.centerY.equalTo(self.contentView);
            }];
        }
        else if ([reuseIdentifier isEqualToString:kCellIdentifier_password]) {
            
            [self.contentView addSubview:self.passwordButton];
            [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(20);
                make.left.equalTo(self.contentView).offset(kLoginPaddingLeftWidth);
                make.right.equalTo(_passwordButton).offset(-kPaddingLeftWidth);
                make.centerY.equalTo(self.contentView);
            }];
            [_passwordButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(44, 44));
                make.right.equalTo(self.contentView).offset(-kLoginPaddingLeftWidth);
                make.centerY.equalTo(self.contentView);
            }];
        }
        else if ([reuseIdentifier isEqualToString:kCellIdentifier_captcha]) {
            
            [self.contentView addSubview:self.captchaButton];
            [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(20);
                make.left.equalTo(self.contentView).offset(kLoginPaddingLeftWidth);
                make.right.equalTo(_captchaButton).offset(-kPaddingLeftWidth);
                make.centerY.equalTo(self.contentView);
            }];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_isLogin) {
        [self.contentView addSubview:self.lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.equalTo(self.contentView).offset(kLoginPaddingLeftWidth);
            make.right.equalTo(self.contentView).offset(-kLoginPaddingLeftWidth);
            make.bottom.equalTo(self.contentView);
        }];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - event response
- (void)textValueEditDidBegin:(UITextField *)sender {
    if (self.textValueEditDidBeginBlock) {
        self.textValueEditDidBeginBlock(self.textField.text);
    }
}

- (void)textValueChanged:(UITextField *)sender {
    if (self.textValueChangedBlock) {
        self.textValueChangedBlock(self.textField.text);
    }
}

- (void)textValueEditDidEnd:(UITextField *)sender {
    if (self.textValueEditDidEndBlock) {
        self.textValueEditDidEndBlock(self.textField.text);
    }
}

- (void)passwordButtonClicked:(UIButton *)sender {
    _textField.secureTextEntry = !_textField.secureTextEntry;
    [sender setImage:[UIImage imageNamed:_textField.secureTextEntry? @"password_unlook": @"password_look"] forState:UIControlStateNormal];
}

- (void)captchaButtonClick:(SKTCaptchaButton *)sender {
    if (self.captchaButtonClickBlock) {
        self.captchaButtonClickBlock(sender);
    }
}

#pragma mark - public method
- (void)setPlaceholder:(NSString *)placeholder value:(NSString *)value {
    _textField.placeholder = placeholder;
    _textField.text = value;
}

#pragma mark - getters and setters
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = [UIFont systemFontOfSize:17];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_textField addTarget:self action:@selector(textValueEditDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
        [_textField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
        [_textField addTarget:self action:@selector(textValueEditDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    }
    return _textField;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"0xdddddd"];
    }
    return _lineView;
}

- (UIButton *)passwordButton {
    if (!_passwordButton) {
        _passwordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_passwordButton setImage:[UIImage imageNamed:@"password_unlook"] forState:UIControlStateNormal];
        [_passwordButton addTarget:self action:@selector(passwordButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _passwordButton;
}

- (SKTCaptchaButton *)captchaButton {
    if (!_captchaButton) {
        _captchaButton = [[SKTCaptchaButton alloc] initWithFrame:CGRectMake(kScreen_Width - 80 - kLoginPaddingLeftWidth, (CGRectGetHeight(self.contentView.bounds) - 25) / 2, 80, 25)];
        _captchaButton.backgroundColor = [UIColor whiteColor];
        [_captchaButton addTarget:self action:@selector(captchaButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _captchaButton;
}

@end
