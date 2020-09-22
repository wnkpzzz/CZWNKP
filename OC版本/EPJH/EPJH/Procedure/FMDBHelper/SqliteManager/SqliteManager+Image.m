//
//  SqliteManager+Image.m
//  EPJH
//
//  Created by Hans on 2020/9/22.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "SqliteManager+Image.h"

@implementation SqliteManager (Image)


#pragma mark --------------------------- 图片存储 ---------------------------

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

 

@end
