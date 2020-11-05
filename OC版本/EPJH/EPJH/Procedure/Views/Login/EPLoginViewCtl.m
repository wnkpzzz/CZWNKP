//
//  EPLoginViewCtl.m
//  EPJH
//
//  Created by Hans on 2020/7/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPLoginViewCtl.h"
#import "EPLoginHeadFileHandler.h"

@interface EPLoginViewCtl ()

@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (nonatomic, strong) LoginViewModel * loginViewModel;

@end

@implementation EPLoginViewCtl

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadBaseConfig];
}

#pragma mark - 基础配置
- (void)loadBaseConfig{
    
    self.navigationItem.title = @"登录";
    self.loginViewModel = [[LoginViewModel alloc] init];

    // 检测是否存在手机号,有则显示。
    NSString * numStr = [NSUSERDEFAULTS valueForKey:kPhoneNum];
    if (numStr && numStr.length > 0) {  self.accountTF.text = numStr;  }
    
    // 检测用户协议+隐私政策
    NSString * str = [NSUSERDEFAULTS valueForKey:kCheckInstallFlag];
    if (str && [str isEqualToString:@"YES"]) {  }else{

        [PopPrivacyProtocolView showPopViewWithComplete:^(PrivacyProtocolType btnStatus) {
                 
                     switch (btnStatus) {
                         case PopPrivacyProtocolAgreement:
                             NSLog(@"111");
                             break;
                         case PopPrivacyProtocolPolicy:
                              NSLog(@"222");
                             break;
                         default:
                             break;
                     }
             }];
    }
    
   
}

#pragma mark - 事件处理
- (IBAction)btnClickAction:(UIButton *)sender {
    
    if (sender.tag == 0) { // 显示/隐藏密码
        sender.selected = !sender.isSelected;
        self.passwordTF.secureTextEntry = !sender.isSelected;
    }
    else if (sender.tag == 1) { // 忘记密码
        EPFindPwdViewCtl  * Vc = [[EPFindPwdViewCtl alloc] init];
        [self.navigationController pushViewController:Vc animated:YES];
    }
    else if (sender.tag == 2) { // 确认登录
        [self.loginViewModel requestSignInWith:self.accountTF.text AndPwd:self.passwordTF.text ];
    }
    else if (sender.tag == 3) { // 用户注册
        EPRegisterViewCtl  * Vc = [[EPRegisterViewCtl alloc] init];
        [self.navigationController pushViewController:Vc animated:YES];
    }
}
 
@end
