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
  
    [self queryFromTableWithName:@"user" Date:@"2" Pro:@"" Age:@"00后" Province:@"g广东省" City:@"深圳市" Collect:@"1" Page:0];
}
 
- (void)queryFromTableWithName:(NSString *)nameKey
                          Date:(NSString *)dateKey
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
    NSString *sqlStr =  [[SqliteLogicHandler sharedInstance] formatSQLStrWithName:nameKey Date:dateKey Pro:proKey Age:ageKey Province:provinceKey City:cityKey Collect:collectKey Page:pageKey];

    //查询数据库
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

 
@end


//  NSString *sqlStr = @"select * FROM %@ where timeFormat = 0 and subCateName = 0 and realName like '%%user%%' order by id asc limit 0,10 ";
//  NSString *sqlStr = [NSString stringWithFormat:@"select * FROM %@ where sex = 0 and realName like '%%%@%%' order by id asc limit %d,%d ",tabName,@"user",0,10];


