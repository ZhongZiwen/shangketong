//
//  SKTRegisterNewCompanyViewController.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/23.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTRegisterNewCompanyViewController.h"
#import <TTTAttributedLabel.h>
#import "SKTWebViewController.h"
#import "SKTRegister.h"
#import "SKTRegisterCompanyManager.h"
#import "SKTAppDelegate.h"

static NSString *const kCompany = @"company";
static NSString *const kPosition = @"position";
static NSString *const kName = @"name";
static NSString *const kContact = @"contact";
static NSString *const kPassword = @"password";

@interface SKTRegisterNewCompanyViewController ()<TTTAttributedLabelDelegate, SKTApiManagerApiCallBackDelegate, SKTApiManagerParamSourceDelegate, SKTApiManagerInterceptor>

@property (nonatomic, strong) UIButton *commitButton;
@property (nonatomic, strong) UIButton *agreeButton;
@property (nonatomic, strong) TTTAttributedLabel *attributedLabel;
@property (nonatomic, assign) BOOL isAgreed;

@property (nonatomic, strong) SKTRegisterCompanyManager *registerCompanyManager;
@end

@implementation SKTRegisterNewCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = kBackgroundColor;

    _isAgreed = YES;
    
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

    if ([_aRegister.accountString containsString:@"@"]) {
        rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kContact rowType:XLFormRowDescriptorTypePhone title:@"手机号"];
    }
    else {
        rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kContact rowType:XLFormRowDescriptorTypeEmail title:@"邮箱"];
    }
    [rowDescriptor.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
    [rowDescriptor.cellConfigAtConfigure setObject:@"点击填写" forKey:@"textField.placeholder"];
    [sectionDescriptor addFormRow:rowDescriptor];

    if (_isFirstRegister) {
        sectionDescriptor = [XLFormSectionDescriptor formSection];
        [formDescriptor addFormSection:sectionDescriptor];
        rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kPassword rowType:XLFormRowDescriptorTypePassword title:@"密码"];
        [rowDescriptor.cellConfig setObject:@(NSTextAlignmentRight) forKey:@"textField.textAlignment"];
        [rowDescriptor.cellConfigAtConfigure setObject:@"请输入6~16位密码" forKey:@"textField.placeholder"];
        [sectionDescriptor addFormRow:rowDescriptor];
    }

    self.form = formDescriptor;

    self.tableView.tableFooterView = [self customizeFooterView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SKTApiManagerApiCallBackDelegate
- (void)managerCallApiDidSuccess:(SKTApiBaseManager *)manager {
    [self.view endLoading];
    NSDictionary *rawData = [manager fetchDataWithReformer:nil];

    [((SKTAppDelegate *) [UIApplication sharedApplication].delegate) setupTabBarViewController];
}

- (void)managerCallApiDidFailed:(SKTApiBaseManager *)manager {
    [self.view endLoading];
}

#pragma mark - SKTApiManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(SKTApiBaseManager *)manager {
    if (_isFirstRegister) {
        return [_aRegister paramsForFirstRegisterCompany];
    }

    return [_aRegister paramsForRegisterCompany];
}

#pragma mark - XLFormDescriptorDelegate
- (void)formRowDescriptorValueHasChanged:(XLFormRowDescriptor *)formRow oldValue:(id)oldValue newValue:(id)newValue {
    if ([formRow.tag isEqualToString:kCompany]) {
        self.aRegister.companyName = [newValue isEqual:[NSNull null]] ? nil : newValue;
    }
    else if ([formRow.tag isEqualToString:kPosition]) {
        self.aRegister.position = [newValue isEqual:[NSNull null]] ? nil : newValue;
    }
    else if ([formRow.tag isEqualToString:kName]) {
        self.aRegister.name = [newValue isEqual:[NSNull null]] ? nil : newValue;
    }
    else if ([formRow.tag isEqualToString:kContact]) {
        self.aRegister.emailOrPhone = [newValue isEqual:[NSNull null]] ? nil : newValue;
    }
    else if ([formRow.tag isEqualToString:kPassword]) {
        self.aRegister.registerCompanyPassword = [newValue isEqual:[NSNull null]] ? nil : newValue;
    }
}

