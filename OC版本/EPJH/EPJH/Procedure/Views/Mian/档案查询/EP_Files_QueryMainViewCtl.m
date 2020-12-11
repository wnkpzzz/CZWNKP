//
//  EP_Files_QueryMainViewCtl.m
//  EPJH
//
//  Created by Hans on 2020/9/17.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EP_Files_QueryMainViewCtl.h"
#import "EP_Files_QueryInfoCell.h"

@interface EP_Files_QueryMainViewCtl ()
@property (nonatomic,strong) FMDatabase *db;

@end

@implementation EP_Files_QueryMainViewCtl

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.navigationItem.title = @"查询";
    [self loadBaseConfig];
}
 
#pragma mark --- 基础配置


- (void)loadBaseConfig{

}



 








 



 
@end

//- (void)loadBaseConfig{
//
//    NSLog(@"%@==K",pathFrisWithDir(ZCFriendsDir, KUID));
//
//    [self queryFromTableWithName:@"user" Date:@"2" Pro:@"" Age:@"00后" Province:@"g广东省" City:@"深圳市" Collect:@"1" Page:0];
//}

//
//- (void)queryFromTableWithName:(NSString *)nameKey
//                          Date:(NSString *)dateKey
//                           Pro:(NSString *)proKey
//                           Age:(NSString *)ageKey
//                      Province:(NSString *)provinceKey
//                          City:(NSString *)cityKey
//                       Collect:(NSString *)collectKey
//                          Page:(NSInteger)pageKey {
//
//
//    if (nameKey && nameKey.length > 0) { [self queryUserInfoWithName:nameKey Page:pageKey]; return; }
//    if (collectKey && collectKey.length > 0) { [self queryUserInfoWithCollect:collectKey Page:pageKey]; return; }
//
//
//
//
//
//
//
//}
//
//// 昵称模糊搜索
//- (void)queryUserInfoWithName:(NSString *)nameKey Page:(NSInteger)pageKey{
//
//    //数据库路径
//    NSString *filePath = pathFrisWithDir(ZCFriendsDir, KUID);
//
//    //创建数据库对象
//    _db = [FMDatabase databaseWithPath:filePath];
//
//    //打开数据库
//    if ([_db open]) { NSLog(@"打开数据库成功"); }else{ NSLog(@"打开数据库失败"); }
//
//    //SQL语句
//    NSString * nameSqlStr = @"";
//    NSString * pagingSqlStr = @"";
//
//    NSInteger page = pageKey * 10 + 1;
//    NSInteger pageSize = (pageKey + 1) * 10;
//    NSString *firTabName = [NSString stringWithFormat:@"fri_%@",KUID];
//
//    pagingSqlStr = [NSString stringWithFormat:@" order by id asc limit %ld,%ld" , page,pageSize];
//    nameSqlStr = [NSString stringWithFormat:@" and realName like '%%%@%%' " , nameKey];
//
//    NSString *sqlStr  = [NSString stringWithFormat:@"select * from %@ where bindUserId = %@ %@ %@",firTabName,KUID,nameSqlStr,pagingSqlStr];
//    NSLog(@"%@",sqlStr);
//
//    //查询数据库
//    FMResultSet *rs = [_db executeQuery:sqlStr];
//    NSMutableArray *array = [[NSMutableArray alloc]init];
//    while ([rs next]) {
//        EPUserInfoModel *model = [[EPUserInfoModel alloc] init];
//        model.sex = [rs stringForColumn:@"sex"];
//        model.realName = [rs stringForColumn:@"realName"];
//        [array addObject:model];
//    }
//    NSLog(@"%@=====KK",array);
//}
//
//// 时间+项目搜索
//- (void)queryUserInfoWithDate:(NSString *)dateKey Pro:(NSString *)proKey{
//
//}
//
//// 时间+项目搜索
//- (void)queryUserInfoWithAge:(NSString *)ageKey City:(NSString *)cityKey{
//
//}
//
////收藏搜索
//- (void)queryUserInfoWithCollect:(NSString *)collectKey Page:(NSInteger)pageKey{
//
//}

//- (void)queryFromTableWithName:(NSString *)nameKey
//                          Date:(NSString *)dateKey
//                           Pro:(NSString *)proKey
//                           Age:(NSString *)ageKey
//                      Province:(NSString *)provinceKey
//                          City:(NSString *)cityKey
//                       Collect:(NSString *)collectKey
//                          Page:(NSInteger)pageKey {
//
//    //数据库路径
//    NSString *filePath = pathFrisWithDir(ZCFriendsDir, KUID);
//
//    //创建数据库对象
//    _db = [FMDatabase databaseWithPath:filePath];
//
//    //打开数据库
//    if ([_db open]) { NSLog(@"打开数据库成功"); }else{ NSLog(@"打开数据库失败"); }
//
//    //SQL语句
//    NSString *sqlStr =  [[SqliteLogicHandler sharedInstance] formatSQLStrWithName:nameKey Date:dateKey Pro:proKey Age:ageKey Province:provinceKey City:cityKey Collect:collectKey Page:pageKey];
//
//    //查询数据库
//    FMResultSet *rs = [_db executeQuery:sqlStr];
//    NSMutableArray *array = [[NSMutableArray alloc]init];
//    while ([rs next]) {
//        EPUserInfoModel *model = [[EPUserInfoModel alloc] init];
//        model.sex = [rs stringForColumn:@"sex"];
//        model.realName = [rs stringForColumn:@"realName"];
//        [array addObject:model];
//    }
//    NSLog(@"%@=====KK",array);
//}

//  NSString *sqlStr = @"select * FROM %@ where timeFormat = 0 and subCateName = 0 and realName like '%%user%%' order by id asc limit 0,10 ";
//  NSString *sqlStr = [NSString stringWithFormat:@"select * FROM %@ where sex = 0 and realName like '%%%@%%' order by id asc limit %d,%d ",tabName,@"user",0,10];


