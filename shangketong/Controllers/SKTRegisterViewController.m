//
//  SKTRegisterViewController.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/17.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTRegisterViewController.h"
#import <TPKeyboardAvoidingTableView.h>
#import "UITableView+Expanded.h"
#import "SKTTextFieldCell.h"
#import "SKTRegister.h"
#import "SKTCaptchaManager.h"
#import "SKTCheckAccountManager.h"
#import "SKTRegisterNewCompanyViewController.h"
#import "SKTRegisterCompanyListViewController.h"
#import "SKTCaptchaHelpViewController.h"

@interface SKTRegisterViewController ()<UITableViewDataSource, UITableViewDelegate, SKTApiManagerApiCallBackDelegate, SKTApiManagerParamSourceDelegate, SKTApiManagerInterceptor>

@property (nonatomic, strong) TPKeyboardAvoidingTableView *tableView;
@property (nonatomic, strong) UIButton *commitButton;
@property (nonatomic, strong) SKTRegister *mRegister;
@property (nonatomic, strong) SKTCaptchaManager *captchaManager;
@property (nonatomic, strong) SKTCheckAccountManager *checkAccountManager;
@end

@implementation SKTRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kBackgroundColor;
    
    if (_type == SKTRegisterViewControllerTypeRegister) {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPress)];
        self.navigationItem.leftBarButtonItem = backButton;
    }
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _tableView.tableHeaderView = [self customizeHeaderView];
    _tableView.tableFooterView = [self customizeFooterView];
    
    [self initBottomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier;
    if (indexPath.row) {
        cellIdentifier = kCellIdentifier_captcha;
    }
    else {
        cellIdentifier = kCellIdentifier_text;
    }
    
    __weak typeof(self) weak_self = self;
    SKTTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (indexPath.row) {
        [cell setPlaceholder:@"验证码" value:nil];
        cell.textValueChangedBlock = ^(NSString *valueStr) {
            weak_self.mRegister.captchaString = valueStr;
        };
    }
    else {
        [cell setPlaceholder:@"手机号/邮箱" value:nil];
        cell.textValueChangedBlock = ^(NSString *valueStr) {
            weak_self.mRegister.accountString = valueStr;
        };
    }
    
    cell.captchaButtonClickBlock = ^(SKTCaptchaButton *btn) {
        btn.enabled = NO;
        [weak_self.captchaManager loadData];
    };
    
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kLoginPaddingLeftWidth];
    return cell;
}

#pragma mark - SKTApiManagerApiCallBackDelegate
- (void)managerCallApiDidSuccess:(SKTApiBaseManager *)manager {
    if (manager == self.captchaManager) {
        id sourceData = [manager fetchDataWithReformer:nil];
        if (![sourceData integerValue]) {
            [NSObject showHudTipStr:@"验证码发送成功"];
            SKTTextFieldCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            [cell.captchaButton startUpTimer];
        }
        else {
            [NSObject showHudTipStr:@"验证码发送失败,请重试"];
            SKTTextFieldCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            [cell.captchaButton invalidateTimer];
        }

        return;
    }
    
    [self.view endLoading];
    NSDictionary *rawData = [manager fetchDataWithReformer:nil];
    if (![rawData[@"result"] integerValue]) {  // 初始化,新建公司
        SKTRegisterNewCompanyViewController *newCompanyController = [[SKTRegisterNewCompanyViewController alloc] init];
        newCompanyController.title = @"初识设置";
        newCompanyController.isFirstRegister = YES;
        newCompanyController.aRegister = _mRegister;
        [self.navigationController pushViewController:newCompanyController animated:YES];
    }
    else if ([rawData[@"result"] integerValue] == 2) {  // 注册账号已存在，显示公司列表
        SKTRegisterCompanyListViewController *companyListController = [[SKTRegisterCompanyListViewController alloc] init];
        companyListController.title = @"账号已存在";
        companyListController.mRegister = _mRegister;
        companyListController.companyListArray = [rawData[@"companyList"] copy];
        [self.navigationController pushViewController:companyListController animated:YES];
    }
}

