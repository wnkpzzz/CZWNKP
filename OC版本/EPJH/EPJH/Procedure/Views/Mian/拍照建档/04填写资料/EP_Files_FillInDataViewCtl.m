//
//  EP_Files_FillInDataViewCtl.m
//  EPJH
//
//  Created by Hans on 2020/9/17.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EP_Files_FillInDataViewCtl.h"

@interface EP_Files_FillInDataViewCtl ()

@end

@implementation EP_Files_FillInDataViewCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"项目选择";
    [self loadBaseConfig];
}

#pragma mark - 基础配置
- (void)loadBaseConfig{

}
 
#pragma mark - 事件处理
- (IBAction)submitAction:(id)sender {
    
    [AppJump goHomeVC];
}

@end
