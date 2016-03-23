//
//  SKTRegisterNewCompanyViewController.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/23.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTRegisterNewCompanyViewController.h"
#import <XLForm.h>
#import <TTTAttributedLabel.h>
#import "SKTWebViewController.h"

static NSString *const kCompany = @"company";
static NSString *const kPosition = @"position";
static NSString *const kName = @"name";
static NSString *const kPhone = @"phone";
static NSString *const kEmail = @"email";
static NSString *const kPassword = @"password";

@interface SKTRegisterNewCompanyViewController ()<TTTAttributedLabelDelegate>

@property (nonatomic, strong) UIButton *commitButton;
@property (nonatomic, strong) UIButton *agreeButton;
@property (nonatomic, strong) TTTAttributedLabel *attributedLabel;
@end

@implementation SKTRegisterNewCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = kBackgroundColor;

    XLFormDescriptor *formDescriptor = [XLFormDescriptor formDescriptor];

    XLFormSectionDescriptor *sectionDescriptor = [XLFormSectionDescriptor formSectionWithTitle:@"填写真实材料，让您的同事更容易找到您。"];
    [formDescriptor addFormSection:sectionDescriptor];

    XLFormRowDescriptor *rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kCompany rowType:XLFormRowDescriptorTypeText title:@"公司名"];
    [rowDescriptor.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [rowDescriptor.cellConfigAtConfigure setObject:@"点击填写" forKey:@"textField.placeholder"];
    [sectionDescriptor addFormRow:rowDescriptor];

    rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kPosition rowType:XLFormRowDescriptorTypeText title:@"职务"];
    [rowDescriptor.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [rowDescriptor.cellConfigAtConfigure setObject:@"点击填写" forKey:@"textField.placeholder"];
    [sectionDescriptor addFormRow:rowDescriptor];

    rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kName rowType:XLFormRowDescriptorTypeText title:@"姓名"];
    [rowDescriptor.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [rowDescriptor.cellConfigAtConfigure setObject:@"点击填写" forKey:@"textField.placeholder"];
    [sectionDescriptor addFormRow:rowDescriptor];

    if (_isFirstRegister) {
        sectionDescriptor = [XLFormSectionDescriptor formSection];
        [formDescriptor addFormSection:sectionDescriptor];
        rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kPassword rowType:XLFormRowDescriptorTypePassword title:@"密码"];
        [rowDescriptor.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
        rowDescriptor.noValueDisplayText = @"请输入6~16位密码";
        [sectionDescriptor addFormRow:rowDescriptor];
    }

    self.form = formDescriptor;

    self.tableView.tableFooterView = [self customizeFooterView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TTTAttributedLabelDelegate
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components {
    NSString *urlStr = @"http://app.sunke.com/user/service.jsf";
    SKTWebViewController *positionController = [SKTWebViewController webViewControllerWithUrlStr:urlStr];
    [self.navigationController pushViewController:positionController animated:YES];
}

#pragma mark - event response
- (void)commitButtonClicked {

}

- (void)agreeButtonPress:(UIButton *)sender {

}

#pragma mark - private method
- (UIView *)customizeFooterView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 200)];

    [footerView addSubview:self.commitButton];
    [footerView addSubview:self.agreeButton];
    [footerView addSubview:self.attributedLabel];

    [_commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width - 2 * 20, 45));
        make.top.equalTo(footerView);
        make.centerX.equalTo(footerView);
    }];
    [_agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44.0f, 44.0f));
        make.left.equalTo(footerView).offset(10);
        make.top.equalTo(_commitButton.mas_bottom).offset(10);
    }];
    [_attributedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_agreeButton.mas_right);
        make.right.equalTo(footerView).offset(-15);
        make.height.mas_equalTo(10);
        make.centerY.equalTo(_agreeButton);
    }];

    return footerView;
}

#pragma mark - getters and setters
- (UIButton *)commitButton {
    if (!_commitButton) {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitButton.backgroundColor = [UIColor colorWithHexString:@"0x3bbc79"];
        _commitButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitButton setTitle:@"提交资料" forState:UIControlStateNormal];
        _commitButton.layer.cornerRadius = 45 / 2;
        _commitButton.layer.masksToBounds = YES;
        [_commitButton addTarget:self action:@selector(commitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}

- (UIButton *)agreeButton {
    if (!_agreeButton) {
        _agreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_agreeButton setImage:[UIImage imageNamed:@"multi_graph_select"] forState:UIControlStateNormal];
        [_agreeButton addTarget:self action:@selector(agreeButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _agreeButton;
}

- (TTTAttributedLabel *)attributedLabel {
    if (!_attributedLabel) {
        _attributedLabel = [[TTTAttributedLabel alloc] init];
        _attributedLabel.delegate = self;
        _attributedLabel.font = [UIFont systemFontOfSize:13];
        _attributedLabel.textColor = [UIColor darkGrayColor];
        _attributedLabel.linkAttributes = kLinkAttributes;
        _attributedLabel.activeLinkAttributes = kLinkAttributesActive;
        _attributedLabel.text = @"已阅读并同意：商客通使用条款";
        NSRange range = [_attributedLabel.text rangeOfString:@"商客通使用条款"];
        [_attributedLabel addLinkToTransitInformation:nil withRange:range];
    }
    return _attributedLabel;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
