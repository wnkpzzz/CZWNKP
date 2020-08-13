//
//  EPPopCameraViewCtl.h
//  EPJH
//
//  Created by Hans on 2020/8/12.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPProjectHeadFileHandler.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

NS_ASSUME_NONNULL_BEGIN

@interface EPPopCameraViewCtl : RootViewController
  
/** 数据入口 */
- (void)reloadDataWithModel:(EPProjectModel *)model photoArr:(NSArray *)photoArr nowIndex:(NSInteger)nowIndex;

/** Block数据回调 */
@property (nonatomic,copy)void(^saveClickBlock)(EPProjectModel *proModel, NSArray *photoArr);

 
 
// **************** 《相机属性》 **********************

@property (nonatomic,strong) AVCaptureDevice *device;    /** 获取相机设备的一些属性 */
@property (nonatomic,strong) AVCaptureSession * session;  /** 执行输入设备和输出设备之间的数据交换 */
@property (nonatomic,strong) AVCaptureDeviceInput *deviceInput;  /** 输入设备，调用所有的输入硬件，例如摄像头、麦克风 */
@property (nonatomic,strong) AVCapturePhotoOutput *imageOutput; /** 照片流输出，用于输出图像 */
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *previewLayer; /** 镜头扑捉到的预览图层 */
@property (nonatomic,assign) UIDeviceOrientation deviceOrientation; /** 屏幕的旋转方向 */
@property (nonatomic,assign) CGFloat beginGestureScale; /** 开始的缩放比例 */
@property (nonatomic,assign) CGFloat effectiveScale; /** 最后的缩放比例 */

// **************** 《上下半区》 **********************

@property (nonatomic, strong) UIImageView *outImageView;        /** 上半区成像后的图片 */
@property (nonatomic, strong) UIImageView *tempImageView;       /** 上半区参照虚线图 */
@property (nonatomic, strong) UIImageView *standardImageView;   /** 下半区标准对比图 */

// **************** 《悬浮按钮》 **********************

@property (nonatomic,weak) UIButton *backButton; /** 返回按钮 */
@property (nonatomic,weak) UIButton *saveButton; /** 完成并保存按钮 */
@property (nonatomic,weak) UIButton *changeButton; /** 切换摄像头 */
@property (nonatomic,weak) UIButton *takePhotoButton;/** 拍照按钮 */
@property (nonatomic,weak) UIButton *albumButton;/** 相册按钮 */
@property (nonatomic,weak) UIButton *flashlightButton;/** 手电筒按钮 */
@property (nonatomic,weak) UIButton *takePhotosNextButton;/** 拍摄下一张按钮 */
@property (nonatomic,weak) UIButton *confirmNextButton;/** 确认并进入下一张拍摄按钮 */
@property (nonatomic,weak) UIButton *cancelButton;/** 取消当前拍摄 */

@end

NS_ASSUME_NONNULL_END
