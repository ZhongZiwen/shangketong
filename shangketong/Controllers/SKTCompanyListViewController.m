//
//  SKTCompanyListViewController.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/21.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTCompanyListViewController.h"
#import "UITableView+Expanded.h"
#import <TPKeyboardAvoidingTableView.h>
#import "SKTAppDelegate.h"
#import "SKTCompanyListCell.h"
#import "SKTSelectCompanyManager.h"

@interface SKTCompanyListViewController ()<UITableViewDataSource, UITableViewDelegate, SKTApiManagerParamSourceDelegate, SKTApiManagerApiCallBackDelegate, SKTApiManagerInterceptor>

@property (nonatomic, strong) TPKeyboardAvoidingTableView *tableView;
@property (nonatomic, strong) SKTSelectCompanyManager *selectCompanyManager;
@property (nonatomic, assign) NSInteger selecedIndex;
@end

@implementation SKTCompanyListViewController

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
    
    _selecedIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tenantsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SKTCompanyListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    NSDictionary *tempDict = _tenantsArray[indexPath.row];
    
    [cell configWithCompanyName:tempDict[@"name"]];
    
    if (indexPath.row == _selecedIndex) {
        cell.isSelected = YES;
    }
    else {
        cell.isSelected = NO;
    }
    
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10.0f];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selecedIndex = indexPath.row;
}

#pragma mark - SKTApiManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(SKTApiBaseManager *)manager {
    if (_tenantsArray.count < _selecedIndex) {
        return nil;
    }
    
    NSDictionary *tempDict = _tenantsArray[_selecedIndex];
    return @{@"tenantId" : tempDict[@"id"]};
}

#pragma mark - SKTApiManagerApiCallBackDelegate
- (void)managerCallApiDidSuccess:(SKTApiBaseManager *)manager {
    [self.view endLoading];
    NSDictionary *dataSource = [manager fetchDataWithReformer:nil];
    
    NSLog(@"dataSource = %@", dataSource);
    
    [((SKTAppDelegate *)[UIApplication sharedApplication].delegate) setupTabBarViewController
     ];
}

- (void)managerCallApiDidFailed:(SKTApiBaseManager *)manager {
    [self.view endLoading];
    
}

#pragma mark - SKTApiManagerInterceptor


#pragma mark - event response
- (void)loginButtonPress {
    [self.view beginLoading];
    [self.selectCompanyManager loadData];
}

#pragma mark - private method
- (UIView *)customizeHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 54)];
    
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.font = [UIFont systemFontOfSize:14];
    headerLabel.textAlignment = NSTextAlignmentLeft;
    headerLabel.textColor = [UIColor lightGrayColor];
    headerLabel.text = @"请选择要进入的公司";
    [headerView addSubview:headerLabel];
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width - 20, 20));
        make.left.mas_equalTo(10);
        make.bottom.equalTo(headerView).offset(-10);
    }];
    return headerView;
}

- (UIView *)customizeFooterView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 150)];
    
    CGFloat buttonHeight = 45.0f;
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.backgroundColor = [UIColor colorWithHexString:@"0x3bbc79"];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setTitle:@"进入首页" forState:UIControlStateNormal];
    loginButton.layer.cornerRadius = buttonHeight / 2;
    loginButton.layer.masksToBounds = YES;
    [loginButton addTarget:self action:@selector(loginButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:loginButton];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width - 2 * 20, buttonHeight));
        make.top.equalTo(footerView).offset(20);
        make.centerX.equalTo(footerView);
    }];
    
    return footerView;
}

#pragma mark - getters and getters
- (void)setSelecedIndex:(NSInteger)selecedIndex {
    if (_selecedIndex == selecedIndex) {
        return;
    }

    NSIndexPath *preIndexPath = [NSIndexPath indexPathForRow:_selecedIndex inSection:0];
    
    _selecedIndex = selecedIndex;
    
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:_selecedIndex inSection:0];
    
    [_tableView reloadRowsAtIndexPaths:@[preIndexPath, selectedIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (TPKeyboardAvoidingTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[SKTCompanyListCell class] forCellReuseIdentifier:kCellIdentifier];
    }
    return _tableView;
}

- (SKTSelectCompanyManager *)selectCompanyManager {
    if (!_selectCompanyManager) {
        _selectCompanyManager = [[SKTSelectCompanyManager alloc] init];
        _selectCompanyManager.delegate = self;
        _selectCompanyManager.paramSource = self;
        _selectCompanyManager.interceptor = self;
    }
    return _selectCompanyManager;
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