#pragma mark - TTTAttributedLabelDelegate
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components {
    NSString *urlStr = @"http://app.sunke.com/user/service.jsf";
    SKTWebViewController *positionController = [SKTWebViewController webViewControllerWithUrlStr:urlStr];
    [self.navigationController pushViewController:positionController animated:YES];
}

#pragma mark - event response
- (void)commitButtonClicked {
    [self.view beginLoading];
    [self.registerCompanyManager loadData];
}

- (void)agreeButtonPress:(UIButton *)sender {
    if (self.isAgreed) {
        self.isAgreed = NO;
        [sender setImage:[UIImage imageNamed:@"multi_graph_normal"] forState:UIControlStateNormal];
    }
    else {
        self.isAgreed = YES;
        [sender setImage:[UIImage imageNamed:@"multi_graph_select"] forState:UIControlStateNormal];
    }
}

#pragma mark - private method
- (UIView *)customizeFooterView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 200)];

    [footerView addSubview:self.commitButton];
    [footerView addSubview:self.agreeButton];
    [footerView addSubview:self.attributedLabel];

    [_agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44.0f, 44.0f));
        make.left.equalTo(footerView).offset(10);
        make.top.equalTo(_commitButton.mas_bottom).offset(10);
    }];
    [_attributedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_agreeButton.mas_right);
        make.right.equalTo(footerView).offset(-15);
        make.height.mas_equalTo(20);
        make.centerY.equalTo(_agreeButton);
    }];

    if (_isFirstRegister) {
        RAC(self.commitButton, enabled) = [RACSignal combineLatest:@[RACObserve(self.aRegister, companyName),
                                                                     RACObserve(self.aRegister, position),
                                                                     RACObserve(self.aRegister, name),
                                                                     RACObserve(self.aRegister, emailOrPhone),
                                                                     RACObserve(self.aRegister, registerCompanyPassword),
                                                                     RACObserve(self, isAgreed)]
                                                            reduce:^id(NSString *companyName, NSString *position, NSString *name, NSString *emailOrPhone, NSString *password, NSNumber *isAgreed){
                                                                         return @((companyName && companyName.length > 0) && (position && position.length > 0) && (name && name.length > 0) && (emailOrPhone && emailOrPhone.length > 0) && (password && password.length >= 6 && password.length < 16) && [isAgreed integerValue]);
                                                                     }];
    }
    else {
        RAC(self.commitButton, enabled) = [RACSignal combineLatest:@[RACObserve(self.aRegister, companyName),
                                                                     RACObserve(self.aRegister, position),
                                                                     RACObserve(self.aRegister, name),
                                                                     RACObserve(self.aRegister, emailOrPhone),
                                                                     RACObserve(self, isAgreed)]
                                                            reduce:^id(NSString *companyName, NSString *position, NSString *name, NSString *emailOrPhone, NSNumber *isAgreed){
                                                                         return @((companyName && companyName.length > 0) && (position && position.length > 0) && (name && name.length > 0) && (emailOrPhone && emailOrPhone.length > 0) && [isAgreed integerValue]);
                                                                     }];
    }

    return footerView;
}

#pragma mark - getters and setters
- (UIButton *)commitButton {
    if (!_commitButton) {
        _commitButton = [UIButton buttonWithStyle:StrapSuccessStyle andTitle:@"提交资料" andFrame:CGRectMake(20, 0, kScreen_Width - 2 * 20, 45) target:self action:@selector(commitButtonClicked)];
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

- (SKTRegisterCompanyManager *)registerCompanyManager {
    if (!_registerCompanyManager) {
        _registerCompanyManager = [[SKTRegisterCompanyManager alloc] init];
        _registerCompanyManager.delegate = self;
        _registerCompanyManager.paramSource = self;
        _registerCompanyManager.interceptor = self;
    }
    return _registerCompanyManager;
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
