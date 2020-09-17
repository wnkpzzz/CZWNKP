//
//  EP_Files_AngleSelectViewCtl.h
//  EPJH
//
//  Created by Hans on 2020/9/17.
//  Copyright © 2020 hans3d. All rights reserved.
//
 
#import <UIKit/UIKit.h>
#import "EPProjectHeadFileHandler.h"
 
@class EPProjectModel;
@class EPUserInfoModel;

NS_ASSUME_NONNULL_BEGIN

@interface EP_Files_AngleSelectViewCtl : RootViewController
 
@property (nonatomic, strong) EPProjectModel * proModel;
@property (nonatomic, strong) EPUserInfoModel * userModel;


@end

NS_ASSUME_NONNULL_END
