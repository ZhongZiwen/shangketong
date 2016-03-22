//
//  SKTCaptchaHelpViewController.m
//  shangketong
//
//  Created by sungoin-zbs on 16/3/22.
//  Copyright © 2016年 sungoin. All rights reserved.
//

#import "SKTCaptchaHelpViewController.h"

@interface SKTCaptchaHelpViewController ()

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *phoneButton;
@end

@implementation SKTCaptchaHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kBackgroundColor;
    
    [self.view addSubview:self.contentLabel];
    [self.view addSubview:self.phoneButton];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15.0f);
        make.top.equalTo(self.view).offset(15.0f);
        make.width.mas_equalTo(kScreen_Width - 30.0f);
//        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(15.0f, 15.0f, 0, 15.0f));
    }];
    [_phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 30));
        make.bottom.equalTo(self.view).offset(-20);
        make.centerX.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event response
- (void)phoneButtonClicked {
    
}

#pragma mark - getters and getters
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
        _contentLabel.text = @"亲爱的用户，验证短信正常都会在数秒钟内发送，如果您未收到短信/邮件，请参照如下常见情况进行解决:\n\n1、由于您的手机或邮件软件设定了某些安全设置，验证短信/邮件可能被拦截进了垃圾箱。请打开垃圾短信箱读取短信，并将商客通号码添加为白名单。\n\n2、由于运营商通道故障造成了短信/邮件发送时间延迟，请耐心稍候片刻或者点击重新获取验证码。\n\n3、关于手机号验证，目前支持移动、联通和电信的所有号码，暂不支持国际及港澳台地区号码。\n\n如果您尝试了上述方式均未解决，或存有疑问，请通过热线电话400-999-0000或在线咨询获取客户协助";
        [_contentLabel sizeToFit];
    }
    return _contentLabel;
}

- (UIButton *)phoneButton {
    if (!_phoneButton) {
        _phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _phoneButton.backgroundColor = [UIColor colorWithHexString:@"09bb07"];
        _phoneButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_phoneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_phoneButton setTitle:@"拨打免费热线 400-999-0000" forState:UIControlStateNormal];
        [_phoneButton addTarget:self action:@selector(phoneButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneButton;
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
