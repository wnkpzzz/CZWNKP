//
//  EPPopCameraViewCtl.h
//  EPJH
//
//  Created by Hans on 2020/8/12.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPProjectHeadFileHandler.h"


NS_ASSUME_NONNULL_BEGIN

@interface EPPopCameraViewCtl : RootViewController
  
/** 数据入口 */
- (void)reloadDataWithModel:(EPProjectModel *)model photoArr:(NSArray *)photoArr nowIndex:(NSInteger)nowIndex;

/** Block数据回调 */
@property (nonatomic,copy)void(^saveClickBlock)(EPProjectModel *proModel, NSArray *photoArr);

 

@end

NS_ASSUME_NONNULL_END
