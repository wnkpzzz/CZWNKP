//
//  EPCasePhotographyViewCtl.m
//  EPJH
//
//  Created by Hans on 2020/8/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPCasePhotographyViewCtl.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import "UIImageView+WebCache.h"


@interface EPCasePhotographyViewCtl ()<AVCapturePhotoCaptureDelegate>
  
// **************** 《相机属性》 **********************
@property (nonatomic,strong) AVCaptureDevice *device;                   /** 获取相机设备的一些属性 */
@property (nonatomic,strong) AVCaptureSession * session;                /** 执行输入设备和输出设备之间的数据交换 */
@property (nonatomic,strong) AVCaptureDeviceInput *deviceInput;         /** 输入设备，调用所有的输入硬件，例如摄像头、麦克风 */
//@property (nonatomic,strong) AVCapturePhotoOutput *imageOutput;         /** 照片流输出，用于输出图像 */
@property (nonatomic,strong) AVCaptureStillImageOutput *imageOutput;         /** 照片流输出，用于输出图像 */
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *previewLayer;  /** 镜头扑捉到的预览图层 */
@property (nonatomic,assign) UIDeviceOrientation deviceOrientation;     /** 屏幕的旋转方向 */

// **************** 《悬浮按钮》 **********************

@property (weak, nonatomic) IBOutlet UIButton *backBtn;         /** 返回按钮 0 */
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;         /** 完成并保存按钮 1 */

@property (weak, nonatomic) IBOutlet UIButton *albumBtn;        /** 相册按钮 2 */
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;       /** 取消当前拍摄 3 */
@property (weak, nonatomic) IBOutlet UIButton *takeBtn;         /** 拍照 4 */
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;         /** 确认并拍摄下一张 5 */

@property (weak, nonatomic) IBOutlet UIButton *skipBtn;         /** 跳过本次拍摄 6 */
@property (weak, nonatomic) IBOutlet UIButton *flashlightBtn;   /** 手电筒按钮 7 */
@property (weak, nonatomic) IBOutlet UIButton *switchBtn;       /** 切换摄像头 8 */
 
// **************** 《上下半区》 **********************
@property (weak, nonatomic) IBOutlet UIView *headOutputView;                 /** 上半区底部视图View */
@property (weak, nonatomic) IBOutlet CZAlbumScrollView *outImageView;
//@property (nonatomic, strong) CZAlbumScrollView *outImageView;               /** 上半成像后的展示图 */
@property (weak, nonatomic) IBOutlet UIImageView *headCKImgView;             /** 上半区参照虚线图 */
@property (weak, nonatomic) IBOutlet UIImageView *footStandardImgView;       /** 下半区标准对比图 */
@property (weak, nonatomic) IBOutlet UIImageView *footCKImgView;             /** 下半区参照虚线图 */
 
// **************** 《数据逻辑》 **********************
 
@property (nonatomic, assign) NSInteger partsIndex;                                     /** 节点索引 */
@property (nonatomic, assign) NSInteger nowIndex;                                       /** 当前拍摄的索引 */
@property (nonatomic, strong) EPProjectModel *proModel;                                 /** 数据源 */
@property (nonatomic, strong) NSMutableArray<EPTakePictureModel *> *takeCasePicArr;     /** 拍摄的图片数组（没拍用默认图显示) */
@property (nonatomic, assign) CaseTakePicStatus takePicStatus;                  /** 拍照状态枚举 */
@property (nonatomic, copy)  NSString  * timeStampStr;                                  /** 整个项目唯一时间戳标记 */

@end

@implementation EPCasePhotographyViewCtl

#pragma mark - 生命周期
 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self loadBaseConfig];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.navigationController.navigationBar.hidden = YES;
 
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
 
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
}

#pragma mark - 基础配置

