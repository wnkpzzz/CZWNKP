//
//  AppJump.h
//  EPJH
//
//  Created by Hans on 2020/7/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppJump : NSObject

//  引导页
+ (void)goLaunch;
//  登录页
+ (void)goLoginVC;
//  主页面
+ (void)goHomeVC;
//  退出登录
+ (void)goExitVc;

// 判断是否登录
+ (BOOL)isLogin;
// 是否第一次登陆
+ (BOOL)isNewFeature;

@end

NS_ASSUME_NONNULL_END
