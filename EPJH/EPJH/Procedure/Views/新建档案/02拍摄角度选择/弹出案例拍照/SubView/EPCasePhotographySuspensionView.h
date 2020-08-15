//
//  EPCasePhotographySuspensionView.h
//  EPJH
//
//  Created by Hans on 2020/8/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 拍照状态枚举 */
typedef NS_ENUM(NSInteger, CaseTakePicStatusType) {
    CaseTakePicStatusTypeDefault  ,
    CaseTakePicStatusTypeTakePic  ,
};

@interface EPCasePhotographySuspensionView : RootView

/** 拍照状态枚举 */
@property(nonatomic,assign) CaseTakePicStatusType takePicStatusType;

/** Block点击事件回调 */
@property (copy,nonatomic) void (^btnClickBlock)(NSInteger btnClickTag,CaseTakePicStatusType takePicStatusType);


@end

NS_ASSUME_NONNULL_END
