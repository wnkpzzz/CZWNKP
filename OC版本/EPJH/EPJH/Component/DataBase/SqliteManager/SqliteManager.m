//
//  SqliteManager.m
//  EPJH
//
//  Created by Hans on 2020/8/13.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "SqliteManager.h"

#define kDocumentDir            [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define kUserInfoPath           [kDocumentDir stringByAppendingPathComponent:@"kUserInfoTab.sqlite"]
#define kUserProjectPath        [kDocumentDir stringByAppendingPathComponent:@"kUserProjectTab.sqlite"]
#define kUserContrastPath       [kDocumentDir stringByAppendingPathComponent:@"kUserContrastTab.sqlite"]

@interface SqliteManager()
@property(nonatomic,retain) FMDatabaseQueue *dbQueue;
@property(nonatomic,strong) NSMutableArray < CreatTable *>*kUserInfoArray;          // 用户表数据组
@property(nonatomic,strong) NSMutableArray < CreatTable *>*kProjectInfoArray;       // 项目表数据组
@property(nonatomic,strong) NSMutableArray < CreatTable *>*kImageInfoArray;         // 图片表数据组
@property(nonatomic,strong) NSMutableArray < CreatTable *>*kContrastInfoArray;      // 对比相册表数据组
@end

@implementation SqliteManager

/** 单例 */
+ (instancetype)sharedInstance{
    static SqliteManager *g_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_instance = [[SqliteManager alloc] init];
    });
    return g_instance;
}

#pragma mark --------------------------- 懒加载 ---------------------------

- (NSMutableArray<CreatTable *> *)kUserInfoArray{
    if (!_kUserInfoArray) {
        _kUserInfoArray = [NSMutableArray new];
    }
    return _kUserInfoArray;
}

- (NSMutableArray<CreatTable *> *)kProjectInfoArray{
    if (!_kProjectInfoArray) {
        _kProjectInfoArray = [NSMutableArray new];
    }
    return _kProjectInfoArray;
}

- (NSMutableArray<CreatTable *> *)kImageInfoArray{
    if (!_kImageInfoArray) {
        _kImageInfoArray = [NSMutableArray new];
    }
    return _kImageInfoArray;
}

- (NSMutableArray<CreatTable *> *)kContrastInfoArray{
    if (!_kContrastInfoArray) {
        _kContrastInfoArray = [NSMutableArray new];
    }
    return _kContrastInfoArray;
}

#pragma mark --------------------------- 图片存储 ---------------------------

/*!
 * @getImageFromSandboxWithName
 *
 * @isBigPic 是否是大图片,采用不同加载方式
 *
 * @isOriginal 是否压缩,这里返回原图/缩略图,默认NO。
 *
*/
- (UIImage *)getImageFromSandboxWithName:(NSString *)imageName isBigPic:(BOOL)isBigPic isOriginal:(BOOL)isCompress{


    //    imageNamed:加载时会缓存图片
    //    imageWithContentsOfFile:仅加载图片，图像数据不会缓存。因此对于较大的图片以及使用情况较少时，那就可以用该方法，降低内存消耗。
    //
    //    NSString *filePath = [ZCImageDir stringByAppendingPathComponent:imageName];
    //    UIImage *sandboxImage = [UIImage imageNamed:filePath];
    //    CGFloat scale = 1; if (isCompress) { scale = 1;}else{ scale = 0.01; }
    //    NSData *data = UIImageJPEGRepresentation(sandboxImage, scale);
    //    UIImage *resultImg  = [UIImage imageWithData:data];
    //    if (resultImg) {  return resultImg; }else{  return [UIImage imageNamed:@"ic_common_avatar_default"]; }
 
    NSString *filePath = [ZCImageDir stringByAppendingPathComponent:imageName];
    
    UIImage *sandboxImage = [[UIImage alloc] init];
    if (isBigPic) {  sandboxImage = [UIImage imageWithContentsOfFile:filePath];
    }else{ sandboxImage = [UIImage imageNamed:filePath];}
     
    UIImage *resultImg = [[UIImage alloc] init];
    if (isCompress) {  NSData *data = UIImageJPEGRepresentation(sandboxImage, 0.01); resultImg  = [UIImage imageWithData:data];
    }else{  resultImg = sandboxImage;}
    
    if (resultImg) {  return resultImg; }else{  return placeHolderImg; }
     
}
 
 
@end
