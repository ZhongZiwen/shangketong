//
//  SKTAppDelegate.m
//  shangketong
//
//  Created by sungoin-zbs on 15/12/4.
//  Copyright (c) 2015年 sungoin. All rights reserved.
//

#import "SKTAppDelegate.h"
#import "SKTRootTabBarViewController.h"
#import "SKTIntroductionViewController.h"

@implementation SKTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    // 设置导航栏样式
    [self customizeInterface];
    
    [self setupIntroductionViewController];
//    [self setupTabBarViewController];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - public method
- (void)setupTabBarViewController {
    SKTRootTabBarViewController *rootTabBarController = [[SKTRootTabBarViewController alloc] init];
    rootTabBarController.tabBar.translucent = YES;  // 半透明
    self.window.rootViewController = rootTabBarController;
}

- (void)setupIntroductionViewController {
    SKTIntroductionViewController *introductionController = [[SKTIntroductionViewController alloc] init];
    self.window.rootViewController = introductionController;
}

- (void)setupLoginViewController {
    
}

#pragma mark - private method
- (void)customizeInterface {
    UINavigationBar *navigationbar = [UINavigationBar appearance];
    
    // 默认情况下，导航栏的translucent属性为YES,另外，系统还会对所有的导航栏做模糊处理，这样可以让导航栏的颜色更加饱和。
    // 关闭模糊处理
    [navigationbar setTranslucent:NO];
    
    // 设置导航栏背景颜色
    [navigationbar setBarTintColor:[UIColor colorWithHexString:@"0x1d1d1d"]];
    
    // 设置返回按钮的箭头颜色
    [navigationbar setTintColor:[UIColor whiteColor]];
    
    // 设置导航栏标题字体和颜色
    NSDictionary *textAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:kNavTitleFontSize],
                                     NSForegroundColorAttributeName: [UIColor whiteColor]};
    [navigationbar setTitleTextAttributes:textAttributes];
    
    //设置UITextField的光标颜色
    [[UITextField appearance] setTintColor:[UIColor colorWithHexString:@"0x3bbc79"]];
    
    //设置UITextView的光标颜色
    [[UITextView appearance] setTintColor:[UIColor colorWithHexString:@"0x3bbc79"]];
    
    [[UISearchBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"0xeeeeee"]] forBarPosition:0 barMetrics:UIBarMetricsDefault];
    
    // 修改状态栏的风格
    // 1:在project target的Info tab中，插入一个新的key，名字为View controller-based status bar appearance，并将其值设置为NO。
    // 2:设置StatusBarStyle
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
@end
