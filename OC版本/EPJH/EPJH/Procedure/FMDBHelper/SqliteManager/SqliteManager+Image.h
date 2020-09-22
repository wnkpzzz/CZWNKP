//
//  SqliteManager+Image.h
//  EPJH
//
//  Created by Hans on 2020/9/22.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "SqliteManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface SqliteManager (Image)

#pragma mark ---------图片存储---------

/** 根据名称从沙盒路径中取出原图/缩略图,是否大图 */
- (UIImage *)getImageFromSandboxWith:(NSString *)imageName isCacheImg:(BOOL)isCache isOriginal:(BOOL)isCompress;


#pragma mark ---------我的图片---------


/*
 *  插入/更新图片表多条信息
 */
- (void)updateImagesListWithFriID:(NSString *)friID frislist:(NSArray <EPImageModel *>*)imgslist complete:(void (^)(BOOL success,id obj))complete;


/*
 *  删除某个图片
 */
- (void)deleteOneImageWithfriID:(NSString *)friID img:(EPImageModel *)img userInfo:(NSDictionary *)userInfo complete:(void(^)(BOOL success,id obj))complete;

/*
 * 查询图片表
 */
- (void)queryImageTableWithFriID:(NSString *)friID userInfo:(NSDictionary *)userInfo fuzzyUserInfo:(NSDictionary *)fuzzyUserInfo complete:(void (^)(BOOL success,id obj))complete;


@end

NS_ASSUME_NONNULL_END
