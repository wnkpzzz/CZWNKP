//
//  PopRegisterAgreementView.h
//  EPJH
//
//  Created by Hans on 2020/7/16.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PopRegisterAgreementView;

/** 数据返回Block */
typedef void(^RegisterAgreementBackBlock)(BOOL isAgree);

@interface PopRegisterAgreementView : RootView

/** 类方法初始化 */
+ (void)showPopViewWithComplete:(RegisterAgreementBackBlock)complete;

@end

NS_ASSUME_NONNULL_END
