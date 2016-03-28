//
//  SKTMeViewController.m
//  shangketong
//
//  Created by 钟必胜 on 16/3/25.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTMeViewController.h"
#import "XLFormImageTitleCell.h"
#import "XLFormHeaderCell.h"

static NSString * const kMyInformation = @"myInformation";  // 我的信息行
static NSString * const kMyTrends = @"myTrends";  // 我的动态
static NSString * const kFavorites = @"favorites";  // 我的收藏
static NSString * const kHelp = @"help";  // 帮助
static NSString * const kSetting = @"setting";  // 设置

@interface SKTMeViewController ()

@end

@implementation SKTMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    XLFormDescriptor *formDescriptor = [XLFormDescriptor formDescriptor];
    XLFormSectionDescriptor *sectionDescriptor;
    XLFormRowDescriptor *rowDescriptor;

    sectionDescriptor = [XLFormSectionDescriptor formSection];
    [formDescriptor addFormSection:sectionDescriptor];

    // 我的信息
    rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kMyInformation rowType:XLFormRowDescriptorTypeHeader];
    rowDescriptor.value = @{@"image" : @"", @"name" : @"钟必胜", @"company" : @"商客通尚景科技(上海)股份有限公司"};
    [sectionDescriptor addFormRow:rowDescriptor];

    sectionDescriptor = [XLFormSectionDescriptor formSection];
    [formDescriptor addFormSection:sectionDescriptor];

    // 我的动态
    rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kMyTrends rowType:XLFormRowDescriptorTypeCustomImageTitle];
    rowDescriptor.value = @{@"image" : @"mysetting_feed", @"title" : @"我的动态"};
    [sectionDescriptor addFormRow:rowDescriptor];

    // 我的收藏
    rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kFavorites rowType:XLFormRowDescriptorTypeCustomImageTitle];
    rowDescriptor.value = @{@"image" : @"mysetting_fav", @"title" : @"我的收藏"};
    [sectionDescriptor addFormRow:rowDescriptor];

    // 帮助
    rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kHelp rowType:XLFormRowDescriptorTypeCustomImageTitle];
    rowDescriptor.value = @{@"image" : @"mysetting_salesdoc", @"title" : @"帮助"};
    [sectionDescriptor addFormRow:rowDescriptor];

    sectionDescriptor = [XLFormSectionDescriptor formSection];
    [formDescriptor addFormSection:sectionDescriptor];

    // 设置
    rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kSetting rowType:XLFormRowDescriptorTypeCustomImageTitle];
    rowDescriptor.value = @{@"image" : @"mysetting_set", @"title" : @"设置"};
    [sectionDescriptor addFormRow:rowDescriptor];

    self.form = formDescriptor;
    self.tableView.backgroundColor = kBackgroundColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (!section) {
        return 20.0f;
    }

    return 0.001f;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];


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
