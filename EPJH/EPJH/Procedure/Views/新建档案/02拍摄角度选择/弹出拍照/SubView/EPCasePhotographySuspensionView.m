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

@interface EPCasePhotographySuspensionView ()<AVCapturePhotoCaptureDelegate>
  
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
@property (weak, nonatomic) IBOutlet UIButton *takeBtn;         /** 拍照 4 */
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;         /** 确认并拍摄下一张 5 */

@property (weak, nonatomic) IBOutlet UIButton *skipBtn;         /** 跳过本次拍摄 6 */
@property (weak, nonatomic) IBOutlet UIButton *flashlightBtn;   /** 手电筒按钮 7 */
@property (weak, nonatomic) IBOutlet UIButton *switchBtn;       /** 切换摄像头 8 */
 
// **************** 《上下半区》 **********************
@property (weak, nonatomic) IBOutlet CZAlbumScrollView *headOutputImgView;   /** 上半区成像后的图片 */
@property (weak, nonatomic) IBOutlet UIImageView *headCKImgView;             /** 上半区参照虚线图 */
@property (weak, nonatomic) IBOutlet UIImageView *footStandardImgView;       /** 下半区标准对比图 */
@property (weak, nonatomic) IBOutlet UIImageView *footCKImgView;             /** 下半区参照虚线图 */
@property (nonatomic, copy) NSString *standrandImageUrl;                     /** 下半区标准照图片地址 */

// **************** 《数据逻辑》 **********************
 
@property (nonatomic, assign) NSInteger partsIndex;                                     /** 节点索引 */
@property (nonatomic, assign) NSInteger nowIndex;                                       /** 当前拍摄的索引 */
@property (nonatomic, strong) EPProjectModel *proModel;                                 /** 数据源 */
@property (nonatomic, strong) NSMutableArray<EPTakePictureModel *> *takeCasePicArr;     /** 拍照结果数组（需要展示的图，没拍的位置用默认图显示) */
@property (nonatomic, assign) CaseTakePicStatusType takePicStatusType;                  /** 拍照状态枚举 */

@end

@implementation EPCasePhotographySuspensionView
 
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     
    [self loadBaseConfig];
}

#pragma mark - 基础配置
- (void)loadBaseConfig{

    self.nowIndex = 0;
    self.proModel = [[EPProjectModel alloc] init];
    self.takeCasePicArr = [NSMutableArray arrayWithCapacity:12];
    self.takePicStatusType = CaseTakePicStatusTypeDefault;
    
    self.backBtn.layer.cornerRadius = 16;
    self.backBtn.layer.masksToBounds = YES;
    [self.backBtn setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.4]];
    self.saveBtn.layer.cornerRadius = 16;
    self.saveBtn.layer.masksToBounds = YES;
    [self.saveBtn setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.4]];

    [self createAVCaptureDevice];
   
}

