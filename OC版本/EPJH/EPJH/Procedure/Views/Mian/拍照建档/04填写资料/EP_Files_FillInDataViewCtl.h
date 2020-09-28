//
//  EP_Files_FillInDataViewCtl.h
//  EPJH
//
//  Created by Hans on 2020/9/17.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPProjectHeadFileHandler.h"

@class EPTakePictureModel;

NS_ASSUME_NONNULL_BEGIN

@interface EP_Files_FillInDataViewCtl : UIViewController

@property (nonatomic, strong) EPProjectModel  * projectModel;   // 档案项目Model信息
@property (nonatomic, strong) NSMutableArray<EPTakePictureModel *> *takeCameraArr;  // 拍摄的照片信息数组
@property (nonatomic, copy)   NSString  * timeStampStr;   // 档案创建过程中唯一标定时间戳

@end

NS_ASSUME_NONNULL_END

 
