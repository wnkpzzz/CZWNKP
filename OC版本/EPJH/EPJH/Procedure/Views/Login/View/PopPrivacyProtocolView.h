//
//  PopPrivacyProtocolView.h
//  EPJH
//
//  Created by Hans on 2020/3/2.
//  Copyright © 2020 Hans3D. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PopPrivacyProtocolView;

typedef NS_ENUM(NSInteger, PrivacyProtocolType) {
    PopPrivacyProtocolAgreement  ,  // 用户协议
    PopPrivacyProtocolPolicy  ,  //  隐私政策 
};

/** 数据返回Block */
typedef void(^PrivacyProtocolBackBlock)(PrivacyProtocolType btnStatus);

@interface PopPrivacyProtocolView : RootView

/** 类方法初始化 */
+ (void)showPopViewWithComplete:(PrivacyProtocolBackBlock)complete;
 
@end

NS_ASSUME_NONNULL_END
