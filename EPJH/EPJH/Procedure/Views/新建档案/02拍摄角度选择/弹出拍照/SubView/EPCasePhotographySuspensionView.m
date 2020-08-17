//
//  EPCasePhotographySuspensionView.m
//  EPJH
//
//  Created by Hans on 2020/8/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPCasePhotographySuspensionView.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface EPCasePhotographySuspensionView ()
  
// **************** 《相机属性》 **********************
@property (nonatomic,strong) AVCaptureDevice *device;                   /** 获取相机设备的一些属性 */
@property (nonatomic,strong) AVCaptureSession * session;                /** 执行输入设备和输出设备之间的数据交换 */
@property (nonatomic,strong) AVCaptureDeviceInput *deviceInput;         /** 输入设备，调用所有的输入硬件，例如摄像头、麦克风 */
@property (nonatomic,strong) AVCapturePhotoOutput *imageOutput;         /** 照片流输出，用于输出图像 */
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *previewLayer;  /** 镜头扑捉到的预览图层 */
@property (nonatomic,assign) UIDeviceOrientation deviceOrientation;     /** 屏幕的旋转方向 */

// **************** 《悬浮按钮》 **********************

@property (weak, nonatomic) IBOutlet UIButton *backBtn;         /** 返回按钮 0 */
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;         /** 完成并保存按钮 1 */

@property (weak, nonatomic) IBOutlet UIButton *albumBtn;        /** 相册按钮 2 */
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;       /** 取消当前拍摄 3 */
@property (weak, nonatomic) IBOutlet UIButton *takeBtn;         /** 拍照按钮 4 */
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;         /** 确认并进入下一张拍摄按钮 5 */

@property (weak, nonatomic) IBOutlet UIButton *skipBtn;         /** 跳过当前拍摄下一张按钮 6 */
@property (weak, nonatomic) IBOutlet UIButton *flashlightBtn;   /** 手电筒按钮 7 */
@property (weak, nonatomic) IBOutlet UIButton *switchBtn;       /** 切换摄像头 8 */
 
// **************** 《上下半区》 **********************
@property (weak, nonatomic) IBOutlet CZAlbumScrollView *headOutputImgView;   /** 上半区成像后的图片 */
@property (weak, nonatomic) IBOutlet UIImageView *headCKImgView;             /** 上半区参照虚线图 */
@property (weak, nonatomic) IBOutlet UIImageView *footStandardImgView;       /** 下半区标准对比图 */
@property (weak, nonatomic) IBOutlet UIImageView *footCKImgView;             /** 下半区参照虚线图 */
@property (nonatomic, copy) NSString *standrandImageUrl;                     /** 下半区标准照图片地址 */

// **************** 《数据逻辑》 **********************
 
@property(nonatomic,assign) CaseTakePicStatusType takePicStatusType;            /** 拍照状态枚举 */

@property (nonatomic, assign) NSInteger partsIndex;                             /** 节点索引 */
@property (nonatomic, assign) NSInteger nowIndex;                               /** 当前拍摄的索引 */
@property (nonatomic, strong) NSMutableArray<EPTakePictureModel *> *takeCasePicArr;   /** 拍照结果数组（需要展示的图，没拍的位置用默认图显示) */
@property (nonatomic, copy)   EPProjectModel *proModel;                         /** 数据源 */

@end

@implementation EPCasePhotographySuspensionView
 
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     
    [self loadBaseConfig];
}

#pragma mark - 基础配置
- (void)loadBaseConfig{

    self.takeCasePicArr = [NSMutableArray arrayWithCapacity:12];

    self.backBtn.layer.cornerRadius = 16;
    self.backBtn.layer.masksToBounds = YES;
    [self.backBtn setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.4]];
    self.saveBtn.layer.cornerRadius = 16;
    self.saveBtn.layer.masksToBounds = YES;
    [self.saveBtn setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.4]];

    [self createAVCaptureDevice];
   
}

#pragma mark - 事件处理
- (IBAction)btnClickAction:(UIButton *)button {

    if (button.tag == 0) {
        /** 返回上一个界面 */
        
    }else if (button.tag == 3) {
        /** 取消当前拍照 */
        self.takePicStatusType = CaseTakePicStatusTypeDefault;
        
    }else if (button.tag == 4) {
        /** 点击拍照 */
        self.takePicStatusType = CaseTakePicStatusTypeTakePic;
        
    }else if (button.tag == 5) {
        /** 点击拍摄下一张按钮 */
        self.takePicStatusType = CaseTakePicStatusTypeDefault;
        
    }else if (button.tag == 7) {
        /** 手电筒 */
        button.selected = !button.selected;
        [AppPhotoUtils controlClashlightWith:button.selected];
       
    }else if (button.tag == 8) {
        /** 切换摄像头 */
        [self switchCamerasBackFont];
    }

}
 
