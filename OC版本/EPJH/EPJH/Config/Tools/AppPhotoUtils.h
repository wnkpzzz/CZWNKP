//
//  AppPhotoUtils.h
//  EPJH
//
//  Created by Hans on 2020/8/13.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppPhotoUtils : NSObject

/** 手机闪光灯控制打开/关闭 */
+ (void)controlClashlightWith:(BOOL)switchFlag;
 
/** 对图片尺寸剪裁 */
+ (UIImage *)thumbnailWithImage:(UIImage *)originalImage size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
