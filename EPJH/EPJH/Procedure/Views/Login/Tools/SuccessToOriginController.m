//
//  SuccessToOriginController.m
//  EPJH
//
//  Created by Hans on 2020/7/15.
//  Copyright © 2020 hans3d. All rights reserved.
//


#import "SuccessToOriginController.h"

@interface SuccessToOriginController ()

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *infoLab;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@property (nonatomic, assign) BOOL isSaveFlag;
@property (nonatomic, assign) SuccessToOriginType type;

@end

@implementation SuccessToOriginController

- (id)initWithType:(SuccessToOriginType)type complete:(SuccessToOriginBackBlock)complete{
     
    if (self = [super init]) {
          
        self.type = type;
        self.completeHandler = complete;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadBaseConfigWithType:self.type];

}

- (void)loadBaseConfigWithType:(SuccessToOriginType)type{
     
    self.isSaveFlag = YES;
    [self.saveBtn setHidden:YES];
    [self.submitBtn setTitle:@"返回登录" forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
  
    switch (type) {
        case SuccessToOriginRegister:
            
            self.navigationItem.title = @"注册完成";
            self.infoLab.text = @"注册完成";
            break;
        case SuccessToOriginPwd:
            
            self.navigationItem.title = @"找回密码";
            self.infoLab.text = @"找回密码成功";
            break;
        case SuccessToOriginChangePwd:
            
            self.navigationItem.title = @"修改成功";
            self.infoLab.text = @"修改成功";
            [self.submitBtn setTitle:@"返回首页" forState:UIControlStateNormal];
            break;
        case SuccessToOriginCreateFiles:
            
            [self.saveBtn setHidden:NO];
            self.navigationItem.title = @"新建完成";
            self.infoLab.text = @"新建完成";
            [self.submitBtn setTitle:@"确定返回" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

- (IBAction)submitBtnClickAction:(id)sender {
    
    if (self.completeHandler) {
        self.completeHandler(self, self.isSaveFlag);
    }
}

- (IBAction)saveBtnDidClick:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    self.isSaveFlag = sender.selected;
}


@end
