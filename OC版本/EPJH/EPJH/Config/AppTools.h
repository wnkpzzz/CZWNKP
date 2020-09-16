//
//  AppTools.h
//  EPJH
//
//  Created by Hans on 2020/7/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#ifndef AppTools_h
#define AppTools_h

// Block弱引用
#define WS(weakSelf)                 __weak __typeof(&*self)weakSelf = self;

// 系统高度
#define APP_WIDTH                    [[UIScreen mainScreen] bounds].size.width
#define APP_HEIGHT                   [[UIScreen mainScreen] bounds].size.height
#define Tab_Height                   49
#define Nav_Height                   64 //  (APP_HEIGHT >= 812 ? 88 : 64) // 812是iPhoneX的高度
#define kWidth(x)                    (x*APP_WIDTH/375.0f) /*屏幕宽高适配,以iPhone6 和 iPad2为标准*/
#define FullViewRect                 CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT);


// 占位图
#define placeHolderImg               [UIImage imageNamed:@"icon_home_placeHolder"]
#define kImage(imageName)            [UIImage imageNamed:imageName]

//  RGB和背景色
#define RGB(r, g, b)                 [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define RGBA(r,g,b,a)                [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define kMainBlueColor               RGB(0, 176, 255) // 主题蓝色
#define kMainTextColor               RGB(44, 46, 48)  // 文字颜色


/*日志打印 */
#if DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s",__func__)、
#else
#define NSLog(...)
#define debugMethod()
#endif

#endif /* AppTools_h */
