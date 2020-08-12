//
//  EPAngleSelectViewCtl.h
//  EPJH
//
//  Created by Hans on 2020/8/3.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPProjectHeadFileHandler.h"
 
@class EPProjectModel;
@class EPUserInfoModel;

NS_ASSUME_NONNULL_BEGIN

@interface EPAngleSelectViewCtl : RootViewController
 
@property (nonatomic, strong) EPProjectModel * proModel;
@property (nonatomic, strong) EPUserInfoModel * userModel;

@end

NS_ASSUME_NONNULL_END
