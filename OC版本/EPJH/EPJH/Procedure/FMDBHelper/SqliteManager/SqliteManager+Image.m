//
//  SqliteManager+Image.m
//  EPJH
//
//  Created by Hans on 2020/9/22.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "SqliteManager+Image.h"

@implementation SqliteManager (Image)


#pragma mark ---------图片存储---------

/*!
 * @getImageFromSandboxWithName
 *
 * @isBigPic 是否是大图片,采用不同加载方式
 *
 * @isOriginal 是否压缩,这里返回原图/缩略图,默认NO。
 *
*/
- (UIImage *)getImageFromSandboxWith:(NSString *)imageName isCacheImg:(BOOL)isCache isOriginal:(BOOL)isCompress{


    //    imageNamed:加载时会缓存图片
    //    imageWithContentsOfFile:仅加载图片，图像数据不会缓存。因此对于较大的图片以及使用情况较少时，那就可以用该方法，降低内存消耗。
    //    NSString *filePath = [ZCImageDir stringByAppendingPathComponent:imageName];
    //    UIImage *sandboxImage = [UIImage imageNamed:filePath];
    //    CGFloat scale = 1; if (isCompress) { scale = 1;}else{ scale = 0.01; }
    //    NSData *data = UIImageJPEGRepresentation(sandboxImage, scale);
    //    UIImage *resultImg  = [UIImage imageWithData:data];
    //    if (resultImg) {  return resultImg; }else{  return [UIImage imageNamed:@"ic_common_avatar_default"]; }
 
    NSString *filePath = [ZCImageDir stringByAppendingPathComponent:imageName];
    
    UIImage *sandboxImage = [[UIImage alloc] init];
     if (isCache) { sandboxImage = [UIImage imageNamed:filePath]; }else{ sandboxImage = [[UIImage alloc] initWithContentsOfFile:filePath]; }
 
    UIImage *resultImg = [[UIImage alloc] init];
    if (isCompress) {
        NSData *data = UIImageJPEGRepresentation(sandboxImage, 0.01); resultImg  = [UIImage imageWithData:data];
    }else{
        resultImg = sandboxImage;
    }
    if (resultImg) {  return resultImg; }else{  return placeHolderImg; }
     
}




#pragma mark ---------Private---------



 #pragma mark ---------我的图片---------


 /*
  * 向表中更新/插入多条数据
  */
- (void)updateImagesListWithUID:(NSString *)uid frislist:(NSArray <EPImageModel *>*)imgslist complete:(void (^)(BOOL success,id obj))complete{
    
}


 /*
  *  删除某个图片
  */
- (void)deleteOneImageWithUID:(NSString *)uid dataModel:(EPImageModel *)dataModel complete:(void(^)(BOOL success,id obj))complete{
    
    
}


 /*
 *  模糊/条件查询表数据
 *  @param accurateInfo       条件查询
 *  @param fuzzyInfo          模糊查询
 *  备注:userInfo = nil && fuzzyUserInfo = nil 为全文搜索
 *  备注:多条件/模糊查询 @{@"sex":@"1",@"province":@"广东省",@"city":@""}
 *  备注:查询条件可以为空
 */
- (void)queryImageTableWithUID:(NSString *)uid accurateInfo:(NSDictionary *)accurateInfo fuzzyInfo:(NSDictionary *)fuzzyInfo otherSQLDict:(NSDictionary *)otherSQLDict complete:(void (^)(BOOL success,id obj))complete{
    
    
}



@end
