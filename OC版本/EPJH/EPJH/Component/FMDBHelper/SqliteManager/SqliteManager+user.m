//
//  SqliteManager+user.m
//  EPJH
//
//  Created by Hans on 2020/9/22.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "SqliteManager+user.h"

@implementation SqliteManager (user)

#pragma mark ---------Private---------

/** 校验是否存在数据表 */
- (CreatTable *)setupUserDBqueueWithUID:(NSString *)uid{
    
    //是否已存在Queue
    for (CreatTable *model in self.kUserInfoArray) {
        NSString *aID = model.Id;
        if ([aID isEqualToString:uid]) { return model;  break; }
    }
    //没有就创建我的病人表
    return [self creatUserTableWithUID:uid];
}

/** 创建我的病人表 */
- (CreatTable *)creatUserTableWithUID:(NSString *)uid{
    
    CreatTable *model = [self firstCreatUserQueueWithUID:uid];
    FMDatabaseQueue *queue = model.queue;
    NSArray *sqlArr    = model.sqlCreatTable;
    
    for (NSString *sql in sqlArr) {
        [queue inDatabase:^(FMDatabase *db) {
            BOOL ok = [db executeUpdate:sql];
            if (ok == NO) { NSLog(@"创建我的病人表SQL执行失败:%@",sql); }
        }];
    }
    return model;
}