- (void)managerCallApiDidFailed:(SKTApiBaseManager *)manager {
    if (manager == self.captchaManager) {
        SKTTextFieldCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        [cell.captchaButton invalidateTimer];
        return;
    }
    
    [self.view endLoading];
}

#pragma mark - SKTApiManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(SKTApiBaseManager *)manager {
    if (manager == self.captchaManager) {
        return @{@"accountName" : self.mRegister.accountString};
    }
    
    return [self.mRegister params];
}

#pragma mark - SKTApiManagerInterceptor


#pragma mark - event response
- (void)backButtonPress {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)commitButtonPress {
    [self.view endEditing:YES];
    [self.view beginLoading];
    [self.checkAccountManager loadData];
}

- (void)helpButtonPress {
    SKTCaptchaHelpViewController *captchaHelpController = [[SKTCaptchaHelpViewController alloc] init];
    captchaHelpController.title = @"未收到验证短信/邮件";
    [self.navigationController pushViewController:captchaHelpController animated:YES];
}

#pragma mark - private method
- (UIView *)customizeHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.15 * kScreen_Height)];
    
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.font = [UIFont systemFontOfSize:14];
    headerLabel.textAlignment = NSTextAlignmentLeft;
    headerLabel.text = @"登录时的个人账号";
    [headerView addSubview:headerLabel];
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width - 30, 20));
        make.left.mas_equalTo(15);
        make.bottom.equalTo(headerView).offset(-10);
    }];
    return headerView;
}

- (UIView *)customizeFooterView {
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 150)];

    [footerView addSubview:self.commitButton];
    RAC(self.commitButton, enabled) = [RACSignal combineLatest:@[RACObserve(self.mRegister, accountString), RACObserve(self.mRegister, captchaString)] reduce:^id(NSString *accountString, NSString *captchaString) {
        return @((accountString && accountString.length > 0) && (captchaString && captchaString.length > 0));
    }];
    
    return footerView;
}

- (void)initBottomView {
    UIView *bottomView = [[UIView alloc] init];
    [self.view addSubview:bottomView];
    
    UIButton *helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    helpButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [helpButton setTitleColor:[UIColor colorWithHexString:@"0x8899a6"] forState:UIControlStateNormal];
    [helpButton setTitle:@"长时间未收到验证码,请点击此处" forState:UIControlStateNormal];
    [helpButton addTarget:self action:@selector(helpButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:helpButton];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, 54));
        make.bottom.equalTo(self.view);
    }];
    [helpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(220, 44));
        make.top.equalTo(bottomView).offset(5);
        make.centerX.equalTo(bottomView);
    }];
}

#pragma mark - getters and setters
- (TPKeyboardAvoidingTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[SKTTextFieldCell class] forCellReuseIdentifier:kCellIdentifier_text];
        [_tableView registerClass:[SKTTextFieldCell class] forCellReuseIdentifier:kCellIdentifier_captcha];
    }
    return _tableView;
}

- (UIButton *)commitButton {
    if (!_commitButton) {
        _commitButton = [UIButton buttonWithStyle:StrapSuccessStyle andTitle:@"提交" andFrame:CGRectMake(20, 20, kScreen_Width - 2 * 20, 45) target:self action:@selector(commitButtonPress)];
    }
    return _commitButton;
}

- (SKTRegister *)mRegister {
    if (!_mRegister) {
        _mRegister = [[SKTRegister alloc] init];
    }
    return _mRegister;
}

- (SKTCaptchaManager *)captchaManager {
    if (!_captchaManager) {
        _captchaManager = [[SKTCaptchaManager alloc] init];
        _captchaManager.delegate = self;
        _captchaManager.paramSource = self;
        _captchaManager.interceptor = self;
    }
    return _captchaManager;
}

- (SKTCheckAccountManager *)checkAccountManager {
    if (!_checkAccountManager) {
        _checkAccountManager = [[SKTCheckAccountManager alloc] init];
        _checkAccountManager.delegate = self;
        _checkAccountManager.paramSource = self;
        _checkAccountManager.interceptor = self;
    }
    return _checkAccountManager;
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