- (void)setTakePicStatusType:(CaseTakePicStatusType)takePicStatusType{
    
    switch (takePicStatusType) {
       
        case CaseTakePicStatusTypeDefault:
            
            [self.headCKImgView setHidden:YES];
            [self.headOutputImgView setHidden:YES];
 
            [self.cancelBtn setHidden:YES];
            [self.nextBtn setHidden:YES];

            [self.albumBtn setHidden:NO];
            [self.takeBtn setHidden:NO];
            [self.skipBtn setHidden:NO];
            [self.flashlightBtn setHidden:NO];
            [self.switchBtn setHidden:NO];
            
            break;
        case CaseTakePicStatusTypeTakePic:

            [self.headCKImgView setHidden:NO];
            [self.headOutputImgView setHidden:NO];

            [self.cancelBtn setHidden:NO];
            [self.nextBtn setHidden:NO];
            
            [self.albumBtn setHidden:YES];
            [self.takeBtn setHidden:YES];
            [self.skipBtn setHidden:YES];
            [self.flashlightBtn setHidden:YES];
            [self.switchBtn setHidden:YES];
 
            break;
        default:
            break;
    }
}

#pragma mark - AVCaptureDevice

/** 初始化系统相机 */
- (void)createAVCaptureDevice{
    
    NSError *error;

    self.session = [[AVCaptureSession alloc] init];
    if ([self.session canSetSessionPreset:AVCaptureSessionPresetPhoto]) { self.session.sessionPreset = AVCaptureSessionPresetPhoto; }

    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

    self.deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    if ([self.session canAddInput:self.deviceInput]) {[self.session addInput:self.deviceInput]; }

    self.imageOutput = [[AVCapturePhotoOutput alloc] init];
    self.imageOutput = [[AVCapturePhotoOutput alloc] init];
    [self.imageOutput setPhotoSettingsForSceneMonitoring:[AVCapturePhotoSettings photoSettingsWithFormat:@{AVVideoCodecKey:AVVideoCodecTypeJPEG}]];
    if ([self.session canAddOutput:self.imageOutput]) {[self.session addOutput:self.imageOutput]; }

    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame = CGRectMake(0, 0,APP_WIDTH, APP_HEIGHT / 2);
    [self.layer insertSublayer:self.previewLayer atIndex:0];

    if (self.session) {  [self.session startRunning]; }
}

/** 切换相机前后摄像头 */
- (void)switchCamerasBackFont{
    
    NSArray *inputs = self.session.inputs;
    for (AVCaptureDeviceInput *input in inputs ) {
       AVCaptureDevice *device = input.device;
       if ([device hasMediaType:AVMediaTypeVideo]) {
           AVCaptureDevicePosition position = device.position;
           AVCaptureDevice *newCamera = nil;
           AVCaptureDeviceInput *newInput = nil;
           if (position == AVCaptureDevicePositionFront){
               newCamera = [self getCameraDeviceWithPosition:AVCaptureDevicePositionBack];
           }else{
               newCamera = [self getCameraDeviceWithPosition:AVCaptureDevicePositionFront];
           }
           newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
           // beginConfiguration ensures that pending changes are not applied immediately
           [self.session beginConfiguration];
           [self.session removeInput:input];
           [self.session addInput:newInput];
           // Changes take effect once the outermost commitConfiguration is invoked.
           [self.session commitConfiguration];
           break;
       }
    }
}
 
/** 相机状态 */
- (AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition)position{
    
    // 前置摄像头的时候隐藏闪光灯按钮
    if (position == AVCaptureDevicePositionBack) {  [self.flashlightBtn setHidden:NO];  }
    if (position == AVCaptureDevicePositionFront) {  [self.flashlightBtn setHidden:YES];  }
 
    AVCaptureDeviceDiscoverySession *cameras = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInWideAngleCamera] mediaType:AVMediaTypeVideo position:position];
 
     for (AVCaptureDevice *device in cameras.devices) {
         if ([device position] == position) {
             return device;
         }
     }
 
    return nil;
}

@end
