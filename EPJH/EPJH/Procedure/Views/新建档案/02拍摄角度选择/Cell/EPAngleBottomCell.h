//
//  EPAngleBottomCell.h
//  EPJH
//
//  Created by Hans on 2020/7/27.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPProjectHeadFileHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface EPAngleBottomCell : RootTableViewCell
 
/** 是否显示加号添加扩展位 */
@property (nonatomic, assign) BOOL isShowAdd;
 
/** 数据源 */
@property (nonatomic, strong) NSArray *dataArray;

/** 点击回调Block */
@property (nonatomic, copy)void(^angleSelectBlock)(NSInteger selectIndex );


@property (nonatomic, copy)void(^cellHeightBlock)(CGFloat cellHeight);


@end

NS_ASSUME_NONNULL_END
