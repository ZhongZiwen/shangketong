//
//  SKTRegisterCompanyListViewController.m
//  shangketong
//
//  Created by 钟必胜 on 16/3/23.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTRegisterCompanyListViewController.h"
#import <TPKeyboardAvoidingTableView.h>
#import "UITableView+Expanded.h"
#import "SKTAppDelegate.h"
#import "SKTCompanyListCell.h"
#import "SKTRegister.h"
#import "SKTRegisterNewCompanyViewController.h"
#import "SKTLoginManager.h"
#import "SKTCheckAccountLoginManager.h"

@interface SKTRegisterCompanyListViewController ()<UITableViewDataSource, UITableViewDelegate, SKTApiManagerApiCallBackDelegate, SKTApiManagerParamSourceDelegate, SKTApiManagerInterceptor>

@property (nonatomic, strong) TPKeyboardAvoidingTableView *tableView;
@property (nonatomic, strong) UIAlertView *alertView;
@property (nonatomic, strong) SKTLoginManager *loginManager;
@property (nonatomic, strong) SKTCheckAccountLoginManager *checkAccountLoginManager;
@end

@implementation SKTRegisterCompanyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kBackgroundColor;
    
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
    return _companyListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SKTCompanyListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_register forIndexPath:indexPath];
    
    NSDictionary *tempDict = _companyListArray[indexPath.row];
    [cell configWithCompanyName:tempDict[@"name"]];
    
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10.0f];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *tempDict = _companyListArray[indexPath.row];
    _mRegister.companyId = [NSString stringWithFormat:@"%@", tempDict[@"id"]];
    
    __weak typeof(self) weak_self = self;
    UIAlertController *alerController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"进入%@", tempDict[@"name"]] message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confireAction = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *passwordTextField = alerController.textFields.firstObject;
        self.mRegister.password = passwordTextField.text;
        
        // 登录请求
        [weak_self.view beginLoading];
        [weak_self.loginManager loadData];
    }];
    [alerController addAction:cancelAction];
    [alerController addAction:confireAction];
    __weak typeof(alerController) weak_alerController = alerController;
    [alerController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入密码";
        textField.secureTextEntry = YES;
        
        RAC(weak_alerController.actions.lastObject, enabled) = [RACSignal combineLatest:@[textField.rac_textSignal] reduce:^id(NSString *password) {
            return @(password && password.length > 0);
        }];
    }];
    [self presentViewController:alerController animated:YES completion:nil];
}

#pragma mark - SKTApiManagerApiCallBackDelegate
- (void)managerCallApiDidSuccess:(SKTApiBaseManager *)manager {
    [self.view endLoading];
    if (manager == self.loginManager) {
        NSDictionary *rawData = [manager fetchDataWithReformer:nil];
        NSLog(@"登录信息 = %@", rawData);
        [((SKTAppDelegate *)[UIApplication sharedApplication].delegate) setupTabBarViewController
         ];
    }
    else if (manager == self.checkAccountLoginManager) {
        
        id rawData = [manager fetchDataWithReformer:nil];
        NSLog(@"创建公司前的登录信息 = %@", rawData);
        if (![rawData integerValue]) {
            SKTRegisterNewCompanyViewController *newCompanyViewController = [[SKTRegisterNewCompanyViewController alloc] init];
            newCompanyViewController.title = @"创建公司";
            newCompanyViewController.aRegister = _mRegister;
            [self.navigationController pushViewController:newCompanyViewController animated:YES];
        }
        else {  // 登录失败
            [NSObject showHudTipStr:@"登录失败,请重试!"];
        }
    }
}

- (void)managerCallApiDidFailed:(SKTApiBaseManager *)manager {
    [self.view endLoading];

}

#pragma mark - SKTApiManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(SKTApiBaseManager *)manager {
    if (manager == self.loginManager) {
        return @{@"tenantId" : _mRegister.companyId,
                 @"accountName" : _mRegister.accountString,
                 @"password" : _mRegister.password};
    }
    else if (manager == self.checkAccountLoginManager) {
        return @{@"accountName" : _mRegister.accountString,
                 @"password" : _mRegister.checkAccountLoginPassword};
    }

    return nil;
}

#pragma mark - event response
- (void)newCompanyButtonClicked {

    __weak typeof(self) weak_self = self;
    UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"提示" message:@"创建之前请先登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confireAction = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *passwordTextField = alerController.textFields.lastObject;
        weak_self.mRegister.checkAccountLoginPassword = passwordTextField.text;
        
        // 登录
        [weak_self.view beginLoading];
        [weak_self.checkAccountLoginManager loadData];
    }];
    [alerController addAction:cancelAction];
    [alerController addAction:confireAction];
    [alerController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.text = weak_self.mRegister.accountString;
        textField.enabled = NO;
    }];
    __weak typeof(alerController) weak_alerController = alerController;
    [alerController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入密码";
        textField.secureTextEntry = YES;
        
        RAC(weak_alerController.actions.lastObject, enabled) = [RACSignal combineLatest:@[textField.rac_textSignal] reduce:^id(NSString *password) {
            return @(password && password.length > 0);
        }];
    }];
    [self presentViewController:alerController animated:YES completion:nil];
}

#pragma mark - private method
- (UIView *)customizeHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.15 * kScreen_Height)];
    
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.font = [UIFont systemFontOfSize:14];
    headerLabel.textColor = [UIColor lightGrayColor];
    headerLabel.textAlignment = NSTextAlignmentLeft;
    headerLabel.numberOfLines = 0;
    headerLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ 已经是商客通用户并属于以下公司，是否要直接登录？", _mRegister.accountString]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0x3bbc79"] range:NSMakeRange(0, _mRegister.accountString.length)];
    headerLabel.attributedText = str;
    [headerView addSubview:headerLabel];
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.equalTo(headerView).offset(-10);
        make.bottom.equalTo(headerView).offset(-10);
    }];
    [headerLabel sizeToFit];

    return headerView;
}

- (UIView *)customizeFooterView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 150)];
    
    UIButton *newCompanyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    newCompanyButton.backgroundColor = [UIColor colorWithHexString:@"0x3bbc79"];
    newCompanyButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [newCompanyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [newCompanyButton setTitle:@"创建新公司" forState:UIControlStateNormal];
    newCompanyButton.layer.cornerRadius = 45 / 2;
    newCompanyButton.layer.masksToBounds = YES;
    [newCompanyButton addTarget:self action:@selector(newCompanyButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:newCompanyButton];
    
    [newCompanyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width - 2 * 20, 45));
        make.top.equalTo(footerView).offset(20);
        make.centerX.equalTo(footerView);
    }];
    
    return footerView;
}

#pragma mark - getters and setters
- (TPKeyboardAvoidingTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[SKTCompanyListCell class] forCellReuseIdentifier:kCellIdentifier_register];
        
    }
    return _tableView;
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

- (SKTCheckAccountLoginManager *)checkAccountLoginManager {
    if (!_checkAccountLoginManager) {
        _checkAccountLoginManager = [[SKTCheckAccountLoginManager alloc] init];
        _checkAccountLoginManager.delegate = self;
        _checkAccountLoginManager.paramSource = self;
        _checkAccountLoginManager.interceptor = self;
    }
    return _checkAccountLoginManager;
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
