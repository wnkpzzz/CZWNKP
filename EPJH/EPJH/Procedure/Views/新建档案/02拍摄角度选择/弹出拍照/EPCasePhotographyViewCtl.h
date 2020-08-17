//
//  EPCasePhotographyViewCtl.h
//  EPJH
//
//  Created by Hans on 2020/8/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPProjectHeadFileHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface EPCasePhotographyViewCtl : RootViewController

/** 传入数据 */
- (void)reloadDataWithModel:(EPProjectModel *)proModel pictureArr:(NSArray *)takeCasePicArr nowSign:(NSInteger)nowIndex;

/** Block数据回调 */
@property (nonatomic,copy)void(^saveClickBlock)(EPProjectModel *proModel, NSArray *photoArr);
 
 
@end

NS_ASSUME_NONNULL_END
