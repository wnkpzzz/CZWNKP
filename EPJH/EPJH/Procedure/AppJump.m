//
//  AppJump.m
//  EPJH
//
//  Created by Hans on 2020/7/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "AppJump.h"
#import "EPLaunchViewCtl.h"
#import "EPLoginViewCtl.h"
#import "EPHomeViewCtl.h"
#import "ViewController.h"

@implementation AppJump

//  引导页
+ (void)goLaunch {
    
    EPLaunchViewCtl *Vc = [[EPLaunchViewCtl alloc] init];
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
    window.rootViewController = Vc;
}
//  登录页
+ (void)goLoginVC {
    
    RootNavigationController * nav =  [[RootNavigationController alloc] init];
    [nav addChildViewController:[EPLoginViewCtl new]];
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
    window.rootViewController = nav;
    
}
//  主页面
+ (void)goHomeVC {
    
    RootNavigationController * nav =  [[RootNavigationController alloc] init];
    [nav addChildViewController:[EPHomeViewCtl new]];
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
    window.rootViewController = nav;
    
}
//  退出登录
+ (void)goExitVc {
    
    //1 清除账号信息
    [NSUSERDEFAULTS removeObjectForKey:kUserID];
    [NSUSERDEFAULTS removeObjectForKey:kUserSID];
    
    //2 返回登录页面
    [AppJump goLoginVC];
    
}

/**判断是否登录*/
+ (BOOL)isLogin{
    
    NSString * isLogin = [NSUSERDEFAULTS valueForKey:kUserSID];
    if (isLogin && isLogin.length > 0) { return YES; }else{  return NO;  }
}

/**判断是否第一次打开应用*/
+ (BOOL)isNewFeature {
    
    NSString *curVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]; // 获取当前的版本号
    
    NSString *kVersionKey = @"__versionNumber__";
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kVersionKey]; // 获取上一次的版本号
    
    if (!lastVersion) {
        [[NSUserDefaults standardUserDefaults] setObject:curVersion forKey:kVersionKey];
        return YES;
    }
    
    if ([curVersion isEqualToString:lastVersion]) { // 版本号相等, 不显示新特性
        return NO;
    }
    
    // 是新特性、
    [[NSUserDefaults standardUserDefaults] setObject:curVersion forKey:kVersionKey];
    
    return YES;
}


// 项目测试
+ (void)goProjectTest{
    
    ViewController *Vc = [[ViewController alloc] init];
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
    window.rootViewController = Vc;
}


@end
