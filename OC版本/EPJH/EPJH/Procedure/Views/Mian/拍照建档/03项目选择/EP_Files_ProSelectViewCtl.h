//
//  EP_Files_ProSelectViewCtl.h
//  EPJH
//
//  Created by Hans on 2020/9/17.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPProjectHeadFileHandler.h"

@class EPTakePictureModel;

NS_ASSUME_NONNULL_BEGIN

@interface EP_Files_ProSelectViewCtl : RootViewController

@property (nonatomic, strong) EPProjectModel  * projectModel;
@property (nonatomic, strong) NSMutableArray<EPTakePictureModel *> *takeCameraArr;
@property (nonatomic, copy)   NSString  * timeStampStr; // 整个项目唯一时间戳标记

@end

NS_ASSUME_NONNULL_END
