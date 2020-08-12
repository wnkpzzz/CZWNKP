//
//  SuccessToOriginController.h
//  EPJH
//
//  Created by Hans on 2020/7/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SuccessToOriginController;
 
/** 显示类型枚举 */
typedef NS_ENUM(NSInteger, SuccessToOriginType) {
    SuccessToOriginRegister  ,
    SuccessToOriginPwd  ,
    SuccessToOriginChangePwd  ,
    SuccessToOriginCreateFiles  ,

};

/** 数据返回Block */
typedef void(^SuccessToOriginBackBlock)(SuccessToOriginController * customVc,BOOL isSaveFlag);

@interface SuccessToOriginController : UIViewController
 
/** 初始化构造方法 */
- (id)initWithType:(SuccessToOriginType)type complete:(SuccessToOriginBackBlock)complete;

/** Block数据返回 */
@property (copy, nonatomic) SuccessToOriginBackBlock completeHandler;

@end

NS_ASSUME_NONNULL_END
