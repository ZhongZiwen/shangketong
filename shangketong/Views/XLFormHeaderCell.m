//
//  XLFormHeaderCell.m
//  shangketong
//
//  Created by 钟必胜 on 16/3/26.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "XLFormHeaderCell.h"

NSString * const XLFormRowDescriptorTypeHeader = @"XLFormRowDescriptorTypeHeader";

@interface XLFormHeaderCell ()

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *companyLabel;
@end

@implementation XLFormHeaderCell

+ (void)load {
    [[XLFormViewController cellClassesForRowDescriptorTypes] setObject:[XLFormHeaderCell class]forKey:XLFormRowDescriptorTypeHeader];
}

- (void)configure {
    [super configure];

    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.contentView addSubview:self.headerImageView];
    [self.contentView addSubview:self.userNameLabel];
    [self.contentView addSubview:self.companyLabel];

    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(64, 64));
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView);
    }];
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.left.equalTo(_headerImageView.mas_right).offset(10);
        make.right.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView).offset(-10);
    }];
    [_companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.left.equalTo(_userNameLabel);
        make.right.equalTo(_userNameLabel);
        make.top.equalTo(_userNameLabel.mas_bottom).offset(5);
    }];
}

- (void)update {
    [super update];

    NSDictionary *valueDict = self.rowDescriptor.value;

    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:valueDict[@"image"]] placeholderImage:[UIImage imageNamed:@"user_icon_default_90"]];
    _userNameLabel.text = valueDict[@"name"];
    _companyLabel.text = valueDict[@"company"];
}

+ (CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
    return 80.0f;
}

#pragma mark - getters and setters
- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headerImageView.clipsToBounds = YES;
    }
    return _headerImageView;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.font = [UIFont systemFontOfSize:17];
        _userNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _userNameLabel;
}

- (UILabel *)companyLabel {
    if (!_companyLabel) {
        _companyLabel = [[UILabel alloc] init];
        _companyLabel.font = [UIFont systemFontOfSize:14];
        _companyLabel.textColor = [UIColor colorWithHexString:@"0x7A8C99"];
        _companyLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _companyLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
