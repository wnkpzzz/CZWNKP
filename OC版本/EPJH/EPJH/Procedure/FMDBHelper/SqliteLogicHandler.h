//
//  SqliteLogicHandler.h
//  EPJH
//
//  Created by Hans on 2020/9/24.
//  Copyright © 2020 hans3d. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "EPTakePictureModel.h"

/** 数据返回Block */
typedef void(^resultBackBlock)(BOOL isSucess);

NS_ASSUME_NONNULL_BEGIN

@interface SqliteLogicHandler : NSObject

/** 单例 */
+ (instancetype)sharedInstance;

/** 1、用户档案创建-图片存入数据库 */
- (void)saveImageInfoToSandboxWith:(NSArray <EPTakePictureModel *>*)imgslist complete:(resultBackBlock)complete;

/** 2、用户档案创建-图片,项目,病人信息存入数据库表 */
- (void)saveInfoToDataTableWithImg:(NSArray <EPImageModel *>*)imgslist Pro:(NSArray <EPProjectModel *>*)proslist Fri:(NSArray <EPUserInfoModel *>*)frislist complete:(resultBackBlock)complete;


@end

NS_ASSUME_NONNULL_END
