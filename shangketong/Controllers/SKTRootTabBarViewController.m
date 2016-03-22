//
//  SKTRootTabBarViewController.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/15.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTRootTabBarViewController.h"
#import "SKTHomeViewController.h"
#import "SKTMessageViewController.h"
#import "SKTCRMViewController.h"
#import "SKTOfficeViewController.h"
#import "SKTMeViewController.h"

#import "RDVTabBarItem.h"

@interface SKTRootTabBarViewController ()<RDVTabBarControllerDelegate>

@end

@implementation SKTRootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViewControllers {
    SKTHomeViewController *homeViewController = [[SKTHomeViewController alloc] init];
    homeViewController.title = @"首页";
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    
    SKTMessageViewController *messageViewController = [[SKTMessageViewController alloc] init];
    messageViewController.title = @"消息";
    UINavigationController *messageNav = [[UINavigationController alloc] initWithRootViewController:messageViewController];
    
    SKTCRMViewController *crmViewController = [[SKTCRMViewController alloc] init];
    crmViewController.title = @"CRM";
    UINavigationController *crmNav = [[UINavigationController alloc] initWithRootViewController:crmViewController];
    
    SKTOfficeViewController *officeViewController = [[SKTOfficeViewController alloc] init];
    officeViewController.title = @"办公";
    UINavigationController *officeNav = [[UINavigationController alloc] initWithRootViewController:officeViewController];
    
    SKTMeViewController *meViewController = [[SKTMeViewController alloc] init];
    meViewController.title = @"我";
    UINavigationController *meNav = [[UINavigationController alloc] initWithRootViewController:meViewController];
    
    [self setViewControllers:@[homeNav, messageNav, crmNav, officeNav, meNav]];
    self.delegate = self;
    
    [self customizeTabBarForController];
}

- (void)customizeTabBarForController {
    UIImage *backgroundImage = [UIImage imageNamed:@"tabbar_background"];
    NSArray *tabBarItemImages = @[@"home", @"message", @"crm", @"oa", @"me"];
    NSArray *tabBarItemTitles = @[@"首页", @"消息", @"CRM", @"办公", @"我"];
    
    int i = 0;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        item.titlePositionAdjustment = UIOffsetMake(0, 3);
        item.unselectedTitleAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:10],
                                           NSForegroundColorAttributeName : [UIColor colorWithHexString:@"0x808080"]};
        item.selectedTitleAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:10],
                                         NSForegroundColorAttributeName : [UIColor colorWithHexString:@"0x3BBD79"]};
        
        [item setBackgroundSelectedImage:backgroundImage withUnselectedImage:backgroundImage];
        
        UIImage *normalImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal", tabBarItemImages[i]]];
        UIImage *highlitedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_highlited", tabBarItemImages[i]]];
        [item setFinishedSelectedImage:highlitedImage withFinishedUnselectedImage:normalImage];
        [item setTitle:tabBarItemTitles[i]];
        
        i ++;
    }
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