/** 外部控制器传入数据 */
- (void)reloadDataWithModel:(EPProjectModel *)proModel pictureArr:(NSArray<EPTakePictureModel *> *)takeCasePicArr indexSign:(NSInteger)indexSign timeStamp:(NSString *)timeStampStr{
 
    // 初始化
    self.nowIndex = 0;
    self.proModel = [[EPProjectModel alloc] init];
    self.takeCasePicArr = [NSMutableArray arrayWithCapacity:12];
    
    // 赋值
    self.nowIndex = indexSign;
    self.proModel = proModel;
    [self.takeCasePicArr addObjectsFromArray:takeCasePicArr];
    self.timeStampStr = timeStampStr;

    for (int i = 0; i < kPartsIDArr.count; i++) {
         if ([proModel.cateId isEqualToString:kPartsIDArr[i]]) { self.partsIndex = i;  break; }
     }
    
    // 添加相关补充(添加占位图model)
    if (self.nowIndex == proModel.cameraArr.count) {

        // 拍摄图片的信息数组---存入数据库之用
        EPImageModel *imgInfoModel = [EPImageModel new];
        imgInfoModel.subCateId = self.proModel.subCateId;
        imgInfoModel.subCateName = self.proModel.subCateName;
        imgInfoModel.cateId = self.proModel.cateId;
        imgInfoModel.cateName = self.proModel.cateName;
        imgInfoModel.sort = (int)self.nowIndex;
        imgInfoModel.sortId = kPartsImgsPoIDArr[self.partsIndex][self.nowIndex];
        imgInfoModel.sortName = kPartsImgsPoNameArr[self.partsIndex][self.nowIndex];
        imgInfoModel.isPaiZhaoFlag = @"NO";
        imgInfoModel.cameraImgStr = @"";
        imgInfoModel.tempImgStr = kDefaultTempImageArray[self.partsIndex][self.nowIndex];
        imgInfoModel.composeImgStr = @"";
        [self.proModel.cameraArr appendObject:imgInfoModel];

        // 拍摄的图片数组---存入沙盒之用
        EPTakePictureModel *takePicModel = [EPTakePictureModel new];
        takePicModel.index = self.nowIndex;
        takePicModel.partsIndex = self.partsIndex;
        takePicModel.title = kPartsImgsPoNameArr[self.partsIndex][self.nowIndex];
        takePicModel.cameraImgStr = imgInfoModel.cameraImgStr;
        [self.takeCasePicArr addObject:takePicModel];
    }
}

/** 基础设置 */
- (void)loadBaseConfig{
     
    // 配置UI
    self.backBtn.layer.cornerRadius = 16;
    self.backBtn.layer.masksToBounds = YES;
    [self.backBtn setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.4]];
    self.saveBtn.layer.cornerRadius = 16;
    self.saveBtn.layer.masksToBounds = YES;
    [self.saveBtn setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.4]];

    [self.outImageView setupUI];
    [self createAVCaptureDevice];  // 初始化系统相机
    [self refreshBottomViewDataAction]; // 刷新底部视图显示数据
    self.takePicStatus = CaseTakePicStatusDefault; // 刷新底部视图UI显示
}

/** 初始化系统相机 */
- (void)createAVCaptureDevice{
    
    NSError *error;

    self.session = [[AVCaptureSession alloc] init];
    if ([self.session canSetSessionPreset:AVCaptureSessionPresetPhoto]) { self.session.sessionPreset = AVCaptureSessionPresetPhoto; }

    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

    self.deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    if ([self.session canAddInput:self.deviceInput]) {[self.session addInput:self.deviceInput]; }
 
    self.imageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary * outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
    [self.imageOutput setOutputSettings:outputSettings];
    if ([self.session canAddOutput:self.imageOutput]) {[self.session addOutput:self.imageOutput]; }

    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame = CGRectMake(0, 0,APP_WIDTH, APP_HEIGHT * 0.5 );
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];

    if (self.session) {  [self.session startRunning]; }
}

/** 底部视图-数据相关-刷新 */
- (void)refreshBottomViewDataAction{
     
    // 加载底部对比照图片
    UIImage *standardImage;
    UIImage *tempImage;
    EPTakePictureModel *model = [self.takeCasePicArr objectAtIndex:self.nowIndex];
    if ([AppUtils isIPhoneX]) {
        if (model.defaultImage) {
            standardImage = model.defaultImage;
        }else{
            standardImage = [UIImage imageNamed:kCameraTempImageArrayX[self.partsIndex][self.nowIndex]];
        }
        tempImage = [UIImage imageNamed:kCameraFrameTempImageArrayX[self.partsIndex][self.nowIndex]];
    }else{
        if (model.defaultImage) {
            standardImage = model.defaultImage;
        }else{
            standardImage = [UIImage imageNamed:kCameraTempImageArray[self.partsIndex][self.nowIndex]];
        }
        tempImage = [UIImage imageNamed:kCameraFrameTempImageArray[self.partsIndex][self.nowIndex]];
    }
    self.footCKImgView.image = tempImage;
    self.footStandardImgView.image = standardImage;
    
    if (self.nowIndex == self.proModel.cameraArr.count - 1) { [self.skipBtn setHidden:YES]; }

}

