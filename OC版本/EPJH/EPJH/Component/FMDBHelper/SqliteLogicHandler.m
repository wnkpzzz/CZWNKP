//
//  SqliteLogicHandler.m
//  EPJH
//
//  Created by Hans on 2020/9/24.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "SqliteLogicHandler.h"
#import <Photos/Photos.h>

@interface SqliteLogicHandler()

@end


@implementation SqliteLogicHandler

/** 单例 */
+ (instancetype)sharedInstance{
    
    static SqliteLogicHandler *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SqliteLogicHandler alloc] init];
    });
    return instance;
}

/*
 * 用户案例新建/案例新增
 * @param  signType  新建病人/选择已有病人
 * @param  friModel  病人信息数据
 * @param  proModel  项目信息数据
 * @param  imgslist  图片信息数据
 * @param  picslist  拍摄的图片UIImage对象（在缓存中）
 * @param  complete  Block返回
*/
- (void)createFilesWithType:(CreateFilesType)signType
                        Fri:(EPUserInfoModel *)friModel
                        Pro:(EPProjectModel *)proModel
                        Img:(NSArray <EPImageModel *>*)imgslist
                        Pic:(NSArray <EPTakePictureModel *>*)picslist
                   complete:(resultBackBlock)complete{
    
    // 1、数据非空校验
    if ( proModel == nil || imgslist.count == 0 || picslist.count == 0 ) { complete(NO); NSLog(@"请补全完整信息"); }
 
    // 2、数据准备
    NSMutableArray * frislist = [NSMutableArray arrayWithCapacity:10];
    NSMutableArray * proslist = [NSMutableArray arrayWithCapacity:10];
    [frislist addObject:friModel]; [proslist addObject:proModel];

    // 3、图片插入沙盒指定目录
    [self savePictureInfoWithImg:picslist complete:^(BOOL isSucess) {
        if (!isSucess) { complete(NO); return; }
    }];

    // 4、信息插入数据库表
    [self saveInfoToDataTableWithType:signType Fri:frislist Pro:proslist Img:imgslist complete:^(BOOL isSucess) {
        if (isSucess) { complete(YES); }else{ complete(NO); }
    }];
    
}


- (void)savePictureInfoWithImg:(NSArray <EPTakePictureModel *>*)imgslist
                          complete:(resultBackBlock)complete {
    
    __block BOOL isEnd = NO;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);

    for (int i = 0; i < imgslist.count; i++) {
        EPTakePictureModel * imgModel = imgslist[i];
        if (imgModel.cameraImage) {
            NSLog(@"图片保存任务开始执行--%d",i);
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER); // -1 等待
            [[SqliteManager sharedInstance] saveImageToSandboxWith:imgModel.cameraImage AndName:imgModel.cameraImgStr complete:^(BOOL isSucess) {
              dispatch_semaphore_signal(semaphore); // + 1 释放

                if (isSucess) {
                    NSLog(@"图片保存任务执行完毕-成功--%d",i);
                }else{
                    isEnd = YES;
                    NSLog(@"图片保存任务执行完毕-失败--%d",i);
                }
            }];
        }
        if (isEnd) { complete(NO); break; return; }
    }
}


- (void)saveInfoToDataTableWithType:(CreateFilesType)signType
                                Fri:(NSArray <EPUserInfoModel *>*)frislist
                                Pro:(NSArray <EPProjectModel *>*)proslist
                                Img:(NSArray <EPImageModel *>*)imgslist
                           complete:(resultBackBlock)complete{
 
    __block BOOL isEnd = NO;
 dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);

    NSLog(@"数据表任务A_开始执行");
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER); // -1 等待
    [[SqliteManager sharedInstance] updateImagesListWithUID:KUID datalist:imgslist complete:^(BOOL success, id  _Nonnull obj) {
        dispatch_semaphore_signal(semaphore); // + 1 释放

        if (success) {
            NSLog(@"数据表任务A_执行完毕-成功");
        }else{
            isEnd = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"数据表任务A_执行完毕-失败");
                complete(NO);
                return;
            });
        }
    }];

    if (isEnd) { return; }
    NSLog(@"数据表任务B_开始执行");
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER); // -1 等待
    [[SqliteManager sharedInstance] updateProjectsListWithUID:KUID datalist:proslist complete:^(BOOL success, id  _Nonnull obj) {
        dispatch_semaphore_signal(semaphore); // + 1 释放

        if (success) {
            NSLog(@"数据表任务B_执行完毕-成功");
            // 如果是选择已有用户,新增案例信息，则只保存项目+图片，不会流转到下一进程。
            if (signType == CreateFilesTypeAdd) {
                isEnd = YES;
                dispatch_async(dispatch_get_main_queue(), ^{
                    complete(YES);
                    return;
                });
            }
        }else{
            isEnd = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"数据表任务B_执行完毕-失败");
                complete(NO);
                return;
            });
        }
    }];

    if (isEnd) { return; }
    NSLog(@"数据表任务C_开始执行");
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER); // -1 等待
    [[SqliteManager sharedInstance] updateUsersListWithUID:KUID datalist:frislist complete:^(BOOL success, id  _Nonnull obj) {
        dispatch_semaphore_signal(semaphore); // + 1 释放

        if (success) {
            NSLog(@"数据表任务C_执行完毕-成功");
            complete(YES);
        }else{
            isEnd = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"数据表任务C_执行完毕-失败");
                complete(NO);
                return;
            });
        }
    }];
}

