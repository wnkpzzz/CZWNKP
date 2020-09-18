//
//  SqliteManager.m
//  EPJH
//
//  Created by Hans on 2020/8/13.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "SqliteManager.h"

#define kDocumentDir            [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define kUserInfoPath           [kDocumentDir stringByAppendingPathComponent:@"kUserInfoTab.sqlite"]
#define kUserProjectPath        [kDocumentDir stringByAppendingPathComponent:@"kUserProjectTab.sqlite"]
#define kUserContrastPath       [kDocumentDir stringByAppendingPathComponent:@"kUserContrastTab.sqlite"]

@implementation CreatTable @end

@interface SqliteManager()
@property(nonatomic,retain) FMDatabaseQueue *dbQueue;
@property(nonatomic,strong) NSMutableArray < CreatTable *>*kUserInfoArray;          // 用户表数据组
@property(nonatomic,strong) NSMutableArray < CreatTable *>*kProjectInfoArray;       // 项目表数据组
@property(nonatomic,strong) NSMutableArray < CreatTable *>*kContrastInfoArray;      // 对比相册表数据组
@end

@implementation SqliteManager

/** 单例 */
+ (instancetype)sharedInstance{
    static SqliteManager *g_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_instance = [[SqliteManager alloc] init];
    });
    return g_instance;
}

#pragma mark --------------------------- 懒加载 ---------------------------

- (NSMutableArray<CreatTable *> *)kUserInfoArray{
    if (!_kUserInfoArray) {
        _kUserInfoArray = [NSMutableArray new];
    }
    return _kUserInfoArray;
}

- (NSMutableArray<CreatTable *> *)kProjectInfoArray{
    if (!_kProjectInfoArray) {
        _kProjectInfoArray = [NSMutableArray new];
    }
    return _kProjectInfoArray;
}

- (NSMutableArray<CreatTable *> *)kContrastInfoArray{
    if (!_kContrastInfoArray) {
        _kContrastInfoArray = [NSMutableArray new];
    }
    return _kContrastInfoArray;
}

#pragma mark ---------我的病人/用户---------

/** 校验是否存在数据表 */
- (CreatTable *)setupFrisDBqueueWithFriID:(NSString *)friID{
    
    //是否已存在Queue
    for (CreatTable *model in self.kUserInfoArray) {
        
        NSString *aID = model.Id;
        
        if ([aID isEqualToString:friID]) {
             
            return model;
            break;
        }
    }
    
    //没有就创建我的好友表
    return [self creatFrisTableWithfriID:friID];
}

/** 创建我的病人表 */
- (CreatTable *)creatFrisTableWithfriID:(NSString *)friID{
    
    CreatTable *model = [self firstCreatFrisQueueWithFriID:friID];
    FMDatabaseQueue *queue = model.queue;
    NSArray *sqlArr    = model.sqlCreatTable;
    for (NSString *sql in sqlArr) {
        [queue inDatabase:^(FMDatabase *db) {
            
            BOOL ok = [db executeUpdate:sql];
            if (ok == NO) {
                NSLog(@"创建我的病人表失败:%@---",sql);
            }
            
        }];
    }
    return model;
}

/** 第一次创建我的病人表 */
- (CreatTable *)firstCreatFrisQueueWithFriID:(NSString *)friID{
    
    // 数据表路径
    NSString *pathMyFri = pathFrisWithDir(ZCFriendsDir, friID);
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
    
    NSLog(@"第一次创建我的病人表,数据库操作路径------\n%@",pathMyFri);
    
    
    CreatTable *model = [[CreatTable alloc] init];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:pathMyFri];
    
    if (queue) {
        //存ID和队列
        model.Id = friID;
        model.queue = queue;
        
        //存SQL语句
        NSString *tableName = tableNameFris(friID);
        NSString *userSql = [EPUserInfoModel yh_sqlForCreatTable:tableName primaryKey:@"id"];
        
        NSArray *sqlArr = nil;
        if (userSql ) {  sqlArr = @[userSql];   }
        if (sqlArr) { model.sqlCreatTable = sqlArr;  }
        [self.kUserInfoArray addObject:model];
    }
    
    return model;
}

