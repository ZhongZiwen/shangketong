//
//  SKTIntroductionViewController.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/16.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTIntroductionViewController.h"
#import "SKTLoginViewController.h"
#import "SKTRegisterViewController.h"

@interface SKTIntroductionViewController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIButton *loginButton;
@end

@implementation SKTIntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kBackgroundColor;
    
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.registerButton];
    
    CGFloat buttonWidth = kScreen_Width * 0.8;
    CGFloat buttonHeight = kScaleFrom_iPhone5_Desgin(38);
    CGFloat buttonBetweenPadding = kScaleFrom_iPhone5_Desgin(20);
    CGFloat paddingToBottom = kScaleFrom_iPhone5_Desgin(64);
    
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, kScreen_Height));
    }];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonHeight));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(_registerButton.mas_top).offset(-buttonBetweenPadding);
    }];
    [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonWidth, buttonHeight));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-paddingToBottom);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event response
- (void)registerButtonPress {
    SKTRegisterViewController *registerViewController = [[SKTRegisterViewController alloc] init];
    registerViewController.title = @"注册";
    registerViewController.type = SKTRegisterViewControllerTypeRegister;
    UINavigationController *registerNav = [[UINavigationController alloc] initWithRootViewController:registerViewController];
    [self presentViewController:registerNav animated:YES completion:nil];
}

- (void)loginButtonPress {
    SKTLoginViewController *loginViewController = [[SKTLoginViewController alloc] init];
    loginViewController.title = @"登录";
    UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    [self presentViewController:loginNav animated:YES completion:nil];
}

#pragma mark - setters and getters
- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        UIImage *image = nil;
        if (kDevice_Is_iPhone6Plus) {
            image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"guide_iPhone6Plus@2x" ofType:@"png"]];
        }
        else if (kDevice_Is_iPhone6) {
            image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"guide_iPhone6@2x" ofType:@"png"]];
        }
        else if (kDevice_Is_iPhone5) {
            image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"guide_iPhone5@2x" ofType:@"png"]];
        }
        else {
            image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"guide_iPhone4@2x" ofType:@"png"]];
        }
        _backgroundImageView = [[UIImageView alloc] initWithImage:image];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        _backgroundImageView.clipsToBounds = YES;
    }
    return _backgroundImageView;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_registerButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"0xd4eaff"]] forState:UIControlStateHighlighted];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:20];
        [_registerButton setTitleColor:[UIColor colorWithHexString:@"0x2f85d9"] forState:UIControlStateNormal];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        _registerButton.layer.cornerRadius = kScaleFrom_iPhone5_Desgin(38) / 2;
        _registerButton.layer.masksToBounds = YES;
        [_registerButton addTarget:self action:@selector(registerButtonPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"0x2f85d9"]] forState:UIControlStateNormal];
        [_loginButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"0x2579cb"]] forState:UIControlStateHighlighted];
    
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:20];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = kScaleFrom_iPhone5_Desgin(38) / 2;
        _loginButton.layer.borderWidth = 1.0f;
        _loginButton.layer.borderColor = [UIColor whiteColor].CGColor;
        [_loginButton addTarget:self action:@selector(loginButtonPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
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
