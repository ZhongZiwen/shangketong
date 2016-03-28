//
//  SKTOfficeViewController.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/25.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTOfficeViewController.h"
#import "XLFormImageTitleCell.h"

static NSString * const kWorkingCycle = @"workingCycle";  // 工作圈
static NSString * const kContacts = @"contacts";  // 通讯录
static NSString * const kWorkReport = @"workReport";  // 工作报告
static NSString * const kApproval = @"approval";  // 审批
static NSString * const kSchedule = @"schedule";  // 日程
static NSString * const kTask = @"task";  // 任务
static NSString * const kKnowledgeBase = @"knowledgeBase";  // 知识库

@interface SKTOfficeViewController ()

@end

@implementation SKTOfficeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    XLFormDescriptor *formDescriptor = [XLFormDescriptor formDescriptor];

    XLFormSectionDescriptor *sectionDescriptor;
    XLFormRowDescriptor *rowDescriptor;

    // 工作圈
    sectionDescriptor = [XLFormSectionDescriptor formSection];
    [formDescriptor addFormSection:sectionDescriptor];
    rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kWorkingCycle rowType:XLFormRowDescriptorTypeCustomImageTitle];
    rowDescriptor.value = @{@"image" : @"menu_item_feed", @"title" : @"工作圈"};
    [sectionDescriptor addFormRow:rowDescriptor];

    // 通讯录
    sectionDescriptor = [XLFormSectionDescriptor formSection];
    [formDescriptor addFormSection:sectionDescriptor];
    rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kContacts rowType:XLFormRowDescriptorTypeCustomImageTitle];
    rowDescriptor.value = @{@"image" : @"menu_item_colleague", @"title" : @"通讯录"};
    [sectionDescriptor addFormRow:rowDescriptor];

    // 工作报告和审批
    sectionDescriptor = [XLFormSectionDescriptor formSection];
    [formDescriptor addFormSection:sectionDescriptor];
    rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kWorkReport rowType:XLFormRowDescriptorTypeCustomImageTitle];
    rowDescriptor.value = @{@"image" : @"menu_item_workreport", @"title" : @"工作报告"};
    [sectionDescriptor addFormRow:rowDescriptor];

    rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kApproval rowType:XLFormRowDescriptorTypeCustomImageTitle];
    rowDescriptor.value = @{@"image" : @"menu_item_approval", @"title" : @"审批"};
    [sectionDescriptor addFormRow:rowDescriptor];

    // 日程和任务
    sectionDescriptor = [XLFormSectionDescriptor formSection];
    [formDescriptor addFormSection:sectionDescriptor];
    rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kSchedule rowType:XLFormRowDescriptorTypeCustomImageTitle];
    rowDescriptor.value = @{@"image" : @"menu_item_schedule", @"title" : @"日程"};
    [sectionDescriptor addFormRow:rowDescriptor];

    rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kTask rowType:XLFormRowDescriptorTypeCustomImageTitle];
    rowDescriptor.value = @{@"image" : @"menu_item_task", @"title" : @"任务"};
    [sectionDescriptor addFormRow:rowDescriptor];

    // 知识库
    sectionDescriptor = [XLFormSectionDescriptor formSection];
    [formDescriptor addFormSection:sectionDescriptor];
    rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kKnowledgeBase rowType:XLFormRowDescriptorTypeCustomImageTitle];
    rowDescriptor.value = @{@"image" : @"menu_item_rescenter", @"title" : @"知识库"};
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