/** 第一次创建我的病人表 */
- (CreatTable *)firstCreatUserQueueWithUID:(NSString *)uid{
    
    // 数据表路径
    NSString *pathMyFri = pathFrisWithDir(ZCFriendsDir, uid);
    NSFileManager *fileM = [NSFileManager defaultManager];
    
    //如果不存在,则说明是第一次运行这个程序，那么建立这个文件夹
    if(![fileM fileExistsAtPath:ZCFriendsDir]){
        
        if (![fileM fileExistsAtPath:ZCUserDir]) {
            [fileM createDirectoryAtPath:ZCUserDir withIntermediateDirectories:YES attributes:nil error:nil];
        }
        if (![fileM fileExistsAtPath:ZCFriendsDir]) {
            [fileM createDirectoryAtPath:ZCFriendsDir withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
    }
 
    NSLog(@"第一次建我的病人表,数据库操作路径:\n%@",pathMyFri);

    
    CreatTable *model = [[CreatTable alloc] init];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:pathMyFri];
    
    if (queue) {
        //存ID和队列
        model.Id = uid;
        model.queue = queue;
        
        //存SQL语句
        NSString *tableName = tableNameFris(uid);
        NSString *userSql = [EPUserInfoModel yh_sqlForCreatTable:tableName primaryKey:@"id"];
        
        NSArray *sqlArr = nil;
        if (userSql ) {  sqlArr = @[userSql];   }
        if (sqlArr) { model.sqlCreatTable = sqlArr;  }
        [self.kUserInfoArray addObject:model];
    }
    
    return model;
}


#pragma mark ---------我的病人/用户---------


/*
 * 更新表中【单条】数据
 * @param aFri         该条数据Model
 * @param updateItems  传nil就是更新model的所有字段,否则更新数组里面的指定字段。eg:updateItems = @[@"userName",@"job"];
 * 更新好友的姓名和职位，注意字段名要填写正确
 */
- (void)updateOneUserWithUID:(NSString *)uid dataModel:(EPUserInfoModel *)dataModel updateItems:(NSArray <NSString *>*)updateItems complete:(void (^)(BOOL success,id obj))complete{
    
    if (!dataModel.uid) {  complete( NO,@"dataModel is nil"); return; }

    CreatTable *model = [self setupUserDBqueueWithUID:uid];
    FMDatabaseQueue *queue = model.queue;
    
    NSDictionary *otherSQL = nil;
    if (updateItems) { otherSQL = @{YHUpdateItemKey:updateItems};}
     
    [queue inDatabase:^(FMDatabase *db) {
        /** 存储:会自动调用insert或者update，不需要担心重复插入数据 */
        [db yh_saveDataWithTable:tableNameFris(uid) model:dataModel userInfo:nil otherSQL:otherSQL option:^(BOOL save) {
            complete(save,nil);
        }];
        
    }];
}

/*
*  插入【表】中多/单条数据
*/
- (void)updateUsersListWithUID:(NSString *)uid datalist:(NSArray <EPUserInfoModel *>*)frislist complete:(void (^)(BOOL success,id obj))complete{
    
    CreatTable *model = [self setupUserDBqueueWithUID:uid];
    FMDatabaseQueue *queue = model.queue;
    
    NSString *tableName = tableNameFris(uid);
    for (int i= 0; i< frislist.count; i++) {
        
        EPUserInfoModel *model = frislist[i];
        [queue inDatabase:^(FMDatabase *db) {
            /** 存储:会自动调用insert或者update，不需要担心重复插入数据 */
            [db yh_saveDataWithTable:tableName model:model userInfo:nil otherSQL:nil option:^(BOOL save) {
                if (i == frislist.count-1) {
                    complete(save,nil);
                }else{ if (!save) {complete(save,@"插入/更新用户数据失败");}}
            }];
        }];
    }
}

/*
 *  删除某一个病人数据
 */
- (void)deleteOneUserWithUID:(NSString *)uid dataModel:(EPUserInfoModel *)dataModel  complete:(void(^)(BOOL success,id obj))complete{
   
    CreatTable *model = [self setupUserDBqueueWithUID:uid];
    FMDatabaseQueue *queue = model.queue;
    
    [queue inDatabase:^(FMDatabase *db) {
        [db yh_deleteDataWithTable:tableNameFris(uid) model:dataModel userInfo:nil otherSQL:nil option:^(BOOL del) {
            complete(del,@(del));
        }];
    }];
}


/*
*  模糊/条件查询表数据
*  @param userInfo       条件查询
*  @param fuzzyUserInfo  模糊查询
*  备注:userInfo = nil && fuzzyUserInfo = nil 为全文搜索
*  备注:多条件/模糊查询 @{@"sex":@"1",@"province":@"广东省",@"city":@""}
*  备注:查询条件可以为空
*/
- (void)queryUserTableWithUID:(NSString *)uid  accurateInfo:(NSDictionary *)accurateInfo fuzzyInfo:(NSDictionary *)fuzzyInfo otherSQLDict:(NSDictionary *)otherSQLDict complete:(void (^)(BOOL success,id obj))complete{
   
    CreatTable *model = [self setupUserDBqueueWithUID:uid];
    FMDatabaseQueue *queue = model.queue;
    
    NSString *tableName = tableNameFris(uid);
    
    [queue inDatabase:^(FMDatabase *db) {
        [db yh_excuteDatasWithTable:tableName model:[EPUserInfoModel new] userInfo:accurateInfo fuzzyUserInfo:fuzzyInfo otherSQL:otherSQLDict option:^(NSMutableArray *models) {
            complete(YES,models);
        }];
    }];
    
}



#pragma mark ---------Other---------


/*
 *  删除表
 */
- (void)deleteUserTableWithUD:(NSString *)uid complete:(void(^)(BOOL success,id obj))complete{
    
    NSString *pathFris = pathFrisWithDir(ZCFriendsDir, uid);
    BOOL success = [self deleteUserFileAtPath:pathFris];
   
    if (success) {
        for (CreatTable *model in self.kUserInfoArray) {
            NSString *aID = model.Id;
            if ([aID isEqualToString:uid]) {  [self.kUserInfoArray removeObject:model];  break; }
        }
    }
    complete(success,nil);
}

/*
 * 查询多个表数据
 * @param uids  表ID数组
 */
- (void)queryUserTableWithUIDs:(NSArray<NSString *> *)uids complete:(void (^)(NSArray *successUserInfos,NSArray *failUids))complete{
  
    __block NSMutableArray *failArr    = [NSMutableArray new];
    __block NSMutableArray *successArr = [NSMutableArray new];

    for (NSString *uid in uids) {
        [self queryOneUserWithUID:uid complete:^(BOOL success, id obj) {
            if (success) { if (obj) {  [successArr addObject:obj]; } }else{ [failArr addObject:uid];}
        }];
    }
    complete(successArr,failArr);
}

/** 删除路径的表数据 */
- (BOOL)deleteUserFileAtPath:(NSString *)filePath{
    if (!filePath || filePath.length == 0) {
        return NO;
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSLog(@"删除数据表文件出错, %@ is not exist!", filePath);
        return NO;
    }
    NSError *removeErr = nil;
    if (![[NSFileManager defaultManager] removeItemAtPath:filePath error:&removeErr] ) {
        NSLog(@"删除数据表文件失败！ %@", removeErr);
        return NO;
    }
    return YES;
}

/** 查询某个好友信息 */
- (void)queryOneUserWithUID:(NSString *)uid complete:(void (^)(BOOL success,id obj))complete{
    
    CreatTable *model = [self setupUserDBqueueWithUID:uid];
    FMDatabaseQueue *queue = model.queue;
    
    EPUserInfoModel *friInfo = [EPUserInfoModel new];
    friInfo.uid = uid;
    
    [queue inDatabase:^(FMDatabase *db) {
        [db yh_excuteDataWithTable:tableNameFris(uid) model:friInfo userInfo:nil fuzzyUserInfo:nil otherSQL:nil option:^(id output_model) {
            if (output_model) {
                complete(YES,output_model);
            }else{
                complete(NO,@"can not find user in dataBase");
            }
            
        }];
    }];
}


@end