/* 图片存入本机相册
 * @param  picslist  拍摄的图片UIImage对象（在缓存中）
 */
- (void)savePictureToiPhoneAlbumWithPic:(NSArray <EPTakePictureModel *>*)picslist
                               complete:(resultBackBlock)complete{
    // 标记数据
    int endIndex = 0;
    __block BOOL isEnd = NO;

    // 获取最后一张的索引
    for (int i = 0; i < picslist.count; i++) {
        EPTakePictureModel *picModel = [picslist objectAtIndex:i];
        if (picModel.cameraImage) { endIndex = i; }
    }
     
    // 循环保存
    for (int i = 0; i < picslist.count; i++) {
        EPTakePictureModel *picModel = [picslist objectAtIndex:i];
        if (picModel.cameraImage) {

            // 转NSData(保证图片高质量UIImagePNGRepresentation)
            NSData *imageData = UIImagePNGRepresentation(picModel.cameraImage);
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                PHAssetResourceCreationOptions *options = [[PHAssetResourceCreationOptions alloc] init];
                PHAssetCreationRequest *createRequest = [PHAssetCreationRequest creationRequestForAsset];
                [createRequest addResourceWithType:PHAssetResourceTypePhoto data:imageData options:options];
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (success) {
                        NSLog(@"图片保存本机相册----OK");
                        if (i == endIndex) {  complete(YES); }
                    }else{
                        NSLog(@"图片保存本机相册----NO");
                        isEnd = YES;
                    }
                });
            }];
        }
        if (isEnd) { complete(NO); break; return; }
    }
}

/* 查询首页-SQL语句
 * @param  key  查询参数
 */
- (NSString *)formatSQLStrWithName:(NSString *)nameKey
                              Date:(NSString *)dateKey    
                               Pro:(NSString *)proKey
                               Age:(NSString *)ageKey
                          Province:(NSString *)provinceKey
                              City:(NSString *)cityKey
                           Collect:(NSString *)collectKey
                              Page:(NSInteger)pageKey{
 

    
    
    
    NSString * sqlStr = @"";

    NSString * nameSqlStr = @"";
    NSString * dateSqlStr = @"";
    NSString * proSqlStr = @"";
    NSString * ageSqlStr = @"";
    NSString * locationSqlStr = @"";
    NSString * collectSqlStr = @"";
    NSString * pagingSqlStr = @"";
    
    NSInteger page = pageKey * 10 + 1;
    NSInteger pageSize = (pageKey + 1) * 10;
    NSString *firTabName = [NSString stringWithFormat:@"fri_%@",KUID];
    NSString *proTabName = [NSString stringWithFormat:@"pro_%@",KUID];
    
    if (nameKey && nameKey.length > 0 ) {
          nameSqlStr = [NSString stringWithFormat:@" and realName like '%%%@%%' " , nameKey];
    }
   
    if (ageKey && ageKey.length > 0 )   {
        if ([ageKey isEqualToString:@"00后"]) {  ageSqlStr = @" and age > 8  and age <= 18 "; }
        if ([ageKey isEqualToString:@"90后"]) {  ageSqlStr = @" and age > 18 and age <= 28 "; }
        if ([ageKey isEqualToString:@"80后"]) {  ageSqlStr = @" and age > 28 and age <= 38 "; }
        if ([ageKey isEqualToString:@"70后"]) {  ageSqlStr = @" and age > 38 and age <= 48 "; }
        if ([ageKey isEqualToString:@"60后"]) {  ageSqlStr = @" and age > 48 and age <= 58 "; }
        if ([ageKey isEqualToString:@"50后"]) {  ageSqlStr = @" and age > 58 and age <= 68 "; }
    }
    if (cityKey && cityKey.length > 0 && provinceKey.length > 0 && provinceKey.length > 0) {
        locationSqlStr = [NSString stringWithFormat:@" and province = %@ and city = %@" , provinceKey,cityKey];
    }
    if (collectKey && collectKey.length > 0 ) {
        collectSqlStr = [NSString stringWithFormat:@" and isCollect = %@" , collectKey];
    }
    pagingSqlStr = [NSString stringWithFormat:@" order by id asc limit %ld,%ld" , page,pageSize];
 
    
    NSString * proTablSQLStr = @"";
//    if (dateKey && dateKey.length > 0 ) {
//        dateSqlStr = [NSString stringWithFormat:@" and createTime = %@" , dateKey];
//    }
//    if (proKey && proKey.length > 0 )   {
//        proSqlStr  = [NSString stringWithFormat:@" and project = %@" , proKey];
//    }
//
//    NSString * proTablSQLStr = [NSString stringWithFormat:@" and customerId in (select customerId from %@  where bindUserId = %@ %@ %@) ",proTabName,KUID,dateSqlStr,proSqlStr];
//    NSLog(@"%@",proTablSQLStr);
     
    sqlStr = [NSString stringWithFormat:@"select * from %@ where bindUserId = %@ %@ %@ %@ %@ %@ %@",firTabName,KUID,nameSqlStr,proTablSQLStr,ageSqlStr,locationSqlStr,collectSqlStr,pagingSqlStr];
    NSLog(@"%@",sqlStr);
    
    return sqlStr;
    
}



