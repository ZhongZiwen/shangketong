//
//  SKTCRMViewController.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/24.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTCRMViewController.h"
#import "XLFormImageTitleCell.h"

static NSString * const kCampaign = @"campaign";  // 市场活动
static NSString * const kLeadPool = @"leadPool";  // 线索公海池
static NSString * const kLead = @"lead";  // 销售线索
static NSString * const kCustomerPool = @"customerPool";  // 客户公海池
static NSString * const kCustomer = @"customer";  // 客户
static NSString * const kContact = @"contact";  // 联系人
static NSString * const kOpportunity = @"opportunity";  // 销售机会
static NSString * const kProduct = @"product";  // 产品

@interface SKTCRMViewController ()

@end

@implementation SKTCRMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    XLFormDescriptor *formDescriptor = [XLFormDescriptor formDescriptor];

    XLFormSectionDescriptor *sectionDescriptor;
    XLFormRowDescriptor *rowDescriptor;

    sectionDescriptor = [XLFormSectionDescriptor formSection];
    [formDescriptor addFormSection:sectionDescriptor];

    // 市场活动
    rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kCampaign rowType:XLFormRowDescriptorTypeCustomImageTitle];
    rowDescriptor.value = @{@"image" : @"menu_item_campaign", @"title" : @"市场活动"};
    [sectionDescriptor addFormRow:rowDescriptor];

    sectionDescriptor = [XLFormSectionDescriptor formSection];
    [formDescriptor addFormSection:sectionDescriptor];

    // 线索公海池
    rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kLeadPool rowType:XLFormRowDescriptorTypeCustomImageTitle];
    rowDescriptor.value = @{@"image" : @"menu_item_leadHighsea", @"title" : @"线索公海池"};
    [sectionDescriptor addFormRow:rowDescriptor];

    // 销售线索
    rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kLead rowType:XLFormRowDescriptorTypeCustomImageTitle];
    rowDescriptor.value = @{@"image" : @"menu_item_lead", @"title" : @"销售线索"};
    [sectionDescriptor addFormRow:rowDescriptor];

    // 客户公海池
    rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomerPool rowType:XLFormRowDescriptorTypeCustomImageTitle];
    rowDescriptor.value = @{@"image" : @"menu_item_highsea", @"title" : @"客户公海池"};
    [sectionDescriptor addFormRow:rowDescriptor];

    // 客户
    rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomer rowType:XLFormRowDescriptorTypeCustomImageTitle];
    rowDescriptor.value = @{@"image" : @"menu_item_account", @"title" : @"客户"};
    [sectionDescriptor addFormRow:rowDescriptor];

    // 联系人
    rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kContact rowType:XLFormRowDescriptorTypeCustomImageTitle];
    rowDescriptor.value = @{@"image" : @"menu_item_contact", @"title" : @"联系人"};
    [sectionDescriptor addFormRow:rowDescriptor];

    sectionDescriptor = [XLFormSectionDescriptor formSection];
    [formDescriptor addFormSection:sectionDescriptor];

    // 销售机会
    rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kOpportunity rowType:XLFormRowDescriptorTypeCustomImageTitle];
    rowDescriptor.value = @{@"image" : @"menu_item_opportunity", @"title" : @"销售机会"};
    [sectionDescriptor addFormRow:rowDescriptor];

    sectionDescriptor = [XLFormSectionDescriptor formSection];
    [formDescriptor addFormSection:sectionDescriptor];

    // 产品
    rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kProduct rowType:XLFormRowDescriptorTypeCustomImageTitle];
    rowDescriptor.value = @{@"image" : @"menu_item_product", @"title" : @"产品"};
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
        return 20;
    }
    
    return 0.01;
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
