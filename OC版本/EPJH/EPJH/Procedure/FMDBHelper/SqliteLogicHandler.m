//
//  SqliteLogicHandler.m
//  EPJH
//
//  Created by Hans on 2020/9/24.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "SqliteLogicHandler.h"

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

/** 1、用户档案创建-图片存入沙盒目录 */
- (void)saveImageInfoToSandboxWith:(NSArray <EPTakePictureModel *>*)imgslist
                          complete:(resultBackBlock)complete {
    
    __block BOOL isEnd = NO;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    for (int i = 0; i < imgslist.count; i++) {
//    for (EPTakePictureModel * imgModel in imgslist) {

        EPTakePictureModel * imgModel = imgslist[i];
        if (imgModel.cameraImage) {
            NSLog(@"任务A开始执行--%d",i);
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER); // -1 等待
            [[SqliteManager sharedInstance] saveImageToSandboxWith:imgModel.cameraImage AndName:imgModel.cameraImgStr complete:^(BOOL isSucess) {
                dispatch_semaphore_signal(semaphore); // + 1 释放
            
                // 模拟失败标记
                if (i == 3) { isSucess = NO;  }
 
                if (isSucess) {
                    NSLog(@"任务执行完毕-成功--%d",i);
                }else{
                    isEnd = YES;
                    NSLog(@"任务执行完毕-失败--%d",i);
                }
            }];
        }
        if (isEnd) { complete(NO); break; return; }
    }
}


/** 2、用户档案创建-图片存入本机相册 */
- (void)saveImageInfoToiPhoneAlbumWith:(NSArray <EPTakePictureModel *>*)imgslist
                              complete:(resultBackBlock)complete {
    
}

/** 3、用户档案创建-将图片+项目/病人信息存入数据库表 */
- (void)saveInfoToDataTableWithImg:(NSArray <EPImageModel *>*)imgslist
                               Pro:(NSArray <EPProjectModel *>*)proslist
                               Fri:(NSArray <EPUserInfoModel *>*)frislist
                          complete:(resultBackBlock)complete{
    
    if (imgslist == nil || imgslist.count == 0 || proslist == nil || proslist.count == 0 ) {  NSLog(@"传入数据为空"); complete(NO); }
       
    // 使用信号量保证串行队列+异步操作
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    __block BOOL isEnd = NO;

    NSLog(@"任务A开始执行");
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER); // -1 等待
    [[SqliteManager sharedInstance] updateImagesListWithUID:KUID datalist:imgslist complete:^(BOOL success, id  _Nonnull obj) {
        dispatch_semaphore_signal(semaphore); // + 1 释放

        success = NO; // 模拟失败标记

        if (success) {
            NSLog(@"任务A执行完毕-成功");
        }else{
            isEnd = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"任务A执行完毕-失败");
                complete(NO);
                return;
            });
        }
    }];

    if (isEnd) { return; }
    NSLog(@"任务B开始执行");
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    [[SqliteManager sharedInstance] updateProjectsListWithUID:KUID datalist:proslist complete:^(BOOL success, id  _Nonnull obj) {

        dispatch_semaphore_signal(semaphore);

        if (success) {
            NSLog(@"任务B执行完毕-成功");
        }else{
            isEnd = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"任务B执行完毕-失败");
                complete(NO);
                return;
            });
        }
    }];

    if (isEnd) { return; }
    NSLog(@"任务C开始执行");
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    [[SqliteManager sharedInstance] updateUsersListWithUID:KUID datalist:frislist complete:^(BOOL success, id  _Nonnull obj) {
        dispatch_semaphore_signal(semaphore);

        if (success) {
            NSLog(@"任务C执行完毕-成功");
            complete(YES);
        }else{
            isEnd = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"任务C执行完毕-失败");
                complete(NO);
                return;
            });
        }
    }];
}



@end


///** 1、用户档案创建-图片存入沙盒目录 */
//- (void)saveImageInfoToSandboxWith:(NSArray <EPTakePictureModel *>*)imgslist
//                          complete:(resultBackBlock)complete {
//
//    dispatch_group_t group = dispatch_group_create();
//
//    for (EPTakePictureModel * imgModel in imgslist) {
//
//        if (imgModel.cameraImage) {
//
//            dispatch_group_enter(group);
//            [[SqliteManager sharedInstance] saveImageToSandboxWith:imgModel.cameraImage AndName:imgModel.cameraImgStr complete:^(BOOL isSucess) {
//                dispatch_group_leave(group);
//
//                isSucess = NO;
//                dispatch_async(dispatch_get_main_queue(), ^{
//
//                    if (isSucess) {
//                        NSLog(@"========OK");
//
//                    }else{
//
//                        NSLog(@"========NO");
//
//                    }
//                });
//
//
//            }];
//        }
//    }
//
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//
//    NSLog(@"========图片保存完成========");
//
//    });
//
//}
