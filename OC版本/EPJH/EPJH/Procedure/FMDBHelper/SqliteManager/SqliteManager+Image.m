//
//  SqliteManager+Image.m
//  EPJH
//
//  Created by Hans on 2020/9/22.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "SqliteManager+Image.h"

@implementation SqliteManager (Image)


#pragma mark ---------图片存储---------

/** 图片保存到沙盒指定目录 */
- (BOOL)saveImageToSandboxWith:(UIImage *)image AndName:(NSString *)imageName {
    
    
    //如果不存在,则说明是第一次运行这个程序，那么建立这个文件夹
    NSFileManager *fileM = [NSFileManager defaultManager];
    if(![fileM fileExistsAtPath:ZCImageDir]){
        
        if (![fileM fileExistsAtPath:ZCUserDir]) {
            [fileM createDirectoryAtPath:ZCUserDir withIntermediateDirectories:YES attributes:nil error:nil];
        }
        if (![fileM fileExistsAtPath:ZCImageDir]) {
            [fileM createDirectoryAtPath:ZCImageDir withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    
    NSString *filePath = [ZCImageDir stringByAppendingPathComponent:imageName];  // 保存文件的名称
    BOOL result = [UIImagePNGRepresentation(image)writeToFile:filePath atomically:YES]; // 执行保存命令
    if (result == YES) {  NSLog(@"图片保存到沙盒指定目录,保存成功");  }else{  NSLog(@"图片保存到沙盒指定目录,保存失败");}
    return result;
}

/*
 * 根据名称从沙盒路径中取出原图/缩略图,是否大图
 * @isBigPic    是否是大图片,采用不同加载方式
 * @isOriginal  是否压缩,这里返回原图/缩略图,默认NO。
*/
- (UIImage *)getImageFromSandboxWith:(NSString *)imageName isCacheImg:(BOOL)isCache isOriginal:(BOOL)isCompress{


    //  imageNamed:加载时会缓存图片
    //  imageWithContentsOfFile:仅加载图片，图像数据不会缓存。因此对于较大的图片以及使用情况较少时，那就可以用该方法，降低内存消耗。

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

/** 删除沙盒指定目录下的图片 */
- (BOOL)deleteImageFromSandboxWith:(NSString *)imageName{
    
    NSLog(@"执行删除沙盒指定目录下的图片操作");

    if (imageName && imageName.length > 0) {
        
        NSString *filePath = [ZCImageDir stringByAppendingPathComponent:imageName];  // 保存文件的名称
        BOOL isHave = [[NSFileManager defaultManager] fileExistsAtPath:filePath]; // 判断文件是否存在

        if (isHave == YES) {
          
          BOOL result = [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
          if (result == YES) { NSLog(@"删除成功");  }else{  NSLog(@"删除失败"); }
          return result;
            
        }else{  NSLog(@"删除的文件不存在");}
        
        return isHave;

    }else{
         
        NSLog(@"删除的文件名为空");
        return NO;
    }
}


#pragma mark ---------Private---------

/** 校验是否存在数据表 */
- (CreatTable *)setupImageProDBqueueWithUID:(NSString *)uid{
    
    //是否已存在Queue
    for (CreatTable *model in self.kImageProInfoArray) {
        NSString *aID = model.Id;
        if ([aID isEqualToString:uid]) { return model; break; }
    }
    
    //没有就创建我的好友表
    return [self creatImageProTableWithUID:uid];
}

/** 创建我的项目表 */
- (CreatTable *)creatImageProTableWithUID:(NSString *)uid{
    
    CreatTable *model = [self firstCreatImageProQueueWithUID:uid];
    FMDatabaseQueue *queue = model.queue;
    NSArray *sqlArr    = model.sqlCreatTable;
    
    for (NSString *sql in sqlArr) {
        [queue inDatabase:^(FMDatabase *db) {
            BOOL ok = [db executeUpdate:sql];
            if (ok == NO) { NSLog(@"创建我的图片表SQL执行失败:%@",sql); }
        }];
    }
    return model;
}

/** 第一次建我的项目表 */
- (CreatTable *)firstCreatImageProQueueWithUID:(NSString *)uid{
    
    // 数据表路径
    NSString *pathMyFri = pathImageProWithDir(ZCImageProDir, uid);
    NSFileManager *fileM = [NSFileManager defaultManager];
    
    //如果不存在,则说明是第一次运行这个程序，那么建立这个文件夹
    if(![fileM fileExistsAtPath:ZCImageProDir]){
        if (![fileM fileExistsAtPath:ZCUserDir]) {
            [fileM createDirectoryAtPath:ZCUserDir withIntermediateDirectories:YES attributes:nil error:nil];
        }
        if (![fileM fileExistsAtPath:ZCImageProDir]) {
            [fileM createDirectoryAtPath:ZCImageProDir withIntermediateDirectories:YES attributes:nil error:nil];
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
        NSString *tableName = tableNameImagePro(uid);
        NSString *userSql = [EPImageModel yh_sqlForCreatTable:tableName primaryKey:@"id"];
        NSArray *sqlArr = nil;
        if (userSql ) {  sqlArr = @[userSql];   }
        if (sqlArr) { model.sqlCreatTable = sqlArr;  }
        [self.kImageProInfoArray addObject:model];
    }
    
    return model;
}
 
 #pragma mark ---------我的图片---------


 /*
  * 向表中更新/插入多条数据
  */
- (void)updateImagesListWithUID:(NSString *)uid datalist:(NSArray <EPImageModel *>*)imgslist complete:(void (^)(BOOL success,id obj))complete{
 
    CreatTable *model = [self setupImageProDBqueueWithUID:uid];
      FMDatabaseQueue *queue = model.queue;

      NSString *tableName = tableNameImagePro(uid);
      for (int i= 0; i< imgslist.count; i++) {

          EPImageModel *model = imgslist[i];

          [queue inDatabase:^(FMDatabase *db) {
              /** 存储:会自动调用insert或者update，不需要担心重复插入数据 */
              [db yh_saveDataWithTable:tableName model:model userInfo:nil otherSQL:nil option:^(BOOL save) {
                  if (i == imgslist.count-1) {
                      complete(save,nil);
                  }else{
                      if (!save) {
                          complete(save,@"【图片表】插入多/单条数据失败");
                      }
                  }
              }];
          }];
      }
}


 /*
  *  删除某个图片
  */
- (void)deleteOneImageWithUID:(NSString *)uid dataModel:(EPImageModel *)dataModel complete:(void(^)(BOOL success,id obj))complete{
    
    CreatTable *model = [self setupImageProDBqueueWithUID:uid];
    FMDatabaseQueue *queue = model.queue;

    [queue inDatabase:^(FMDatabase *db) {
        [db yh_deleteDataWithTable:tableNameImagePro(uid) model:dataModel userInfo:nil otherSQL:nil option:^(BOOL del) {
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
- (void)queryImageTableWithUID:(NSString *)uid accurateInfo:(NSDictionary *)accurateInfo fuzzyInfo:(NSDictionary *)fuzzyInfo otherSQLDict:(NSDictionary *)otherSQLDict complete:(void (^)(BOOL success,id obj))complete{
    
    CreatTable *model = [self setupImageProDBqueueWithUID:uid];
    FMDatabaseQueue *queue = model.queue;

    [queue inDatabase:^(FMDatabase *db) {
        [db yh_excuteDatasWithTable:tableNameImagePro(uid) model:[EPImageModel new] userInfo:accurateInfo fuzzyUserInfo:fuzzyInfo otherSQL:otherSQLDict option:^(NSMutableArray *models) {
            complete(YES,models);
        }];
    }];
    
}



@end
