//
//  EPAngleSelectCell.h
//  EPJH
//
//  Created by Hans on 2020/7/27.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPProjectHeadFileHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface EPAngleSelectCell : RootTableViewCell
 
/** 展开/收缩Block */
@property (nonatomic, copy)void(^showBlock)(void);

/** 点击回调Block */
@property (nonatomic, copy)void(^selectBlock)(NSInteger selectIndex);

/** 数据刷新 */
- (void)reloadDataWithArray:(NSArray *)dataArray;

@end

NS_ASSUME_NONNULL_END
