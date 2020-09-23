//
//  EP_Files_FillInDataViewCtl.m
//  EPJH
//
//  Created by Hans on 2020/9/17.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EP_Files_FillInDataViewCtl.h"

@interface EP_Files_FillInDataViewCtl ()

@property (nonatomic, strong) EPUserInfoModel * userModel;

@end

@implementation EP_Files_FillInDataViewCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"项目选择";
    [self loadBaseConfig];
}

#pragma mark - 基础配置
- (void)loadBaseConfig{
 
    self.userModel = [[EPUserInfoModel alloc] init];
    self.userModel.bindUserId = KUID;
    self.userModel.age = @"";
    self.userModel.medicalHistory = [kJWBSIDArray componentsJoinedByString:@","];
    self.userModel.physiologicalCondition = [kJWBSIDArray componentsJoinedByString:@","];
    
    // 创建病人信息
     self.userModel.uid = [NSString stringWithFormat:@"%@%@",@"12",[AppUtils getNowTimeCuo]];
     self.userModel.createTime = [AppUtils getNowTimeCuo];
     self.userModel.timeFormat = [AppUtils timestampChangeTime:[AppUtils getNowTimeCuo] WithFormat:@"yyyy-MM-dd"];

     self.userModel.realName = [NSString stringWithFormat:@"%@%@",@"PK",[AppUtils getNowTimeCuo]];
     self.userModel.sex = @"男";
     self.userModel.headImg = @"";
     self.userModel.province = @"广东省";
     self.userModel.city  = @"深圳市";
     self.userModel.addr  = @"深南大道9988号。";
}
 
#pragma mark - 事件处理
- (IBAction)submitAction:(id)sender {
    
//    //任务A
//    [[SqliteManager sharedInstance] updateOneUserWithUID:KUID dataModel:self.userModel updateItems:nil complete:^(BOOL success, id  _Nonnull obj) {
// 
//        if (success) {
//              
//            [AppJump goHomeVC];
//
//        }
//      
//    }];
    
 
    
}

@end
