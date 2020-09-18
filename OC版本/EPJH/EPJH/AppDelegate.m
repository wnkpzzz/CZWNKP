//
//  AppDelegate.m
//  EPJH
//
//  Created by Hans on 2020/7/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Common.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self setupCommonWithApplication:application didFinishLaunchingWithOptions:launchOptions];
    [self loadRootViewController];
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application  { }
- (void)applicationDidEnterBackground:(UIApplication *)application { }
- (void)applicationWillEnterForeground:(UIApplication *)application {}
- (void)applicationDidBecomeActive:(UIApplication *)application  { }
- (void)applicationWillTerminate:(UIApplication *)application { }

- (void)loadRootViewController {
//    [AppJump goProjectTest]; return;
    if ( [AppJump isNewFeature]) { [AppJump goLaunch]; }
    else{ if ([AppJump isLogin]) { [AppJump goHomeVC]; } else { [AppJump goLoginVC]; } }
}

@end
 