/** 传入数据 */
- (void)reloadDataWithModel:(EPProjectModel *)proModel pictureArr:(NSArray *)takeCasePicArr nowSign:(NSInteger)nowIndex{
    
    self.nowIndex = nowIndex;
    self.proModel = [proModel mutableCopy];
    [self.takeCasePicArr addObjectsFromArray:takeCasePicArr];

    for (int i = 0; i < kPartsIDArr.count; i++) {
          if ([proModel.cateId isEqualToString:kPartsIDArr[i]]) {
              self.partsIndex = i;
              break;
          }
    }
    
    // 添加相关补充(添加占位图model)
     if (self.nowIndex == proModel.cameraArr.count) {
         
         // Data Model
         EPImageModel *modelPic = [EPImageModel new];
         modelPic.subCateId = self.proModel.subCateId;
         modelPic.subCateName = self.proModel.subCateName;
         modelPic.cateId = self.proModel.cateId;
         modelPic.cateName = self.proModel.cateName;
         modelPic.sort = (int)self.nowIndex;
         modelPic.sortId = kPartsImgsPoIDArr[self.partsIndex][self.nowIndex];
         modelPic.sortName = kPartsImgsPoNameArr[self.partsIndex][self.nowIndex];
         modelPic.isPaiZhaoFlag = @"NO";
         modelPic.cameraImgStr = @"";
         modelPic.tempImgStr = kDefaultTempImageArray[self.partsIndex][self.nowIndex];
         modelPic.composeImgStr = @"";
         [self.proModel.cameraArr addObject:modelPic];
         
         // UI Model
         EPTakePictureModel *photoModel = [EPTakePictureModel new];
         photoModel.partsIndex = self.partsIndex;
         photoModel.index = self.nowIndex;
         photoModel.title = kPartsImgsPoNameArr[self.partsIndex][self.nowIndex];
         [self.takeCasePicArr addObject:photoModel];
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

#pragma mark - 事件处理
- (IBAction)btnClickAction:(UIButton *)button {

    if (button.tag == 0) {  /** 返回上一个界面 */
        
        [self.Vc dismissViewControllerAnimated:YES completion:nil];

        
    }else if (button.tag == 1) {    /** 完成并保存退出*/
        
        // 如果是拍完照处于预览界面
        if (self.takePicStatusType == CaseTakePicStatusTypeTakePic ) { [self confirmSaveTakePicture]; }
         
        // 去除新增空位
        if (self.takeCasePicArr.count > [kPartsCountArr[self.partsIndex] intValue] && !self.takeBtn.isHidden) {
           [self.takeCasePicArr removeLastObject];
           [self.proModel.cameraArr removeLastObject];
        }
        
        // Block回传数据，返回上一页。
//        if (self.saveClickBlock) {  self.saveClickBlock(self.proModel,self.photoArr); }
        [self.Vc dismissViewControllerAnimated:YES completion:nil];
        
        
    }else if (button.tag == 3) {    /** 取消当前拍照 */
        
        self.takePicStatusType = CaseTakePicStatusTypeDefault;
        
    }else if (button.tag == 4) {    /** 点击拍照 */
       
        // AVCapturePhotoCaptureDelegate  输出图片
        [self.imageOutput capturePhotoWithSettings:[AVCapturePhotoSettings photoSettings] delegate:self];
  
        
    }else if (button.tag == 5) {    /** 确认并拍摄下一张 */
         
        [self confirmSaveTakePicture];
        
        // 新增空位
        if (!self.nextBtn.selected) {
            self.nowIndex = self.nowIndex + 1;// 更新索引
            // 添加相关补充(添加占位图model)
            if (self.nowIndex == self.proModel.cameraArr.count) {
                EPImageModel *modelPic = [EPImageModel new];
                modelPic.subCateId = self.proModel.subCateId;
                modelPic.subCateName = self.proModel.subCateName;
                modelPic.cateId = self.proModel.cateId;
                modelPic.cateName = self.proModel.cateName;
                modelPic.sort = (int)self.nowIndex;
                modelPic.sortId = kPartsImgsPoIDArr[self.partsIndex][self.nowIndex];
                modelPic.sortName = kPartsImgsPoNameArr[self.partsIndex][self.nowIndex];
                modelPic.isPaiZhaoFlag = @"NO";
                modelPic.cameraImgStr = @"";
                modelPic.tempImgStr = kDefaultTempImageArray[self.partsIndex][self.nowIndex];
                modelPic.composeImgStr = @"";
                [self.proModel.cameraArr addObject:modelPic];
                // 图片数组
                EPTakePictureModel *photoModel = [EPTakePictureModel new];
                photoModel.index = self.nowIndex;
                photoModel.partsIndex = self.partsIndex;
                photoModel.title = kPartsImgsPoNameArr[self.partsIndex][self.nowIndex];
                [self.takeCasePicArr addObject:photoModel];
            }
            // 更新画面
            [self updateUIAndLoadImageData];
            self.takePicStatusType = CaseTakePicStatusTypeDefault;
            
        }else{
            // 拍摄到最后一张,则执行完成并保存退出操作
            [self btnClickAction:self.saveBtn];
        }
        
    }else if (button.tag == 6) {    /** 跳过本次拍摄 */
        
        if (self.nowIndex == self.proModel.cameraArr.count) { return; } // 达到拍照上限
        self.nowIndex = self.nowIndex + 1;// 更新索引
        self.takePicStatusType = CaseTakePicStatusTypeDefault; // 切换UI状态
        [self updateUIAndLoadImageData]; // 刷新界面家在数据
            
    }else if (button.tag == 7) {    /** 手电筒 */
        
        button.selected = !button.selected;
        [AppPhotoUtils controlClashlightWith:button.selected];
       
    }else if (button.tag == 8) {     /** 切换摄像头 */
       
        [self switchCamerasBackFont];
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
    self.previewLayer.frame = CGRectMake(0, 0,APP_WIDTH, APP_HEIGHT * 0.5 );
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

/** 保存拍摄的图片 */
- (void)confirmSaveTakePicture{
    
    // 保存新Model(替换)
    EPImageModel *model = [EPImageModel new];
    model.subCateId = self.proModel.subCateId;
    model.subCateName = self.proModel.subCateName;
    model.cateId = self.proModel.cateId;
    model.cateName = self.proModel.cateName;
    model.sort = (int)self.nowIndex;
    model.sortId = kPartsImgsPoIDArr[self.partsIndex][self.nowIndex];
    model.sortName = kPartsImgsPoNameArr[self.partsIndex][self.nowIndex];
    model.isPaiZhaoFlag = @"YES";
    model.cameraImgStr = tableNameImage(KUID, @"iOSPZ", [AppUtils getNowTimeCuo], [NSString stringWithFormat:@"%ld",(long)self.nowIndex]);
    model.tempImgStr = self.proModel.cameraArr[self.nowIndex].tempImgStr;// 不改变对比图
    [self.proModel.cameraArr replaceObjectAtIndex:self.nowIndex withObject:model];
    
    // 确认照片
    EPTakePictureModel *photoModel = [EPTakePictureModel new];
    photoModel.index = self.nowIndex;
    photoModel.cameraImage = self.headOutputImgView.contentImg;
    photoModel.defaultImage = self.takeCasePicArr[self.nowIndex].defaultImage;
    photoModel.title = kPartsImgsPoNameArr[self.partsIndex][self.nowIndex];
    [self.takeCasePicArr replaceObjectAtIndex:self.nowIndex withObject:photoModel];
}

/** 更新UI界面加载图片数据 */
- (void)updateUIAndLoadImageData{
     
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
    self.footStandardImgView.image = standardImage;
    self.footCKImgView.image = tempImage;
    if (self.nowIndex == self.proModel.cameraArr.count - 1) { self.nextBtn.hidden = YES; }
    
}

#pragma mark AVCapturePhotoCaptureDelegate
- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(NSError *)error {
    
    if (error) { NSLog(@"拍摄角度选择-弹出拍照-点击拍照-拍摄失败，原因:%@",error.localizedDescription); return; }
    
    if (photo) {

        CGImageRef cgImage = [photo CGImageRepresentation];
        UIImage * image = [UIImage imageWithCGImage:cgImage];
        NSLog(@"拍摄角度选择-弹出拍照-点击拍照-拍摄成功:%@",image);
 
        // 图片纠正
//        image = [image normalizedImage];
//
        // 图片纠正
        if (self.deviceInput.device.position == AVCaptureDevicePositionFront) {
          UIImageOrientation imgOrientation = UIImageOrientationLeftMirrored;
          image = [[UIImage alloc]initWithCGImage:cgImage scale:1.0f orientation:imgOrientation];
        }else {
          UIImageOrientation imgOrientation = UIImageOrientationRight;
          image = [[UIImage alloc]initWithCGImage:cgImage scale:1.0f orientation:imgOrientation];
        }
        
        
        // 此时图片的尺寸为3024 × 4032，大约14M左右。
        // 根据长宽比进行剪裁处理,XR举例： 375：406  ==  3024 ： 3274
        CGFloat imgResultW = self.headOutputImgView.width;
        CGFloat imgResultH = self.headOutputImgView.height  ;
        CGFloat imgMyW =  image.size.width;
        CGFloat imgMyH =  imgMyW * imgResultH / imgResultW ;
        CGSize imgeSize = CGSizeMake(imgMyW, imgMyH);
 
        //对图片尺寸进行剪裁
        UIImage *imageNew = [self thumbnailWithImage:image size:imgeSize];
        
        //对图片大小进行压缩
//        NSData *dataImg = UIImageJPEGRepresentation(imageNew, 0.2);
//        UIImage *imageNewNew = [UIImage imageWithData:dataImg];
 
        self.headOutputImgView.contentImg = imageNew;
        [self.headOutputImgView setHidden:NO];
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);

    }
}

//对图片尺寸剪裁
- (UIImage *)thumbnailWithImage:(UIImage *)originalImage size:(CGSize)size{
 
     CGSize originalsize = [originalImage size];

     //原图长宽均小于标准长宽的，不作处理返回原图
     if (originalsize.width<size.width && originalsize.height<size.height) { return originalImage;}

     //原图长宽均大于标准长宽的，按比例缩小至最大适应值
     else if(originalsize.width>size.width && originalsize.height>size.height){

         CGFloat rate = 1.0;
         CGFloat widthRate = originalsize.width/size.width;
         CGFloat heightRate = originalsize.height/size.height;
         rate = widthRate>heightRate?heightRate:widthRate;
         CGImageRef imageRef = nil;

         if (heightRate>widthRate){
            //获取图片整体部分
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height*rate/2, originalsize.width, size.height*rate));
         }else {
            //获取图片整体部分
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width*rate/2, 0, size.width*rate, originalsize.height));
         }

         UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
         CGContextRef con = UIGraphicsGetCurrentContext();
         CGContextTranslateCTM(con, 0.0, size.height);
         CGContextScaleCTM(con, 1.0, -1.0);
         CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
         UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
         UIGraphicsEndImageContext();
         CGImageRelease(imageRef);
         return standardImage;
     }

     //原图长宽有一项大于标准长宽的，对大于标准的那一项进行裁剪，另一项保持不变
     else if(originalsize.height>size.height || originalsize.width>size.width){

         CGImageRef imageRef = nil;

         if(originalsize.height>size.height){
            //获取图片整体部分
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height/2, originalsize.width, size.height));

         }else if (originalsize.width>size.width){

            //获取图片整体部分
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width/2, 0, size.width, originalsize.height));

         }

        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(con, 0.0, size.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[standardImage size].width,[standardImage size].height);
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        return standardImage;

     }
   
    //原图为标准长宽的，不做处理
     else{  return originalImage; }
          
 
}
 
 
@end
