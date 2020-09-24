//
//  DatabaseLogicHandler.m
//  EPJH
//
//  Created by Hans on 2020/9/24.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "DatabaseLogicHandler.h"

@interface DatabaseLogicHandler()

@end


@implementation DatabaseLogicHandler

/** 单例 */
+ (instancetype)sharedInstance{
    static DatabaseLogicHandler *g_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_instance = [[DatabaseLogicHandler alloc] init];
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
