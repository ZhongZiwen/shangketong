//
//  SKTCompanyListCell.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/21.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTCompanyListCell.h"

@interface SKTCompanyListCell ()

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *accessoryImageView;
@end

@implementation SKTCompanyListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.headerImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.accessoryImageView];
        [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.left.equalTo(self.contentView).offset(10);
            make.centerY.equalTo(self.contentView);
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headerImageView.mas_right).offset(10);
            make.right.equalTo(self.contentView).offset(-30);
            make.height.mas_equalTo(20);
            make.centerY.equalTo(self.contentView);
        }];
        
        if ([reuseIdentifier isEqualToString:kCellIdentifier_login]) {
            [_accessoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                UIImage *image = [UIImage imageNamed:@"quickSelect_gray"];
                make.size.mas_equalTo(CGSizeMake(image.size.width, image.size.height));
                make.centerX.equalTo(self.contentView.mas_right).offset(-15);
                make.centerY.equalTo(self.contentView);
            }];
        }
        else if ([reuseIdentifier isEqualToString:kCellIdentifier_register]) {
            UIImage *image = [UIImage imageNamed:@"activity_Arrow"];
            _accessoryImageView.image = image;
            [_accessoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(image.size.width, image.size.height));
                make.centerX.equalTo(self.contentView.mas_right).offset(-15);
                make.centerY.equalTo(self.contentView);
            }];
        }
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - public method
- (void)configWithCompanyName:(NSString *)name {
    _titleLabel.text = name;
}

- (void)configForLoginWithCompanyName:(NSString *)name isSelected:(BOOL)isSelected {
    _titleLabel.text = name;
    
    if (isSelected) {
        _accessoryImageView.image = [UIImage imageNamed:@"quickSelect_blue"];
    }
    else {
        _accessoryImageView.image = [UIImage imageNamed:@"quickSelect_gray"];
    }
}

#pragma mark - getters and setters
- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tenant_icon"]];
        _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headerImageView.clipsToBounds = YES;
    }
    return _headerImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIImageView *)accessoryImageView {
    if (!_accessoryImageView) {
        _accessoryImageView = [[UIImageView alloc] init];
    }
    return _accessoryImageView;
}

@end