/** 底部视图-UI显示相关-刷新 */
- (void)setTakePicStatus:(CaseTakePicStatus)takePicStatus{
    
    switch (takePicStatus) {
       
        case CaseTakePicStatusDefault:
            
            [self.headCKImgView setHidden:YES];
            [self.headOutputView setHidden:YES];
 
            [self.cancelBtn setHidden:YES];
            [self.nextBtn setHidden:YES];

            [self.albumBtn setHidden:NO];
            [self.takeBtn setHidden:NO];
            [self.skipBtn setHidden:NO];
            [self.flashlightBtn setHidden:NO];
            [self.switchBtn setHidden:NO];
         
            if (self.nowIndex == self.proModel.cameraArr.count - 1) { [self.skipBtn setHidden:YES]; }

            break;
            
        case CaseTakePicStatusTakePic:

            [self.headCKImgView setHidden:NO];
            [self.headOutputView setHidden:NO];

            [self.cancelBtn setHidden:NO];
            [self.nextBtn setHidden:NO];
            
            [self.albumBtn setHidden:YES];
            [self.takeBtn setHidden:YES];
            [self.skipBtn setHidden:YES];
            [self.flashlightBtn setHidden:YES];
            [self.switchBtn setHidden:YES];
  
            // 如果是最后一张
            if (self.nowIndex == 11) { self.nextBtn.selected = YES; }else{ self.nextBtn.selected = NO; }
               
            break;
        default:
            break;
    }
}

#pragma mark - 点击事件处理
- (IBAction)btnClickAction:(UIButton *)button {

    if (button.tag == 0) {  /** 返回上一个界面 */
        
        [self dismissViewControllerAnimated:YES completion:nil];

        
    }else if (button.tag == 1) {    /** 完成并保存退出*/
        
        // 如果是拍完照处于预览界面
        if (self.takeBtn.isHidden) { [self saveTakePicture]; }
         
        // 去除新增空位
        if (self.takeCasePicArr.count > [kPartsCountArr[self.partsIndex] intValue] && !self.takeBtn.isHidden) {
           [self.takeCasePicArr removeLastObject];
           [self.proModel.cameraArr removeLastObject];
        }
        
        // Block回传数据，返回上一页。
        if (self.saveClickBlock) {  self.saveClickBlock(self.proModel, self.takeCasePicArr); }
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
    }else if (button.tag == 3) {    /** 取消当前拍照 */
        
        self.takePicStatus = CaseTakePicStatusDefault;
        
    }else if (button.tag == 4) {    /** 点击拍照 */
 
        [self confirmWithCamera];
  
        
    }else if (button.tag == 5) {    /** 确认并拍摄下一张 */
          
        [self saveTakePicture];
        
        // 新增空位
        if (!self.nextBtn.selected) {
            
            self.nowIndex = self.nowIndex + 1;// 更新索引
            
            // 添加相关补充(添加占位图model)
            if (self.nowIndex == self.proModel.cameraArr.count) {
                
                // 拍摄图片的信息数组---存入数据库之用
                EPImageModel *imgInfoModel = [EPImageModel new];
                imgInfoModel.subCateId = self.proModel.subCateId;
                imgInfoModel.subCateName = self.proModel.subCateName;
                imgInfoModel.cateId = self.proModel.cateId;
                imgInfoModel.cateName = self.proModel.cateName;
                imgInfoModel.sort = (int)self.nowIndex;
                imgInfoModel.sortId = kPartsImgsPoIDArr[self.partsIndex][self.nowIndex];
                imgInfoModel.sortName = kPartsImgsPoNameArr[self.partsIndex][self.nowIndex];
                imgInfoModel.isPaiZhaoFlag = @"NO";
                imgInfoModel.cameraImgStr = @"";
                imgInfoModel.tempImgStr = kDefaultTempImageArray[self.partsIndex][self.nowIndex];
                imgInfoModel.composeImgStr = @"";
                [self.proModel.cameraArr appendObject:imgInfoModel];
                
                // 拍摄的图片数组---存入沙盒之用
                EPTakePictureModel *takePicModel = [EPTakePictureModel new];
                takePicModel.index = self.nowIndex;
                takePicModel.partsIndex = self.partsIndex;
                takePicModel.title = kPartsImgsPoNameArr[self.partsIndex][self.nowIndex];
                takePicModel.cameraImgStr = imgInfoModel.cameraImgStr;
                [self.takeCasePicArr addObject:takePicModel];
            }
            
            [self refreshBottomViewDataAction]; // 刷新底部视图显示数据
            self.takePicStatus = CaseTakePicStatusDefault; // 刷新底部视图显示模式
            
        }else{
            // 拍摄到最后一张,则执行完成并保存退出操作
            [self btnClickAction:self.saveBtn];
        }
        
    }else if (button.tag == 6) {    /** 跳过本次拍摄 */
        
        if (self.nowIndex == self.proModel.cameraArr.count) { return; } // 达到拍照上限
        self.nowIndex = self.nowIndex + 1;// 更新索引
        [self refreshBottomViewDataAction]; // 刷新底部视图显示数据
        self.takePicStatus = CaseTakePicStatusDefault; // 刷新底部视图显示模式
            
    }else if (button.tag == 7) {    /** 手电筒 */
        
        button.selected = !button.selected;
        [AppPhotoUtils controlClashlightWith:button.selected];
       
    }else if (button.tag == 8) {     /** 切换摄像头 */
       
        [self switchCamerasBackFont];
    }

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
  
/** 确认拍照--直接拍照选取 */
- (void)confirmWithCamera{
    
        //拍照
        AVCaptureConnection *connection = [self.imageOutput connectionWithMediaType:AVMediaTypeVideo];
        connection.videoOrientation = AVCaptureVideoOrientationPortrait;
        //成像镜面
        NSArray *inputs = self.session.inputs;
        for (AVCaptureDeviceInput *input in inputs ) {
            AVCaptureDevice *device = input.device;
            if ( [device hasMediaType:AVMediaTypeVideo] ) {
                AVCaptureDevicePosition position = device.position;
                if (position ==AVCaptureDevicePositionFront){
                    connection.videoMirrored = YES;
                }else{
                    connection.videoMirrored = NO;
                }
                break;
            }
        }
        // 输出图片
        WS(weakSelf);
        id takePictureSuccess = ^(CMSampleBufferRef sampleBuffer,NSError *error){
            
            if (sampleBuffer == NULL) { return ; }
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:sampleBuffer];
            UIImage *image = [[UIImage alloc] initWithData:imageData];
            // 切换预览模式
            weakSelf.takePicStatus = CaseTakePicStatusTakePic;
           
            // 图片纠正
            image = [image normalizedImage];
            // 显示成像的图片
            // 比例剪裁举例：375：406 = 3024：3274
            CGFloat imgResultW = self.headOutputView.width;
            CGFloat imgResultH = self.headOutputView.height;
            CGFloat imgMyW =  image.size.width;
            CGFloat imgMyH =  imgMyW * imgResultH / imgResultW ;
            CGSize imgeSize = CGSizeMake(imgMyW, imgMyH);
            //对图片尺寸进行剪裁
            UIImage *imageNew = [AppPhotoUtils thumbnailWithImage:image size:imgeSize];

            //对图片大小进行压缩
            NSData *dataImg = UIImageJPEGRepresentation(imageNew, 0.2);
            UIImage *imageNewNew = [UIImage imageWithData:dataImg];

            // 最终得到图片
            weakSelf.outImageView.contentImageView.image = imageNewNew;
            [self.outImageView setHidden:NO];
 
        };
    
        [self.imageOutput captureStillImageAsynchronouslyFromConnection:connection completionHandler:takePictureSuccess];
}
 
