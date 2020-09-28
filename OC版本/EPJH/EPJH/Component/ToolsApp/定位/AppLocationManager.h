//
//  AppLocationManager.h
//  EPJH
//
//  Created by Hans on 2020/9/28.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppLocationManager : NSObject

/** 类方法初始化 */
+ (void)getCityAndProvinceWithComplete;

@end

NS_ASSUME_NONNULL_END
