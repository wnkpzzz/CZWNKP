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

/** 创建档案类型枚举 */
typedef NS_ENUM(NSInteger, CreateFilesType) {
    CreateFilesTypeNew  , // 新建用户案例
    CreateFilesTypeAdd  , // 选择已有用户增加案例
};

NS_ASSUME_NONNULL_BEGIN

@interface SqliteLogicHandler : NSObject

/** 单例 */
+ (instancetype)sharedInstance;
 
 
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
                   complete:(resultBackBlock)complete;

/* 图片存入本机相册
 * @param  picslist  拍摄的图片UIImage对象（在缓存中）
 */
- (void)savePictureToiPhoneAlbumWithPic:(NSArray <EPTakePictureModel *>*)picslist
                              complete:(resultBackBlock)complete;

@end

NS_ASSUME_NONNULL_END

