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

/** 1、案例_创建新用户 */
- (void)create_newFiles_WithFri:(EPUserInfoModel *)userModel
                            Pro:(EPProjectModel *)proModel
                            img:(NSArray <EPImageModel *>*)imgslist
                            Pic:(NSArray <EPTakePictureModel *>*)picslist
                       complete:(resultBackBlock)complete;

/** 2、案例_为已有用户添加档案信息 */
- (void)create_addProInfo_WithPro:(EPProjectModel *)proModel
                              img:(NSArray <EPImageModel *>*)imgslist
                              Pic:(NSArray <EPTakePictureModel *>*)picslist
                         complete:(resultBackBlock)complete;

 

/** 3、用户档案创建-图片存入本机相册 */
- (void)saveImageInfoToiPhoneAlbumWith:(NSArray <EPTakePictureModel *>*)imgslist
                              complete:(resultBackBlock)complete;



- (void)createFilesType:(CreateFilesType)signType
                    Fri:(EPUserInfoModel *)friModel
                    Pro:(EPProjectModel *)proModel
                    Img:(NSArray <EPImageModel *>*)imgslist
                    Pic:(NSArray <EPTakePictureModel *>*)picslist
               complete:(resultBackBlock)complete;



@end

NS_ASSUME_NONNULL_END

