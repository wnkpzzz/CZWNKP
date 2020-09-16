//
//  UIImage+Util.h
//  EPJH
//
//  Created by Hans on 2020/8/17.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Util)

/**纠正图片的方向*/
- (UIImage *)normalizedImage;

/** 生成纯色图片 */
- (UIImage *)app_createImageWithColor:(UIColor *)color size:(CGSize)size;

 
@end

NS_ASSUME_NONNULL_END
