//
//  SKTActivityViewController.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/28.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTActivityViewController.h"
#import "SKTCRMInitDataManager.h"
#import "SKTCRMIndexManager.h"
#import "SKTCRMFilterManager.h"
#import "SKTCRMListManager.h"
#import "SKTActivityTableViewCell.h"

@interface SKTActivityViewController ()<SKTApiManagerApiCallBackDelegate, SKTApiManagerParamSourceDelegate, SKTApiManagerInterceptor, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) SKTCRMInitDataManager *initializeDataManager;
@property (nonatomic, strong) SKTCRMIndexManager *indexManager;
@property (nonatomic, strong) SKTCRMFilterManager *filterManager;
@property (nonatomic, strong) SKTCRMListManager *listManager;
@end

@implementation SKTActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBackgroundColor;

    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    [self.initializeDataManager loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SKTActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];

    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];


}

#pragma mark - SKTApiManagerApiCallBackDelegate
- (void)managerCallApiDidSuccess:(SKTApiBaseManager *)manager {

    if (manager == _initializeDataManager) {
        [self.listManager loadData];
    }
    else if (manager == _indexManager) {

    }
    else if (manager == _filterManager) {

    }
    else if (manager == _listManager) {
        NSDictionary *rawData = [manager fetchDataWithReformer:nil];
        NSLog(@"rawData = %@", rawData);
    }
}

- (void)managerCallApiDidFailed:(SKTApiBaseManager *)manager {

}

#pragma mark - SKTApiManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(SKTApiBaseManager *)manager {
    if (manager == _initializeDataManager) {
        return nil;
    }
    else if (manager == _listManager) {
        return nil;
    }
    
    return nil;
}

#pragma mark - SKTApiManagerInterceptor
- (void)manager:(SKTApiBaseManager *)manager beforePerformSuccessWithResponse:(SKTURLResponse *)response {
    
}

#pragma mark - getters and setters
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = kTableViewSeparatorColor;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.rowHeight = 54.0f;
        [_tableView registerClass:[SKTActivityTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    }
    return _tableView;
}

- (SKTCRMInitDataManager *)initializeDataManager {
    if (!_initializeDataManager) {
        _initializeDataManager = [[SKTCRMInitDataManager alloc] init];
        _initializeDataManager.delegate = self;
        _initializeDataManager.paramSource = self;
        _initializeDataManager.interceptor = self;
    }
    return _initializeDataManager;
}

- (SKTCRMListManager *)listManager {
    if (!_listManager) {
        _listManager = [[SKTCRMListManager alloc] init];
        _listManager.delegate = self;
        _listManager.paramSource = self;
        _listManager.interceptor = self;
    }
    return _listManager;
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
