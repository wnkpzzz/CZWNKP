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


 
/** 展开回调 */
@property (nonatomic, copy)void(^showBlock)(void);
/** 选择回调 */
@property (nonatomic, copy)void(^selectBlock)(NSInteger selectIndex);


- (void)reloadDataWithArray:(NSArray *)dataArray;

@end

NS_ASSUME_NONNULL_END
