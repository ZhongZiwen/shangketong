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

@interface SKTRootTabBarViewController ()

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
    homeViewController.tabBarItem = [self initializeTabBarItemWithTag:0];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    
    SKTMessageViewController *messageViewController = [[SKTMessageViewController alloc] init];
    messageViewController.title = @"消息";
    messageViewController.tabBarItem = [self initializeTabBarItemWithTag:1];
    UINavigationController *messageNav = [[UINavigationController alloc] initWithRootViewController:messageViewController];
    
    SKTCRMViewController *crmViewController = [[SKTCRMViewController alloc] init];
    crmViewController.title = @"CRM";
    crmViewController.tabBarItem = [self initializeTabBarItemWithTag:2];
    UINavigationController *crmNav = [[UINavigationController alloc] initWithRootViewController:crmViewController];
    
    SKTOfficeViewController *officeViewController = [[SKTOfficeViewController alloc] init];
    officeViewController.title = @"办公";
    officeViewController.tabBarItem = [self initializeTabBarItemWithTag:3];
    UINavigationController *officeNav = [[UINavigationController alloc] initWithRootViewController:officeViewController];
    
    SKTMeViewController *meViewController = [[SKTMeViewController alloc] init];
    meViewController.title = @"我";
    meViewController.tabBarItem = [self initializeTabBarItemWithTag:4];
    UINavigationController *meNav = [[UINavigationController alloc] initWithRootViewController:meViewController];
    
    self.viewControllers = @[homeNav, messageNav, crmNav, officeNav, meNav];
}

- (UITabBarItem *)initializeTabBarItemWithTag:(NSInteger)tag {
    NSArray *tabBarItemImages = @[@"home", @"message", @"crm", @"oa", @"me"];
    NSArray *tabBarItemTitles = @[@"首页", @"消息", @"CRM", @"办公", @"我"];

    UIImage *normalImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal", tabBarItemImages[tag]]];
    UIImage *highlitedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_highlited", tabBarItemImages[tag]]];
    normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    highlitedImage = [highlitedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle:tabBarItemTitles[tag] image:normalImage selectedImage:highlitedImage];
    barItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    [barItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10],
            NSForegroundColorAttributeName : [UIColor colorWithHexString:@"0x808080"]} forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10],
            NSForegroundColorAttributeName : [UIColor colorWithHexString:@"0x3BBD79"]} forState:UIControlStateSelected];

    return barItem;
}

//- (void)customizeTabBarForController {
//    UIImage *backgroundImage = [UIImage imageNamed:@"tabbar_background"];
//    NSArray *tabBarItemImages = @[@"home", @"message", @"crm", @"oa", @"me"];
//    NSArray *tabBarItemTitles = @[@"首页", @"消息", @"CRM", @"办公", @"我"];
//
//    int i = 0;
//    for (RDVTabBarItem *item in [[self tabBar] items]) {
//        item.titlePositionAdjustment = UIOffsetMake(0, 3);
//        item.unselectedTitleAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:10],
//                                           NSForegroundColorAttributeName : [UIColor colorWithHexString:@"0x808080"]};
//        item.selectedTitleAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:10],
//                                         NSForegroundColorAttributeName : [UIColor colorWithHexString:@"0x3BBD79"]};
//
//        [item setBackgroundSelectedImage:backgroundImage withUnselectedImage:backgroundImage];
//
//        UIImage *normalImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal", tabBarItemImages[i]]];
//        UIImage *highlitedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_highlited", tabBarItemImages[i]]];
//        [item setFinishedSelectedImage:highlitedImage withFinishedUnselectedImage:normalImage];
//        [item setTitle:tabBarItemTitles[i]];
//
//        i ++;
//    }
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
