//
//  EPFindPwdViewCtl.m
//  EPJH
//
//  Created by Hans on 2020/7/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPFindPwdViewCtl.h"
#import "EPLoginHeadFileHandler.h"

@interface EPFindPwdViewCtl ()

@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *msgCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF; 
@property (weak, nonatomic) IBOutlet KCountdownButton *getCodeBtn;
@property (nonatomic, strong) LoginViewModel * loginViewModel;
@end

@implementation EPFindPwdViewCtl

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadBaseConfig];
}

- (void)loadBaseConfig{
    
    self.navigationItem.title = @"找回密码";
    self.loginViewModel = [[LoginViewModel alloc] init];

}

- (IBAction)btnClickAction:(UIButton *)sender {
     
    if (sender.tag == 0) { // 显示/隐藏密码
        sender.selected = !sender.isSelected;
        self.passwordTF.secureTextEntry = !sender.isSelected;
    }
    else if (sender.tag == 1) { // 获取验证码
        
        [self.loginViewModel requestGetCodeWith:self.accountTF.text withType:GetCodeWithFindPwd completion:^(BOOL isSuccess) {
            if (isSuccess) { [self.getCodeBtn startCountdown]; }
        }];
        
    }
    else if (sender.tag == 2) { // 找回密码
        
        WS(weakSelf);
        [self.loginViewModel requestFindPwdWith:self.accountTF.text AndPwd:self.passwordTF.text AndCode:self.msgCodeTF.text completion:^(BOOL isSuccess) {
            if (isSuccess) {
 
                SuccessToOriginController *success = [[SuccessToOriginController alloc] initWithType:SuccessToOriginPwd complete:^(SuccessToOriginController * _Nonnull customVc, BOOL isSaveFlag) {
                     
                     [customVc.navigationController popToRootViewControllerAnimated:YES];
                 }];
                 [weakSelf.navigationController pushViewController:success animated:YES];
                
            }
        }];
    }
    
}

@end
 
