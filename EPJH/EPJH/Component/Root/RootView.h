//
//  RootView.h
//  EPJH
//
//  Created by Hans on 2020/7/16.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RootView : UIView

/** 初始化XIB */
+ (instancetype)initWithCustomView;

/** 初始化 */
- (instancetype)initWithFrame:(CGRect)frame ;

/** 显示弹框视图 */
- (void)showPopView;

/** 隐藏弹框视图 */
- (void)dismissPopView;

@end

NS_ASSUME_NONNULL_END
