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

#import "PersonVO.h"

@interface EP_Pro_DataBaseTestViewCtl ()
{
    FMDatabase *db;
}
// 模拟数据
@property (nonatomic,strong) NSMutableArray *myFrisDataArr;
@property (nonatomic,strong) NSMutableArray *myProsDataArr;
@property (nonatomic,strong) NSMutableArray *myImgsProDataArr;
@property (nonatomic,strong) NSMutableArray *resultFrisDataArr;
@property (nonatomic,strong) NSMutableArray *resultProsDataArr;
@property (nonatomic,strong) NSMutableArray *resultImgsProDataArr;

@property (nonatomic,strong) NSMutableArray<EPTakePictureModel *> *myTakePicDataArr;
 
//@property (nonatomic,strong) FMDatabase *db;

// 信号量控制线程同步
@property (nonatomic, strong) dispatch_semaphore_t semaphore;


@end

@implementation EP_Pro_DataBaseTestViewCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.myFrisDataArr = [NSMutableArray arrayWithCapacity:10];
    self.myProsDataArr = [NSMutableArray arrayWithCapacity:10];
    self.myImgsProDataArr = [NSMutableArray arrayWithCapacity:10];
    self.resultFrisDataArr = [NSMutableArray arrayWithCapacity:10];
    self.resultProsDataArr = [NSMutableArray arrayWithCapacity:10];
    self.resultImgsProDataArr = [NSMutableArray arrayWithCapacity:10];
    self.myTakePicDataArr = [NSMutableArray arrayWithCapacity:10];

    [self getLocalFrisData];
}
 

// 模拟得到批量用户+项目+图片数据
- (void)getLocalFrisData{
  
     for (int i = 0; i < 1; i++) {
        long idNum = 2016 + i;
        EPUserInfoModel *userModel=  [[EPUserInfoModel alloc] init];
        userModel.bindUserId = KUID;
        userModel.uid = [NSString stringWithFormat:@"%ld%@",idNum,[AppUtils getNowTimeCuo]];
        userModel.createTime = [AppUtils getNowTimeCuo];
        userModel.timeFormat = [AppUtils timestampChangeTime:[AppUtils getNowTimeCuo] WithFormat:@"yyyy-MM-dd"];
        userModel.realName = [NSString stringWithFormat:@"userName%d",i];     //姓名
        userModel.age = [NSString stringWithFormat:@"%d",arc4random()];     //年龄
        userModel.sex = (arc4random()%2==1)?@"1":@"0";            // 1-男， 0-女
        userModel.headImg = @"";
        userModel.province = (arc4random()%2==1)?@"河南省":@"广东省";     //省份
        userModel.city  = (arc4random()%2==1)?@"南阳市":@"深圳市";     //工作城市
        userModel.addr  = (arc4random()%2==1)?@"南石医院":@"南山区大族科技中心"; //工作地点
        userModel.isCollect = (arc4random()%2==1)?@"1":@"0";  // 1-收藏， 0-未收藏
         
        for (int i = 0; i < 3; i++) {
            long idNum = 3016 + i;
            NSString * proID =  [NSString stringWithFormat:@"%ld%@",idNum,[AppUtils getNowTimeCuo]];
            EPProjectModel *proInfo = [self getProjectInfoWithFriID:userModel.uid ProID:proID];
            [self.myProsDataArr addObject:proInfo];
        }
          
        [self.myFrisDataArr addObject:userModel];
     }
}

- (EPProjectModel *)getProjectInfoWithFriID:(NSString *)friID ProID:(NSString *)proID{

    EPProjectModel *proInfo=  [[EPProjectModel alloc] init];
    proInfo.bindUserId = KUID;
    proInfo.customerId = friID;
    proInfo.projectId  = proID;
    proInfo.createTime = [AppUtils getNowTimeCuo];
 
    proInfo.subCateName = (arc4random()%2==1)?@"术前":@"术后";
    proInfo.cateName = (arc4random()%2==1)?@"眼部":@"鼻部";
    proInfo.project = (arc4random()%2==1)?@"内眼角":@"鼻尖整形";
    proInfo.material = (arc4random()%2==1)?@"激光祛皱皮":@"玻尿酸";

 
    for (int i = 0; i < 1; i++) {
        
        long idNum = 4016 + i;
        NSString * imgID =  [NSString stringWithFormat:@"%ld%@",idNum,[AppUtils getNowTimeCuo]];
        EPImageModel *imgInfo = [self getImageProInfoWithFriID:proInfo.customerId ProID:proInfo.projectId ImgID:imgID];
        [self.myImgsProDataArr addObject:imgInfo];
        
        EPTakePictureModel * picModel = [[EPTakePictureModel alloc] init];
        picModel.cameraImage =kImage(@"launch_0");
        picModel.cameraImgStr = [NSString stringWithFormat:@"16%@",[AppUtils getNowTimeCuo]];
        [self.myTakePicDataArr addObject:picModel];
    }
  
    return proInfo;

}

