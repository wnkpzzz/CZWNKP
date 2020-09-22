//
//  SqliteManager+project.m
//  EPJH
//
//  Created by Hans on 2020/9/22.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "SqliteManager+project.h"

@implementation SqliteManager (project)

#pragma mark ---------我的项目---------

/** 校验是否存在数据表 */
- (CreatTable *)setupProjectDBqueueWithUID:(NSString *)uid{
    
    //是否已存在Queue
    for (CreatTable *model in self.kProjectInfoArray) {
        NSString *aID = model.Id;
        if ([aID isEqualToString:uid]) { return model; break; }
    }
    
    //没有就创建我的好友表
    return [self creatProjectTableWithUID:uid];
}

/** 创建我的项目表 */
- (CreatTable *)creatProjectTableWithUID:(NSString *)uid{
    
    CreatTable *model = [self firstCreatProjectQueueWithUID:uid];
    FMDatabaseQueue *queue = model.queue;
    NSArray *sqlArr    = model.sqlCreatTable;
    
    for (NSString *sql in sqlArr) {
        [queue inDatabase:^(FMDatabase *db) {
            BOOL ok = [db executeUpdate:sql];
            if (ok == NO) { NSLog(@"创建我的项目表SQL执行失败:%@",sql); }
        }];
    }
    return model;
}

/** 第一次建我的项目表 */
- (CreatTable *)firstCreatProjectQueueWithUID:(NSString *)uid{
    
    // 数据表路径
    NSString *pathMyFri = pathProjectWithDir(ZCProjectDir, uid);
    NSFileManager *fileM = [NSFileManager defaultManager];
    
    //如果不存在,则说明是第一次运行这个程序，那么建立这个文件夹
    if(![fileM fileExistsAtPath:ZCProjectDir]){ 
        if (![fileM fileExistsAtPath:ZCUserDir]) {
            [fileM createDirectoryAtPath:ZCUserDir withIntermediateDirectories:YES attributes:nil error:nil];
        }
        if (![fileM fileExistsAtPath:ZCProjectDir]) {
            [fileM createDirectoryAtPath:ZCProjectDir withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    
    NSLog(@"第一次建我的项目表,数据库操作路径:\n%@",pathMyFri);
    
    
    CreatTable *model = [[CreatTable alloc] init];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:pathMyFri];
    
    if (queue) {
        //存ID和队列
        model.Id = uid;
        model.queue = queue;
        
        //存SQL语句
        NSString *tableName = tableNameProject(uid);
        NSString *userSql = [EPProjectModel yh_sqlForCreatTable:tableName primaryKey:@"id"];
        NSArray *sqlArr = nil;
        if (userSql ) {  sqlArr = @[userSql];   }
        if (sqlArr) { model.sqlCreatTable = sqlArr;  }
        [self.kProjectInfoArray addObject:model];
    }
    
    return model;
}






/*
* 向表中更新/插入单条数据
* @param proModel         该条数据Model
* @param updateItems      传nil就是更新Model的所有字段,否则更新数组里面的指定字段。
* eg:updateItems = @[@"userName",@"job"]; 更新好友的姓名和职位，注意字段名要填写正确
*/
- (void)updateOneProjectWithUID:(NSString *)uid  dataModel:(EPProjectModel *)dataModel updateItems:(NSArray <NSString *>*)updateItems complete:(void (^)(BOOL success,id obj))complete{
    
    if (!dataModel.projectId) {  complete( NO,@"dataModel is nil"); return; }
         
    CreatTable *model = [self setupProjectDBqueueWithUID:uid];
    FMDatabaseQueue *queue = model.queue;
    
    NSDictionary *otherSQL = nil;
    if (updateItems) { otherSQL = @{YHUpdateItemKey:updateItems}; }
     
    [queue inDatabase:^(FMDatabase *db) {
        /** 存储:会自动调用insert或者update，不需要担心重复插入数据 */
        [db yh_saveDataWithTable:tableNameProject(uid)  model:dataModel userInfo:nil otherSQL:otherSQL option:^(BOOL save) {
            complete(save,nil);
        }];
        
    }];
}

/*
 *  插入【表】中多/单条数据
 */
- (void)updateProjectsListWithUID:(NSString *)uid frislist:(NSArray <EPProjectModel *>*)proslist complete:(void (^)(BOOL success,id obj))complete{
    
      CreatTable *model = [self setupProjectDBqueueWithUID:uid];
        FMDatabaseQueue *queue = model.queue;

        NSString *tableName = tableNameProject(uid);
        for (int i= 0; i< proslist.count; i++) {

            EPProjectModel *model = proslist[i];

            [queue inDatabase:^(FMDatabase *db) {
                /** 存储:会自动调用insert或者update，不需要担心重复插入数据 */
                [db yh_saveDataWithTable:tableName model:model userInfo:nil otherSQL:nil option:^(BOOL save) {
                    if (i == proslist.count-1) {
                        complete(save,nil);
                    }else{
                        if (!save) {
                            complete(save,@"【项目表】插入多/单条数据失败");
                        }
                    }
                }];
            }];
        }
}

/*
*  删除表中某一条数据
*/
- (void)deleteOneProjectWithUID:(NSString *)uid dataModel:(EPProjectModel *)dataModel complete:(void(^)(BOOL success,id obj))complete{
        
    CreatTable *model = [self setupProjectDBqueueWithUID:uid];
    FMDatabaseQueue *queue = model.queue;

    [queue inDatabase:^(FMDatabase *db) {
        [db yh_deleteDataWithTable:tableNameProject(uid) model:dataModel userInfo:nil otherSQL:nil option:^(BOOL del) {
            complete(del,@(del));
        }];
    }];
}

/*
*  模糊/条件查询表数据
*  @param accurateInfo       条件查询
*  @param fuzzyInfo          模糊查询
*  备注:userInfo = nil && fuzzyUserInfo = nil 为全文搜索
*  备注:多条件/模糊查询 @{@"sex":@"1",@"province":@"广东省",@"city":@""}
*  备注:查询条件可以为空
*/
- (void)queryProjectTableWithUID:(NSString *)uid accurateInfo:(NSDictionary *)accurateInfo fuzzyInfo:(NSDictionary *)fuzzyInfo otherSQLDict:(NSDictionary *)otherSQLDict complete:(void (^)(BOOL success,id obj))complete{
 
    CreatTable *model = [self setupProjectDBqueueWithUID:uid];
    FMDatabaseQueue *queue = model.queue;

    [queue inDatabase:^(FMDatabase *db) {
        [db yh_excuteDatasWithTable:tableNameProject(uid) model:[EPProjectModel new] userInfo:accurateInfo fuzzyUserInfo:fuzzyInfo otherSQL:otherSQLDict option:^(NSMutableArray *models) {
            complete(YES,models);
        }];
    }];
    
}



@end
