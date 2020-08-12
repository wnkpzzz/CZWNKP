//
//  EPWKWebViewCtl.h
//  EPJH
//
//  Created by Hans on 2020/7/27.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, WKWebViewType) {
    WebViewTypeAbout ,        //关于我们
    WebViewTypeHelp ,         //帮助中心
    WebViewTypeYinSi ,        //隐私政策
    WebViewTypeXieYi ,        //用户协议
    WebViewTypeMZSM ,         //免责声明
    WebViewTypeSYAD ,         //首页广告

};


@interface EPWKWebViewCtl : RootViewController

/** URL */
@property (nonatomic,copy)NSString * url;

/** 控制器类型 */
@property(nonatomic,assign) WKWebViewType type;

@end

NS_ASSUME_NONNULL_END
