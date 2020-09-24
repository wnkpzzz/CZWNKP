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

/** 拍照状态枚举 */
typedef NS_ENUM(NSInteger, CaseTakePicStatusType) {
    CaseTakePicStatusTypeDefault  , // 默认状态，隐藏下一步，取消按钮。
    CaseTakePicStatusTypeTakePic  , // 拍摄完成界面，显示隐藏下一步，取消按钮，隐藏其他无关图标。
};

@interface EPCasePhotographyViewCtl : RootViewController

/** 传入数据 */
- (void)reloadDataWithModel:(EPProjectModel *)proModel pictureArr:(NSArray<EPTakePictureModel *> *)takeCasePicArr indexSign:(NSInteger)nowIndex timeStamp:(NSString *)timeStampStr;

/** Block数据回调 */
@property (nonatomic,copy)void(^saveClickBlock)(EPProjectModel *proModel, NSArray<EPTakePictureModel *> *takeCasePicArr);
 
@end

NS_ASSUME_NONNULL_END
