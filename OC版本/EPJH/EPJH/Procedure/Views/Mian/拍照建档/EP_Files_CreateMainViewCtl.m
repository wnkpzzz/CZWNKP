//
//  EP_Files_CreateMainViewCtl.m
//  EPJH
//
//  Created by Hans on 2020/9/17.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EP_Files_CreateMainViewCtl.h"

@interface EP_Files_CreateMainViewCtl ()

@property (weak, nonatomic) IBOutlet UIView *downView;

@end

@implementation EP_Files_CreateMainViewCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"拍照";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.downView.layer.borderColor = kMainBlueColor.CGColor;
    self.downView.layer.borderWidth = 1.0f;
}

#pragma mark - 事件处理
- (IBAction)btnClickAction:(UIButton *)sender {
 
     if (sender.tag == 0) { // 新建客户信息
      
         EP_Files_AngleSelectViewCtl * Vc = [[EP_Files_AngleSelectViewCtl alloc] init];
         [self.navigationController pushViewController:Vc animated:YES];
     }
     else if (sender.tag == 1) { // 选择已有客户
        
     }
     else if (sender.tag == 2) { // 扫码连接设备
         
     }
}

@end