/** 删除路径的表数据 */
- (BOOL)deleteFileAtPath:(NSString *)filePath{
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

/** 综合搜索表 */
- (CreatTable *)setupFrisDBqueueWithTag:(NSString *)userID{
    
    //是否已存在Queue
    for (CreatTable *model in self.kUserInfoArray) {
        NSString *aID = model.Id;
        if ([aID isEqualToString:userID]) {
            
            return model;
            break;
        }
    }
    
    //没有就创建动态表
    return [self creatFrisTableWithfriID:userID];
    
}

/** 查询某个好友信息 */
- (void)queryOneFriWithID:(NSString *)friID complete:(void (^)(BOOL success,id obj))complete{
    
    NSString *myID = KUID;
    CreatTable *model = [self setupFrisDBqueueWithFriID:myID];
    FMDatabaseQueue *queue = model.queue;
    
    EPUserInfoModel *friInfo = [EPUserInfoModel new];
    friInfo.uid = friID;
    
    [queue inDatabase:^(FMDatabase *db) {
        [db yh_excuteDataWithTable:tableNameFris(myID) model:friInfo userInfo:nil fuzzyUserInfo:nil otherSQL:nil option:^(id output_model) {
            if (output_model) {
                complete(YES,output_model);
            }else{
                complete(NO,@"can not find user in dataBase");
            }
            
        }];
    }];
}

/*
 * 更新/插入单条用户数据
 * @param aFri         好友UserInfo
 * @param updateItems  传nil就是更新model的所有字段,否则更新数组里面的指定字段。eg:updateItems = @[@"userName",@"job"];
 * 更新好友的姓名和职位，注意字段名要填写正确
 */
- (void)updateOneFri:(EPUserInfoModel *)aFri updateItems:(NSArray <NSString *>*)updateItems complete:(void (^)(BOOL success,id obj))complete{
    
    if (!aFri.uid) {
        complete(NO,@"friID is nil");
        return;
    }
    
    NSString *myID = KUID;
    CreatTable *model = [self setupFrisDBqueueWithFriID:myID];
    FMDatabaseQueue *queue = model.queue;
    
    NSDictionary *otherSQL = nil;
    if (updateItems) {
        otherSQL = @{YHUpdateItemKey:updateItems};
    }
    
    
    [queue inDatabase:^(FMDatabase *db) {
        /** 存储:会自动调用insert或者update，不需要担心重复插入数据 */
        [db yh_saveDataWithTable:tableNameFris(myID)  model:aFri userInfo:nil otherSQL:otherSQL option:^(BOOL save) {
            complete(save,nil);
        }];
        
    }];
}

/*
*  插入/更新多条用户数据
*/
- (void)updateFrisListWithFriID:(NSString *)friID frislist:(NSArray <EPUserInfoModel *>*)frislist complete:(void (^)(BOOL success,id obj))complete{
    
    CreatTable *model = [self setupFrisDBqueueWithFriID:friID];
    FMDatabaseQueue *queue = model.queue;
    
    NSString *tableName = tableNameFris(friID);
    for (int i= 0; i< frislist.count; i++) {
        
        EPUserInfoModel *model = frislist[i];
        
        [queue inDatabase:^(FMDatabase *db) {
            /** 存储:会自动调用insert或者update，不需要担心重复插入数据 */
            [db yh_saveDataWithTable:tableName model:model userInfo:nil otherSQL:nil option:^(BOOL save) {
                if (i == frislist.count-1) {
                    complete(save,nil);
                }else{
                    if (!save) {
                        complete(save,@"插入/更新用户数据失败");
                    }
                }
                
            }];
            
        }];
    }
}

/*
 *  删除某一个病人数据
 */
- (void)deleteOneFriWithfriID:(NSString *)friID fri:(EPUserInfoModel *)fri userInfo:(NSDictionary *)userInfo complete:(void(^)(BOOL success,id obj))complete{
   
    CreatTable *model = [self setupFrisDBqueueWithFriID:friID];
    FMDatabaseQueue *queue = model.queue;
    
    [queue inDatabase:^(FMDatabase *db) {
        [db yh_deleteDataWithTable:tableNameFris(friID) model:fri userInfo:userInfo otherSQL:nil option:^(BOOL del) {
            complete(del,@(del));
        }];
    }];
}

/*
 *  删除病人表数据
 */
- (void)deleteFrisTableWithFriID:(NSString *)friID complete:(void(^)(BOOL success,id obj))complete{
    
    NSString *pathFris = pathFrisWithDir(ZCFriendsDir, friID);
    BOOL success = [self deleteFileAtPath:pathFris];
    if (success) {
        
        for (CreatTable *model in self.kUserInfoArray) {
            NSString *aID = model.Id;
            if ([aID isEqualToString:friID]) {
                [self.kUserInfoArray removeObject:model];
                break;
            }
        }
        
    }
    complete(success,nil);
}

/*
*  模糊/条件病人表
*  @param userInfo       条件查询
*  @param fuzzyUserInfo  模糊查询
*  备注:userInfo = nil && fuzzyUserInfo = nil 为全文搜索
*/
- (void)queryFrisTableWithFriID:(NSString *)friID userInfo:(NSDictionary *)userInfo fuzzyUserInfo:(NSDictionary *)fuzzyUserInfo complete:(void (^)(BOOL success,id obj))complete{
    
    CreatTable *model = [self setupFrisDBqueueWithFriID:friID];
    FMDatabaseQueue *queue = model.queue;
    
    [queue inDatabase:^(FMDatabase *db) {
        [db yh_excuteDatasWithTable:tableNameFris(friID) model:[EPUserInfoModel new] userInfo:userInfo fuzzyUserInfo:fuzzyUserInfo otherSQL:nil option:^(NSMutableArray *models) {
            complete(YES,models);
        }];
    }];
    
}

/*
* 模糊/条件查询病人数据
*  @param userInfo       条件查询
*  @param fuzzyUserInfo  模糊查询
*  备注:多条件查询 @{@"sex":@"1",@"province":@"广东省"}
*  备注:userInfo = nil && fuzzyUserInfo = nil 为全文搜索
*/
- (void)queryFrisTableWithTag:(NSString *)friID userInfo:(NSDictionary *)userInfo fuzzyUserInfo:(NSDictionary *)fuzzyUserInfo otherSQLDict:(NSDictionary *)otherSQLDict complete:(void (^)(BOOL success,id obj))complete{
   
    CreatTable *model = [self setupFrisDBqueueWithTag:friID];
    FMDatabaseQueue *queue = model.queue;
    
    NSString *tableName = tableNameFris(friID);
    
    [queue inDatabase:^(FMDatabase *db) {
        [db yh_excuteDatasWithTable:tableName model:[EPUserInfoModel new] userInfo:userInfo fuzzyUserInfo:fuzzyUserInfo otherSQL:otherSQLDict option:^(NSMutableArray *models) {
            complete(YES,models);
        }];
    }];
    
}

/*
* 查询多个病人表
* @param friIDs  表ID数组
*/
- (void)queryFrisWithfriIDs:(NSArray<NSString *> *)friIDs complete:(void (^)(NSArray *successUserInfos,NSArray *failUids))complete{
  
    __block NSMutableArray *successArr = [NSMutableArray new];
    __block NSMutableArray *failArr    = [NSMutableArray new];
    for (NSString *friID in friIDs) {
        [self queryOneFriWithID:friID complete:^(BOOL success, id obj) {
            if (success) {
                if (obj) {
                    [successArr addObject:obj];
                }
                
            }else{
                
                [failArr addObject:friID];
            }
        }];
    }
    complete(successArr,failArr);
    
    
}



#pragma mark --------------------------- 图片存储 ---------------------------

/*!
 * @getImageFromSandboxWithName
 *
 * @isBigPic 是否是大图片,采用不同加载方式
 *
 * @isOriginal 是否压缩,这里返回原图/缩略图,默认NO。
 *
*/
- (UIImage *)getImageFromSandboxWith:(NSString *)imageName isCacheImg:(BOOL)isCache isOriginal:(BOOL)isCompress{


    //    imageNamed:加载时会缓存图片
    //    imageWithContentsOfFile:仅加载图片，图像数据不会缓存。因此对于较大的图片以及使用情况较少时，那就可以用该方法，降低内存消耗。
    //    NSString *filePath = [ZCImageDir stringByAppendingPathComponent:imageName];
    //    UIImage *sandboxImage = [UIImage imageNamed:filePath];
    //    CGFloat scale = 1; if (isCompress) { scale = 1;}else{ scale = 0.01; }
    //    NSData *data = UIImageJPEGRepresentation(sandboxImage, scale);
    //    UIImage *resultImg  = [UIImage imageWithData:data];
    //    if (resultImg) {  return resultImg; }else{  return [UIImage imageNamed:@"ic_common_avatar_default"]; }
 
    NSString *filePath = [ZCImageDir stringByAppendingPathComponent:imageName];
    
    UIImage *sandboxImage = [[UIImage alloc] init];
     if (isCache) { sandboxImage = [UIImage imageNamed:filePath]; }else{ sandboxImage = [[UIImage alloc] initWithContentsOfFile:filePath]; }
 
    UIImage *resultImg = [[UIImage alloc] init];
    if (isCompress) {
        NSData *data = UIImageJPEGRepresentation(sandboxImage, 0.01); resultImg  = [UIImage imageWithData:data];
    }else{
        resultImg = sandboxImage;
    }
    if (resultImg) {  return resultImg; }else{  return placeHolderImg; }
     
}

 
 
@end