@end

///* 查询首页-SQL语句
// * @param  key  查询参数
// */
//- (NSString *)formatSQLStrWithName:(NSString *)nameKey
//                              Date:(NSString *)dateKey
//                               Pro:(NSString *)proKey
//                               Age:(NSString *)ageKey
//                          Province:(NSString *)provinceKey
//                              City:(NSString *)cityKey
//                           Collect:(NSString *)collectKey
//                              Page:(NSInteger)pageKey{
//
//    NSString * sqlStr = @"";
//    NSString * nameSqlStr = @"";
//    NSString * dateSqlStr = @"";
//    NSString * proSqlStr = @"";
//    NSString * ageSqlStr = @"";
//    NSString * locationSqlStr = @"";
//    NSString * collectSqlStr = @"";
//    NSString * pagingSqlStr = @"";
//    NSInteger page = pageKey * 10 + 1;
//    NSInteger pageSize = (pageKey + 1) * 10;
//    NSString *tabName = [NSString stringWithFormat:@"fri_%@",KUID];
//
//    if (nameKey && nameKey.length > 0 ) {
//          nameSqlStr = [NSString stringWithFormat:@" and realName like '%%%@%%' " , nameKey];
//    }
//    if (dateKey && dateKey.length > 0 ) {
//        dateSqlStr = [NSString stringWithFormat:@" and timeFormat = %@" , dateKey];
//    }
//    if (proKey && proKey.length > 0 )   {
//        proSqlStr  = [NSString stringWithFormat:@" and subCateName = %@" , proKey];
//    }
//    if (ageKey && ageKey.length > 0 )   {
//        if ([ageKey isEqualToString:@"00后"]) {  ageSqlStr = @" and age > 8  and age <= 18 "; }
//        if ([ageKey isEqualToString:@"90后"]) {  ageSqlStr = @" and age > 18 and age <= 28 "; }
//        if ([ageKey isEqualToString:@"80后"]) {  ageSqlStr = @" and age > 28 and age <= 38 "; }
//        if ([ageKey isEqualToString:@"70后"]) {  ageSqlStr = @" and age > 38 and age <= 48 "; }
//        if ([ageKey isEqualToString:@"60后"]) {  ageSqlStr = @" and age > 48 and age <= 58 "; }
//        if ([ageKey isEqualToString:@"50后"]) {  ageSqlStr = @" and age > 58 and age <= 68 "; }
//    }
//    if (cityKey && cityKey.length > 0 && provinceKey.length > 0 && provinceKey.length > 0) {
//        locationSqlStr = [NSString stringWithFormat:@" and province = %@ and city = %@" , provinceKey,cityKey];
//    }
//    if (collectKey && collectKey.length > 0 ) {
//        collectSqlStr = [NSString stringWithFormat:@" and isCollect = %@" , collectKey];
//    }
//    pagingSqlStr = [NSString stringWithFormat:@" order by id asc limit %ld,%ld" , page,pageSize];
//
//    sqlStr = [NSString stringWithFormat:@"select * from %@ where bindUserId = %@ %@ %@ %@ %@ %@ %@ %@",tabName,KUID,nameSqlStr,dateSqlStr,proSqlStr,ageSqlStr,locationSqlStr,collectSqlStr,pagingSqlStr];
//    NSLog(@"%@",sqlStr);
//
//    return sqlStr;
//
//}
