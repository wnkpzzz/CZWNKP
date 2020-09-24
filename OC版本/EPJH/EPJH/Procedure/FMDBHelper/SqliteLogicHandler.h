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

/** 1、用户档案创建-图片存入沙盒目录 */
- (void)saveImageInfoToSandboxWith:(NSArray <EPTakePictureModel *>*)imgslist complete:(resultBackBlock)complete;

/** 2、用户档案创建-图片存入本机相册 */
- (void)saveImageInfoToiPhoneAlbumWith:(NSArray <EPTakePictureModel *>*)imgslist complete:(resultBackBlock)complete;

/** 3、用户档案创建-图片,项目,病人信息存入数据库表 */
- (void)saveInfoToDataTableWithImg:(NSArray <EPImageModel *>*)imgslist Pro:(EPProjectModel *)proModel Fri:(EPUserInfoModel *)userModel complete:(resultBackBlock)complete;


@end

NS_ASSUME_NONNULL_END
