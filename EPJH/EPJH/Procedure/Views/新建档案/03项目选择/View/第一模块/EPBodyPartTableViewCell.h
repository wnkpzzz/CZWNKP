//
//  EPBodyPartTableViewCell.h
//  EPJH
//
//  Created by Hans on 2020/8/25.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EPBodyPartTableViewCell : RootTableViewCell

/** 数据源 */
@property (nonatomic,strong) NSArray * listData;

/** 点击回调事件1、选中index 2、是否选中标记 3、是否取消选择？*/
@property (nonatomic ,copy) void(^backSelectItemBlock)(NSInteger index,BOOL isSelected,BOOL isShowSubList);

@end

NS_ASSUME_NONNULL_END
