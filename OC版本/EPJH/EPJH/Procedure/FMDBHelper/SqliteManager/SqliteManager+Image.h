//
//  SqliteManager+Image.h
//  EPJH
//
//  Created by Hans on 2020/9/22.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "SqliteManager.h"


/** 数据返回Block */
typedef void(^handleBackBlock)(BOOL isSucess);

NS_ASSUME_NONNULL_BEGIN

@interface SqliteManager (Image)

#pragma mark ---------图片存储---------

/** 项目图片保存到沙盒指定目录 */
- (BOOL)saveImageToSandboxWith:(UIImage *)image AndName:(NSString *)imageName;

/** 删除沙盒指定目录下的图片 */
- (BOOL)deleteImageFromSandboxWith:(NSString *)imageName;

/*
 * 根据名称从沙盒路径中取出原图/缩略图,是否大图
 * @isBigPic    是否是大图片,采用不同加载方式
 * @isOriginal  是否压缩,这里返回原图/缩略图,默认NO。
*/
- (UIImage *)getImageFromSandboxWith:(NSString *)imageName isCacheImg:(BOOL)isCache isOriginal:(BOOL)isCompress;

#pragma mark ---------我的图片---------


/*
 * 向表中更新/插入多条数据
 */
- (void)updateImagesListWithUID:(NSString *)uid datalist:(NSArray <EPImageModel *>*)imgslist complete:(void (^)(BOOL success,id obj))complete;


/*
 *  删除某个图片
 */
- (void)deleteOneImageWithUID:(NSString *)uid dataModel:(EPImageModel *)dataModel complete:(void(^)(BOOL success,id obj))complete;


/*
*  模糊/条件查询表数据
*  @param accurateInfo       条件查询
*  @param fuzzyInfo          模糊查询
*  备注:userInfo = nil && fuzzyUserInfo = nil 为全文搜索
*  备注:多条件/模糊查询 @{@"sex":@"1",@"province":@"广东省",@"city":@""}
*  备注:查询条件可以为空
*/
- (void)queryImageTableWithUID:(NSString *)uid accurateInfo:(NSDictionary *)accurateInfo fuzzyInfo:(NSDictionary *)fuzzyInfo otherSQLDict:(NSDictionary *)otherSQLDict complete:(void (^)(BOOL success,id obj))complete;


@end

NS_ASSUME_NONNULL_END
