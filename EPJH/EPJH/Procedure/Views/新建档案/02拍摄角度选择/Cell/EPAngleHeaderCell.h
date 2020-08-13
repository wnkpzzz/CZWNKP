//
//  EPAngleHeaderCell.h
//  EPJH
//
//  Created by Hans on 2020/7/27.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EPAngleHeaderCell : RootTableViewCell
 
/** 点击按钮回调Block */
@property (nonatomic, copy)void(^clickBlock)(NSInteger selectIndex);

@end

NS_ASSUME_NONNULL_END
