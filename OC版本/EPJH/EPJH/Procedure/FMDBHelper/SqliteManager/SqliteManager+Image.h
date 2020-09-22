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


@end

NS_ASSUME_NONNULL_END
