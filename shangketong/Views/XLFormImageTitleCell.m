//
//  XLFormImageTitleCell.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/25.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "XLFormImageTitleCell.h"

NSString * const XLFormRowDescriptorTypeCustomImageTitle = @"XLFormRowDescriptorTypeCustomImageTitle";

@interface XLFormImageTitleCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation XLFormImageTitleCell

+ (void)load {
    [[XLFormViewController cellClassesForRowDescriptorTypes] setObject:[XLFormImageTitleCell class] forKey:XLFormRowDescriptorTypeCustomImageTitle];
}

- (void)configure {
    [super configure];

    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLabel];

    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView.mas_right).offset(10);
        make.height.mas_equalTo(20);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)update {
    [super update];

    NSDictionary *valueDict = self.rowDescriptor.value;

    _iconImageView.image = [UIImage imageNamed:valueDict[@"image"]];
    _titleLabel.text = valueDict[@"title"];
}

#pragma mark - getters and setters
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        UIImage *image = [UIImage imageNamed:@"menu_item_campaign"];
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
