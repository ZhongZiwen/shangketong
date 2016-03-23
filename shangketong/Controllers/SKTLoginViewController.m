//
//  SKTLoginViewController.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/17.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTLoginViewController.h"
#import <TPKeyboardAvoidingTableView.h>
#import "SKTTextFieldCell.h"
#import "SKTRegisterViewController.h"
#import "SKTLoginManager.h"
#import "SKTLogin.h"
#import "SKTLoginReformer.h"
#import "SKTCompanyListViewController.h"

@interface SKTLoginViewController ()<UITableViewDataSource, UITableViewDelegate, SKTApiManagerApiCallBackDelegate, SKTApiManagerParamSourceDelegate, SKTApiManagerInterceptor>

@property (nonatomic, strong) TPKeyboardAvoidingTableView *tableView;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) SKTLoginManager *loginManager;
@property (nonatomic, strong) SKTLogin *login;
@property (nonatomic, strong) SKTLoginReformer *loginReformer;
@end

@implementation SKTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kBackgroundColor;
    
    _login = [[SKTLogin alloc] init];

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPress)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _tableView.tableHeaderView = [self customizeHeaderView];
    _tableView.tableFooterView = [self customizeFooterView];
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
    SKTTextFieldCell *cell;
    
    __weak typeof(self) weak_self = self;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_text forIndexPath:indexPath];
        cell.isLogin = YES;
        [cell setPlaceholder:@" 手机号码/电子邮箱" value:_login.userName];
        cell.textValueChangedBlock = ^(NSString *text) {
            weak_self.login.userName = text;
        };
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_password forIndexPath:indexPath];
        cell.isLogin = YES;
        cell.textField.secureTextEntry = YES;
        [cell setPlaceholder:@" 密码" value:_login.password];
        cell.textValueChangedBlock = ^(NSString *text) {
            weak_self.login.password = text;
        };
    }
    
    return cell;
}

#pragma mark - SKTApiManagerApiCallBackDelegate
- (void)managerCallApiDidSuccess:(SKTApiBaseManager *)manager {
    [self.view endLoading];
    NSDictionary *reformedData = [manager fetchDataWithReformer:self.loginReformer];
    
    SKTCompanyListViewController *companyListController = [[SKTCompanyListViewController alloc] init];
    companyListController.title = @"选择公司";
    companyListController.tenantsArray = reformedData[@"tenants"];
    [self.navigationController pushViewController:companyListController animated:YES];
}

- (void)managerCallApiDidFailed:(SKTApiBaseManager *)manager {
    [self.view endLoading];
}

#pragma mark - SKTApiManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(SKTApiBaseManager *)manager {
    return [_login params];
}

#pragma mark - SKTApiManagerInterceptor


#pragma mark - event response
- (void)backButtonPress {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loginButtonPress {
    [self.view beginLoading];
    [self.loginManager loadData];
}

- (void)findPasswordButtonPress {
    SKTRegisterViewController *findPasswordController = [[SKTRegisterViewController alloc] init];
    findPasswordController.title = @"找回密码";
    findPasswordController.type = SKTRegisterViewControllerTypeFindPassword;
    [self.navigationController pushViewController:findPasswordController animated:YES];
}

#pragma mark - private method
- (UIView *)customizeHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height / 5)];
    
    UIImageView *headerImageView = [[UIImageView alloc] init];
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    headerImageView.layer.cornerRadius = 74 / 2;
    headerImageView.layer.borderWidth = 2;
    headerImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    headerImageView.layer.masksToBounds = YES;
    [headerView addSubview:headerImageView];
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(74, 74));
        make.centerX.equalTo(headerView);
        make.centerY.equalTo(headerView);
    }];
    
    headerImageView.image = [UIImage imageNamed:@"user_icon_default_90"];
    
    return headerView;
}

- (UIView *)customizeFooterView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 150)];
    
    [footerView addSubview:self.loginButton];
    RAC(self.loginButton, enabled) = [RACSignal combineLatest:@[RACObserve(self.login, userName), RACObserve(self.login, password)] reduce:^id(NSString *userName, NSString *password) {
        return @((userName && userName.length > 0) && (password && password.length > 0));
    }];
    
    // 忘记密码
    UIButton *findPsdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    findPsdButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [findPsdButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [findPsdButton setTitle:@"找回密码" forState:UIControlStateNormal];
    [findPsdButton addTarget:self action:@selector(findPasswordButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:findPsdButton];
    [findPsdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.centerX.equalTo(footerView);
        make.top.equalTo(_loginButton.mas_bottom).offset(20);
    }];
    
    return footerView;
}

#pragma mark - setters and getters
- (TPKeyboardAvoidingTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[SKTTextFieldCell class] forCellReuseIdentifier:kCellIdentifier_text];
        [_tableView registerClass:[SKTTextFieldCell class] forCellReuseIdentifier:kCellIdentifier_password];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithStyle:StrapSuccessStyle andTitle:@"登录" andFrame:CGRectMake(20, 20, kScreen_Width - 2 * 20, 45) target:self action:@selector(loginButtonPress)];
    }
    return _loginButton;
}

- (SKTLoginManager *)loginManager {
    if (!_loginManager) {
        _loginManager = [[SKTLoginManager alloc] init];
        _loginManager.delegate = self;
        _loginManager.paramSource = self;
        _loginManager.interceptor = self;
    }
    return _loginManager;
}

- (SKTLoginReformer *)loginReformer {
    if (!_loginReformer) {
        _loginReformer = [[SKTLoginReformer alloc] init];
    }
    return _loginReformer;
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