- (EPImageModel *)getImageProInfoWithFriID:(NSString *)friID  ProID:(NSString *)proID ImgID:(NSString *)imgID{

    EPImageModel *imgInfo = [[EPImageModel alloc] init];
    imgInfo.bindUserId = KUID;
    imgInfo.customerId = friID;
    imgInfo.projectId  = proID;
    imgInfo.imageId    = imgID;
    imgInfo.createTime = [AppUtils getNowTimeCuo];
    imgInfo.timeFormat = [AppUtils timestampChangeTime:[AppUtils getNowTimeCuo] WithFormat:@"yyyy-MM-dd"];

    return imgInfo;

}

// 批量插入多条数据到用户+项目+图片表中，需要保证全部成功/失败。
// 1、使用用数据库的事务功能，来保证同时执行成功。
// 2、自己做开关标记，记录失败，回滚。
// 备注:考虑到事务需要SQL语句，这里使用框架的模型转换SQL的形式，使用信号量+标记开关来控制数据。
- (IBAction)moniInserUserListAction:(id)sender {
      
    [[SqliteLogicHandler sharedInstance] createFilesWithType:CreateFilesTypeNew Fri:self.myFrisDataArr.firstObject Pro:self.myProsDataArr.firstObject Img:self.myImgsProDataArr Pic:self.myTakePicDataArr complete:^(BOOL isSucess) {
        
            if (isSucess) {
                NSLog(@"一键保存数据_成功");
            }else{
                NSLog(@"一键保存数据_失败");
            }
    }];
    
    
 
    
    
}

- (IBAction)moniQueryUserListAction:(id)sender {
    
    [self.resultFrisDataArr removeAllObjects];
    [self.resultProsDataArr removeAllObjects];
    [self.resultImgsProDataArr removeAllObjects];
    
    // 使用信号量保证串行队列+异步操作
    self.semaphore = dispatch_semaphore_create(1);
    
    WS(weakSelf);
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    [[SqliteManager sharedInstance] queryUserTableWithUID:KUID accurateInfo:nil fuzzyInfo:nil otherSQLDict:nil complete:^(BOOL success, id  _Nonnull obj) {
       
        if (success) {
         
            NSArray * dataArr = obj;
            NSArray * sortDataArr = [[dataArr reverseObjectEnumerator] allObjects];
            NSLog(@"%@====KK",sortDataArr );
            if (sortDataArr && sortDataArr.count > 0) {
                [weakSelf.resultFrisDataArr addObjectsFromArray:sortDataArr];
            }
        }
        
        dispatch_semaphore_signal(weakSelf.semaphore);

    }];
}

