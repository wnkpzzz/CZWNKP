//
//  SqliteDataHandler.m
//  EPJH
//
//  Created by Hans on 2020/9/24.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "SqliteDataHandler.h"

@interface SqliteDataHandler()

@end

@implementation SqliteDataHandler

/** 单例 */
+ (instancetype)sharedInstance{
    static SqliteDataHandler *g_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_instance = [[SqliteDataHandler alloc] init];
    });
    return g_instance;
}

/** 1、用户档案创建-图片存入数据库 */
- (void)saveImageInfoToSandboxWith:(NSArray <EPTakePictureModel *>*)imgslist complete:(resultBackBlock)complete {
    
    for (EPTakePictureModel * imgModel in imgslist) {
 
        if (imgModel.cameraImage) {
            
        }
    }
    
}

 
/** 2、用户档案创建-图片,项目,病人信息存入数据库表 */
- (void)saveInfoToDataTableWithImg:(NSArray <EPImageModel *>*)imgslist Pro:(NSArray <EPProjectModel *>*)proslist Fri:(NSArray <EPUserInfoModel *>*)frislist complete:(resultBackBlock)complete {
    
    
}


@end