#pragma mark - 业务逻辑处理

/** 保存拍摄的图片 */
- (void)saveTakePicture{
    
    // Save拍摄图片的信息数组---存入数据库之用
    EPImageModel *imgInfoModel = [EPImageModel new];
    imgInfoModel.subCateId = self.proModel.subCateId;
    imgInfoModel.subCateName = self.proModel.subCateName;
    imgInfoModel.cateId = self.proModel.cateId;
    imgInfoModel.cateName = self.proModel.cateName;
    imgInfoModel.sort = (int)self.nowIndex;
    imgInfoModel.sortId = kPartsImgsPoIDArr[self.partsIndex][self.nowIndex];
    imgInfoModel.sortName = kPartsImgsPoNameArr[self.partsIndex][self.nowIndex];
    imgInfoModel.isPaiZhaoFlag = @"YES";
    imgInfoModel.cameraImgStr = tableNameImage(KUID, @"iOSPZ", self.timeStampStr, [NSString stringWithFormat:@"%ld",(long)self.nowIndex]);
    imgInfoModel.tempImgStr = self.proModel.cameraArr[self.nowIndex].tempImgStr;// 不改变对比图
    [self.proModel.cameraArr replaceObjectAtIndex:self.nowIndex withObject:imgInfoModel];
    
    // Save拍摄的UIImage模型数组---存入沙盒之用
    EPTakePictureModel *takePicModel = [EPTakePictureModel new];
    takePicModel.index = self.nowIndex;
    takePicModel.cameraImage = self.outImageView.contentImageView.image;
    takePicModel.defaultImage = self.takeCasePicArr[self.nowIndex].defaultImage;
    takePicModel.title = kPartsImgsPoNameArr[self.partsIndex][self.nowIndex];
    takePicModel.cameraImgStr = imgInfoModel.cameraImgStr;
    [self.takeCasePicArr replaceObjectAtIndex:self.nowIndex withObject:takePicModel];
     
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
