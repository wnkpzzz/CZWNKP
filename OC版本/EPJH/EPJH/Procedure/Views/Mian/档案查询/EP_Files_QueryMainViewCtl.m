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
    
    NSLog(@"%@==K",pathFrisWithDir(ZCFriendsDir, KUID));
  
    
    [self formatWithSQLStrWithTime:@"" Pro:@"1" Age:@"00后" Province:@"广东省" City:@"深圳市" Collect:@"" Page:0];
}
 
- (void)queryFromTableWithTime:(NSString *)timeKey
                        Pro:(NSString *)proKey
                        Age:(NSString *)ageKey
                        Province:(NSString *)provinceKey
                        City:(NSString *)cityKey
                        Collect:(NSString *)collectKey
                        Page:(NSInteger)pageKey {
 
 
    //数据库路径
    NSString *filePath = pathFrisWithDir(ZCFriendsDir, KUID);
    
    //创建数据库对象
    _db = [FMDatabase databaseWithPath:filePath];

    //打开数据库
    if ([_db open]) { NSLog(@"打开数据库成功"); }else{ NSLog(@"打开数据库失败"); }

    //SQL语句
    NSString *tabName = [NSString stringWithFormat:@"fri_%@",KUID];
    NSString *ageSqlStr = [self getAgeSqlStr:ageKey];
    NSInteger page = pageKey * 10 + 1;
    NSInteger pageSize = (pageKey + 1) * 10;
    NSString *sqlStr0 = [NSString stringWithFormat:@"select * FROM %@ where id = %@ and timeFormat = %@ and subCateName = %@ %@ and province = %@ and city = %@  and isCollect = %@ order by id asc limit %ld,%ld ",tabName,KUID,timeKey,proKey,ageSqlStr,provinceKey,cityKey,collectKey,page,pageSize];
    NSLog(@"%@",sqlStr0);

    //查询数据库
    NSString *sqlStr = [NSString stringWithFormat:@"select * FROM %@ where sex = 0 and realName like '%%%@%%' order by id asc limit %d,%d ",tabName,@"user",0,10];
    FMResultSet *rs = [_db executeQuery:sqlStr];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    while ([rs next]) {
        EPUserInfoModel *model = [[EPUserInfoModel alloc] init];
        model.sex = [rs stringForColumn:@"sex"];
        model.realName = [rs stringForColumn:@"realName"];
        [array addObject:model];
    }
    NSLog(@"%@=====KK",array);
}

- (NSString *)formatWithSQLStrWithTime:(NSString *)dateKey
                                   Pro:(NSString *)proKey
                                   Age:(NSString *)ageKey
                              Province:(NSString *)provinceKey
                                  City:(NSString *)cityKey
                               Collect:(NSString *)collectKey
                                  Page:(NSInteger)pageKey{
 
    NSString * sqlStr = @"";
    NSString * dateSqlStr = @"";
    NSString * proSqlStr = @"";
    NSString * ageSqlStr = @"";
    NSString * locationSqlStr = @"";
    NSString * collectSqlStr = @"";
    NSString * pagingSqlStr = @"";
    NSInteger page = pageKey * 10 + 1;
    NSInteger pageSize = (pageKey + 1) * 10;
    NSString *tabName = [NSString stringWithFormat:@"fri_%@",KUID];

    if (dateKey && dateKey.length > 0 ) {  dateSqlStr = [NSString stringWithFormat:@" and timeFormat = %@" , dateKey]; }
    if (proKey && proKey.length > 0 )   {  proSqlStr  = [NSString stringWithFormat:@" and subCateName = %@" , proKey]; }
    if (ageKey && ageKey.length > 0 )   {  ageSqlStr = [self getAgeSqlStr:ageKey]; }
    if (cityKey && cityKey.length > 0 && provinceKey.length > 0 && provinceKey.length > 0) {
        locationSqlStr = [NSString stringWithFormat:@" and province = %@ and city = %@" , provinceKey,cityKey]; }
    if (collectKey && collectKey.length > 0 ) {  collectSqlStr = [NSString stringWithFormat:@" and isCollect = %@" , collectKey]; }
    pagingSqlStr = [NSString stringWithFormat:@" order by id asc limit %ld,%ld" , page,pageSize];
 
    sqlStr = [NSString stringWithFormat:@"select * FROM %@ where id = %@ %@ %@ %@ %@ %@ %@",tabName,KUID,dateSqlStr,proSqlStr,ageSqlStr,locationSqlStr,collectKey,pagingSqlStr];
    NSLog(@"%@",sqlStr);
    
    return sqlStr;
    
}
 
- (NSString *)getAgeSqlStr:(NSString *)ageKey{
    NSString * sqlStr = @"";
    if ([ageKey isEqualToString:@"00后"]) {  sqlStr = @" and age > 8  and age <= 18 "; }
    if ([ageKey isEqualToString:@"90后"]) {  sqlStr = @" and age > 18 and age <= 28 "; }
    if ([ageKey isEqualToString:@"80后"]) {  sqlStr = @" and age > 28 and age <= 38 "; }
    if ([ageKey isEqualToString:@"70后"]) {  sqlStr = @" and age > 38 and age <= 48 "; }
    if ([ageKey isEqualToString:@"60后"]) {  sqlStr = @" and age > 48 and age <= 58 "; }
    if ([ageKey isEqualToString:@"50后"]) {  sqlStr = @" and age > 58 and age <= 68 "; }
    return sqlStr;
}

@end


//NSString *sqlStr0 = @"select * FROM %@ where timeFormat = 0 and subCateName = 0 and realName like '%%user%%' order by id asc limit 0,10 ";
//NSString *sqlStr1 = [NSString stringWithFormat:@"select * FROM %@ where sex = 0 and realName like '%%%@%%' order by id asc limit %d,%d ",tabName,@"user",0,10];
