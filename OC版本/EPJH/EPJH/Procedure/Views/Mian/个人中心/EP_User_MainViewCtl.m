//
//  EP_User_MainViewCtl.m
//  EPJH
//
//  Created by Hans on 2020/9/17.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EP_User_MainViewCtl.h"


@interface EP_User_MainViewCtl ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end

@implementation EP_User_MainViewCtl

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"个人中心";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     
}

- (void)loadBaseConfig{
}

#pragma mark - 点击事件

// 个人中心
- (IBAction)userInfoAction:(id)sender {
    
     
}

// 云备份
- (IBAction)dataCenterAction:(id)sender {
     
     
}

// 案例分享
- (IBAction)caseShareAction:(id)sender {
    
     
}

// 修改密码
- (IBAction)changePwdAction:(id)sender {
    
}

// 帮助中心
- (IBAction)helpAction:(id)sender {
     
 
}

// 意见反馈
- (IBAction)feedbackAction:(id)sender {
    
    
}

// 联系客服
- (IBAction)callPhoneAction:(id)sender {
     
 
}
 
// 用户投诉
- (IBAction)callComplaintAction:(id)sender{
 
    
}

// 关于我们
- (IBAction)aboutUsAction:(id)sender {
 
    
}

// 退出登录
- (IBAction)exitAction:(id)sender {
    
}

// 注销账号
- (IBAction)cancellationAccountAction:(id)sender {
    
}

@end
