//
//  UIColor+Util.h
//  EPJH
//
//  Created by Hans on 2020/8/13.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Util)

 
/** 十六进制转UIColor */
+(UIColor *)colorWithHexString:(NSString *)stringToConvert;

@end

NS_ASSUME_NONNULL_END
