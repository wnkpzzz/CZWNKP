//
//  EP_Pro_DataBaseTestViewCtl.m
//  EPJH
//
//  Created by Hans on 2020/9/18.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EP_Pro_DataBaseTestViewCtl.h"
#import "EPUserInfoModel.h"
#import "EPProjectModel.h"

@interface EP_Pro_DataBaseTestViewCtl ()

// 模拟数据
@property (nonatomic,strong) NSMutableArray *myFrisDataArr;
@property (nonatomic,strong) NSMutableArray *myProsDataArr;

@end

@implementation EP_Pro_DataBaseTestViewCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [NSUSERDEFAULTS setValue:@"10008" forKey:kUserID];
    self.myFrisDataArr = [NSMutableArray arrayWithCapacity:10];
    self.myProsDataArr = [NSMutableArray arrayWithCapacity:10];
  
    [self getLocalFrisData];
    
}
 
- (void)getLocalFrisData{
  
     for (int i=0; i<20; i++) {
        
        EPUserInfoModel *userModel=  [[EPUserInfoModel alloc] init];
        long idNum = 2016 + i;
        userModel.bindUserId = KUID;
        userModel.uid = [NSString stringWithFormat:@"%ld",idNum];
        userModel.createTime = [AppUtils getNowTimeCuo];
        userModel.timeFormat = [AppUtils timestampChangeTime:[AppUtils getNowTimeCuo] WithFormat:@"yyyy-MM-dd"];

        userModel.realName = [NSString stringWithFormat:@"userName%d",i];     //姓名
        userModel.sex = (arc4random()%2==1)?@"男":@"女";            // 1-男， 0-女
        userModel.headImg = @"";
        userModel.province = (arc4random()%2==1)?@"随机省份":@"广东省";     //省份
        userModel.city  = (arc4random()%2==1)?@"随机工作城市":@"广州";     //工作城市
        userModel.addr  = (arc4random()%2==1)?@"随机工作地点":@"广州移动"; //工作地点

        EPProjectModel *proInfo = [self getProjectInfoWithIndex:i];
        proInfo.userInfo = userModel;
         
        [self.myFrisDataArr addObject:userModel];
        [self.myProsDataArr addObject:proInfo];
     }
   
}

- (EPProjectModel *)getProjectInfoWithIndex:(int)idNum{

    EPProjectModel *proInfo=  [[EPProjectModel alloc] init];
    
    proInfo.bindUserId = KUID;
    proInfo.customerId = [NSString stringWithFormat:@"%d",idNum];
    proInfo.projectId  = [NSString stringWithFormat:@"%@%@",@"13",[AppUtils getNowTimeCuo]];
    proInfo.createTime = [AppUtils getNowTimeCuo];
 
    proInfo.position = (arc4random()%2==1)?@"术前":@"术后";
    proInfo.project = (arc4random()%2==1)?@"眼部":@"鼻部";
    proInfo.material = (arc4random()%2==1)?@"内眼角":@"鼻尖整形";
    proInfo.remark = (arc4random()%2==1)?@"激光祛皱皮":@"玻尿酸";

 
    return proInfo;

}

// 更新我的好友表
- (IBAction)updateMyFriTable:(id)sender {
    
    [[SqliteManager sharedInstance] updateFrisListWithFriID:KUID frislist:self.myFrisDataArr complete:^(BOOL success, id  _Nonnull obj) {
        
        if (success) {
            NSLog(@"更新多个好友信息成功");
        }else{
            NSLog(@"更新多个好友信息失败%@",obj);
        }
    }];
}
// 删除我的好友表
- (IBAction)deleteMyFriTable:(id)sender {
    
 
    
}
// 查询多个好友
- (IBAction)selectMoreFrisInfo:(id)sender {
    
    NSArray *frisIdArray = @[@"2016",@"2018",@"2020",@"2025"];

    [[SqliteManager sharedInstance] queryFrisWithfriIDs:frisIdArray complete:^(NSArray * _Nonnull successUserInfos, NSArray * _Nonnull failUids) {
        if (successUserInfos.count) {
            NSLog(@"查询多个好友结果%@",successUserInfos);
        }
        if (failUids.count) {
            NSLog(@"%@ not find in database",failUids);
        }
    }];
}
// 查询我的好友表
- (IBAction)selectMyFriTable:(id)sender {
    
}
//更新某个好友信息
- (IBAction)updateOneMyFriInfo:(id)sender {
    
}
//条件查询好友
- (IBAction)conditionSelectMyFriTable:(id)sender {
    
    NSDictionary *userInfoArr = @{@"sex":@"男",@"city":@""};//查找动态内容包含性别女的搜索内容

    [[SqliteManager sharedInstance] queryFrisTableWithFriID:KUID userInfo:userInfoArr fuzzyUserInfo:nil complete:^(BOOL success, id  _Nonnull obj) {
        if (success) {
        NSLog(@"多条件查询好友,搜索结果为\n%@",obj);
        }else{
        NSLog(@"多条件查询好友表失败");
        }
    }];
    
}
//模糊查询好友
- (IBAction)vagueSelectMyFriTable:(id)sender {
    
    NSDictionary *fuzzyUserInfo = @{@"sex":@"男",@"city":@""};//查找动态内容包含性别女的搜索内容

    [[SqliteManager sharedInstance] queryFrisTableWithFriID:KUID userInfo:nil fuzzyUserInfo:fuzzyUserInfo complete:^(BOOL success, id  _Nonnull obj) {
        if (success) {
        NSLog(@"模糊查询好友,搜索结果为\n%@",obj);
        }else{
        NSLog(@"模糊查询好友表失败");
        }
    }];
}



@end