- (IBAction)moniQueryUserProInfoAction:(id)sender {
    
    WS(weakSelf);
    EPUserInfoModel * userModel = self.resultFrisDataArr.firstObject;
    NSDictionary *accurateInfo = @{@"customerId":userModel.uid};
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    [[SqliteManager sharedInstance] queryProjectTableWithUID:KUID accurateInfo:accurateInfo fuzzyInfo:nil otherSQLDict:nil complete:^(BOOL success, id  _Nonnull obj) {
      dispatch_semaphore_signal(weakSelf.semaphore);

        if (success) {
          
            NSArray * dataArr = obj;
            NSArray * sortDataArr = [[dataArr reverseObjectEnumerator] allObjects];
            NSLog(@"%@====PP",sortDataArr );
            if (sortDataArr && sortDataArr.count > 0) {
                [weakSelf.resultProsDataArr addObjectsFromArray:sortDataArr];
            }
        }

    }];
    
    for (EPProjectModel * proModel in weakSelf.resultProsDataArr) {
     
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        NSDictionary *accurateInfo = @{@"projectId":proModel.projectId};
        [[SqliteManager sharedInstance] queryImageTableWithUID:KUID accurateInfo:accurateInfo fuzzyInfo:nil otherSQLDict:nil complete:^(BOOL success, id  _Nonnull obj) {
            dispatch_semaphore_signal(weakSelf.semaphore);

            NSArray * dataArr = obj;
            NSArray * sortDataArr = [[dataArr reverseObjectEnumerator] allObjects];
            NSLog(@"%@====KK",sortDataArr );
            if (sortDataArr && sortDataArr.count > 0) {
                [weakSelf.resultImgsProDataArr addObjectsFromArray:sortDataArr];
                [proModel.cameraArr addObjectsFromArray:sortDataArr];
            }
        }];
                 

    }
 
}

 
//- (void)seruofhasdihfkasodhiyf{
//
//    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *filePath = [[path lastObject] stringByAppendingPathComponent:@"10001/Fris/fri_10001.sqlite"];
//
//    //创建数据库
//    _db = [FMDatabase databaseWithPath:filePath];
//
//    //打开数据库
//    if ([_db open]) {
//        NSLog(@"打开数据库成功");
//    }else{
//        NSLog(@"打开数据库失败");
//    }
//
//    /*
//     *查询数据库
//     */
//    NSMutableArray *array = [[NSMutableArray alloc]init];
//
//    NSString *sql = @"select * FROM fri_10001 where sex = 1 and userName like '%1%' order by id asc limit 0,10 ";
//    FMResultSet *rs = [_db executeQuery:sql];
//    while ([rs next]) {
//
////        YHUserInfo *model = [[YHUserInfo alloc] init];
////        model.uid = [rs stringForColumn:@"uid"];
////        model.accessToken = [rs stringForColumn:@"accessToken"];
////        model.taxAccount = [rs stringForColumn:@"taxAccount"];
////        model.mobilephone = [rs stringForColumn:@"mobilephone"];
////
////        [array addObject:model];
//
//    }
//
//    NSLog(@"%@=====KK",array);
//
//
//}



// 更新我的好友表
- (IBAction)updateMyFriTable:(id)sender {
    
    [[SqliteManager sharedInstance] updateUsersListWithUID:KUID datalist:self.myFrisDataArr complete:^(BOOL success, id  _Nonnull obj) {
 
        if (success) {
            NSLog(@"更新多个好友信息成功");
        }else{
            NSLog(@"更新多个好友信息失败%@",obj);
        }
    }];
}
// 查询多个好友
- (IBAction)selectMoreFrisInfo:(id)sender {
    
    NSArray *uidsArray = @[@"2016",@"2018",@"2020",@"2025"];

    [[SqliteManager sharedInstance] queryUserTableWithUIDs:uidsArray complete:^(NSArray * _Nonnull successUserInfos, NSArray * _Nonnull failUids) {
   
        if (successUserInfos.count) {
            NSLog(@"查询多个好友结果%@",successUserInfos);
        }
        if (failUids.count) {
            NSLog(@"%@ not find in database",failUids);
        }
    }];
}
// 条件查询好友
- (IBAction)conditionSelectMyFriTable:(id)sender {
    
    NSDictionary *accurateInfo = @{@"sex":@"男",@"city":@""};//查找动态内容包含性别女的搜索内容

    [[SqliteManager sharedInstance] queryUserTableWithUID:KUID accurateInfo:accurateInfo fuzzyInfo:nil otherSQLDict:nil complete:^(BOOL success, id  _Nonnull obj) {
    
         if (success) {
         NSLog(@"模糊查询好友,搜索结果为\n%@",obj);
         }else{
         NSLog(@"模糊查询好友表失败");
         }
     }];
    
 
    
}
// 模糊查询好友
- (IBAction)vagueSelectMyFriTable:(id)sender {
    
    NSDictionary *fuzzyInfo = @{@"sex":@"男",@"city":@""};//查找动态内容包含性别女的搜索内容

    [[SqliteManager sharedInstance] queryUserTableWithUID:KUID accurateInfo:nil fuzzyInfo:fuzzyInfo otherSQLDict:nil complete:^(BOOL success, id  _Nonnull obj) {
   
        if (success) {
        NSLog(@"模糊查询好友,搜索结果为\n%@",obj);
        }else{
        NSLog(@"模糊查询好友表失败");
        }
    }];
}



@end
