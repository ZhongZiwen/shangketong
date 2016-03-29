//
//  SKTActivityTableViewCell.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/28.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTActivityTableViewCell.h"

@interface SKTActivityTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation SKTActivityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self.contentView addSubview:self.titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.equalTo(self.contentView).offset(15.0f);
            make.right.equalTo(self.contentView).offset(-15.0f);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)configWithDictionary:(NSDictionary *)dict {
    _titleLabel.text = [NSString stringWithFormat:@"%@", dict[@"name"]];
}

#pragma mark - getters and setters
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
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
