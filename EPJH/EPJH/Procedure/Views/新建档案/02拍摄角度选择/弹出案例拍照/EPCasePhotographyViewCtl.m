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

@interface EPCasePhotographyViewCtl ()
 
 
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
@property(nonatomic,strong) UIImage *tempImage;               // 上半区参照虚线图

@property (nonatomic, strong) UIImageView *standardImageView;   /** 下半区标准对比图 */
@property(nonatomic,strong) UIImage *standrandImage;          // 下半区标准照图片
@property(nonatomic,copy)   NSString *standrandImageUrl;      // 下半区标准照图片地址

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
 
// **************** 《数据逻辑》 **********************
 
@property (nonatomic, assign) NSInteger partsIndex;                     /** 节点索引 */
@property (nonatomic, assign) NSInteger nowIndex;                       /** 当前拍摄的索引 */
@property (nonatomic, copy)   EPProjectModel *proModel;                   /** 数据源 */
@property (nonatomic, strong) NSMutableArray<EPTakePictureModel *> *photoArr; /** 拍照结果数组（需要展示的图，没拍的位置用默认图显示） */

 
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
    
//    // KVO 监听对焦回调
//    [self.device addObserver:self forKeyPath:@"adjustingFocus" options:NSKeyValueObservingOptionNew context:nil];
//    if (self.session) {
//        [self.session startRunning];
//    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
//    // 移除KVO
//    [self.device removeObserver:self forKeyPath:@"adjustingFocus"];
//    if (self.session) {
//        [self.session stopRunning];
//    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
}

#pragma mark - 基础配置
- (void)loadBaseConfig{
    
    self.view.backgroundColor = [UIColor blackColor];

    self.effectiveScale = self.beginGestureScale = 1.0f;

    
    // ***********************************《上半部》**************************************
    
    NSError *error;
    self.session = [[AVCaptureSession alloc] init];
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    self.imageOutput = [[AVCapturePhotoOutput alloc] init];
//    [self.imageOutput setOutputSettings:[[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecTypeJPEG,AVVideoCodecKey, nil]];
    if ([self.session canSetSessionPreset:AVCaptureSessionPresetPhoto]) { self.session.sessionPreset = AVCaptureSessionPresetPhoto; }
    if ([self.session canAddInput:self.deviceInput]) {[self.session addInput:self.deviceInput]; }
    if ([self.session canAddOutput:self.imageOutput]) {[self.session addOutput:self.imageOutput]; }
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame = CGRectMake(0, 0,APP_WIDTH, APP_HEIGHT / 2);
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
     
    // ***********************************《上半部》**************************************


 
    [self.view addSubview:self.outImageView];
    [self.view addSubview:self.tempImageView];
      
      // ***********************************《下半部》**************************************

      //标准图
      [self.view addSubview:self.standardImageView];
      
      //返回按钮
      UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
      [backButton setImage:[UIImage imageNamed:@"icon_pro_takePic_back"] forState:UIControlStateNormal];
      [backButton setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.4]];
      backButton.layer.masksToBounds = YES;
      backButton.layer.cornerRadius = 16;
      [backButton addTarget:self action:@selector(actionBack) forControlEvents:UIControlEventTouchUpInside];
      [self.view addSubview:backButton];
      self.backButton = backButton;
      
      //完成并保存按钮
      UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
      saveButton.titleLabel.font = [UIFont systemFontOfSize:16];
      [saveButton setTitle:@"完成" forState:UIControlStateNormal];
      [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      [saveButton setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.4]];
      saveButton.layer.masksToBounds = YES;
      saveButton.layer.cornerRadius = 16;
      [saveButton addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
      [self.view addSubview:saveButton];
      self.saveButton = saveButton;
      
      //切换摄像头视图
      UIButton *changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
      [changeButton setImage:[UIImage imageNamed:@"icon_pro_takePic_switch"] forState:UIControlStateNormal];
      [changeButton addTarget:self action:@selector(actionChangeCamera) forControlEvents:UIControlEventTouchUpInside];
      [self.view addSubview:changeButton];
      self.changeButton = changeButton;
      
      //手电筒
      UIButton *flashlightButton = [[UIButton alloc] init];
      [flashlightButton setImage:[UIImage imageNamed:@"icon_pro_takePic_flashlight_on"] forState:UIControlStateNormal];
      [flashlightButton setImage:[UIImage imageNamed:@"icon_pro_takePic_flashlight_out"] forState:UIControlStateSelected];
      [flashlightButton addTarget:self action:@selector(flashlightAction:) forControlEvents:UIControlEventTouchUpInside];
      [self.view addSubview:flashlightButton];
      self.flashlightButton = flashlightButton;
      
      //相册
      UIButton *albumButton = [UIButton buttonWithType:UIButtonTypeCustom];
      [albumButton setTitle:@"" forState:UIControlStateNormal];
      [albumButton setTitle:@"" forState:UIControlStateSelected];
      [albumButton setImage:[UIImage imageNamed:@"icon_pro_takePic_gallery"] forState:UIControlStateNormal];
      [albumButton addTarget:self action:@selector(actionAlbumClick) forControlEvents:UIControlEventTouchUpInside];
      [self.view addSubview:albumButton];
      self.albumButton = albumButton;
      
      //拍照
      UIButton *takePhotoButton = [[UIButton alloc] init];
      [takePhotoButton setImage:[UIImage imageNamed:@"icon_pro_takPic"] forState:UIControlStateNormal];
      [takePhotoButton addTarget:self action:@selector(confirmWithCamera) forControlEvents:UIControlEventTouchUpInside];
      [self.view addSubview:takePhotoButton];
      self.takePhotoButton = takePhotoButton;
     
      //跳过本张拍摄按钮
      UIButton *takePhotosNextButton = [UIButton buttonWithType:UIButtonTypeCustom];
      [takePhotosNextButton setImage:[UIImage imageNamed:@"icon_pro_takePic_next"] forState:UIControlStateNormal];
      [takePhotosNextButton addTarget:self action:@selector(takePhotosNextButtonClick) forControlEvents:UIControlEventTouchUpInside];
      [self.view addSubview:takePhotosNextButton];
      self.takePhotosNextButton = takePhotosNextButton;
      
      //拍摄下一张按钮
      UIButton *confirmNextButton = [UIButton buttonWithType:UIButtonTypeCustom];
      [confirmNextButton setImage:[UIImage imageNamed:@"icon_pro_takePic_confirm"] forState:UIControlStateNormal];
      [confirmNextButton setImage:[UIImage imageNamed:@"icon_pro_takePic_complete"] forState:UIControlStateSelected];
      [confirmNextButton addTarget:self action:@selector(confirmNextButtonClick) forControlEvents:UIControlEventTouchUpInside];
      [self.view addSubview:confirmNextButton];
      self.confirmNextButton = confirmNextButton;
      
      //取消按钮
      UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
      [cancelButton setImage:[UIImage imageNamed:@"icon_pro_takePic_cancel"] forState:UIControlStateNormal];
      [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
      [self.view addSubview:cancelButton];
      self.cancelButton = cancelButton;
      
        [self.outImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.standardImageView.mas_top);
        }];
       
      [self.tempImageView mas_makeConstraints:^(MASConstraintMaker *make) {
          if (([UIScreen mainScreen].bounds.size.height >= 812.0f)) {
              make.top.mas_equalTo(0);
              make.left.mas_equalTo((APP_WIDTH - APP_HEIGHT * 0.5) * 0.5 );
              make.width.mas_equalTo(APP_HEIGHT * 0.5);
              make.height.mas_equalTo(APP_HEIGHT * 0.5);
          }else{
              make.left.top.right.mas_equalTo(self.view);
              make.bottom.mas_equalTo(self.standardImageView.mas_top);
          }
      }];
      
    
    
      [self.standardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.bottom.right.mas_equalTo(self.view);
          make.height.equalTo(self.view).multipliedBy(0.5);
      }];
      
      // 返回按钮
      [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.mas_equalTo(self.view).offset(40);
          make.left.mas_equalTo(self.view).offset(20);
          make.width.height.mas_equalTo(32);
      }];
      // 保存退出按钮
      [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerY.equalTo(self.backButton);
          make.right.mas_equalTo(self.view).offset(-20);
          make.size.mas_equalTo(CGSizeMake(60, 32));
      }];
      // 拍照按钮
      [self.takePhotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerX.mas_equalTo(self.standardImageView);
          make.bottom.mas_equalTo(self.standardImageView).offset(-1);
          make.width.height.mas_equalTo(120);
      }];
      // 相册按钮
      [self.albumButton mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerY.mas_equalTo(self.takePhotoButton);
          make.left.mas_equalTo(self.standardImageView).offset(20);
          make.width.height.mas_equalTo(80);
      }];
      // 前后置
      [self.changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.mas_equalTo(self.standardImageView).offset(-20);
          make.centerY.mas_equalTo(self.takePhotoButton);
          make.width.height.mas_equalTo(34);
      }];
      // 手电筒
      [self.flashlightButton mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerX.equalTo(self.changeButton);
          make.bottom.equalTo(self.changeButton.mas_top).offset(-20);
          make.width.height.mas_equalTo(34);
      }];
      // 跳过本张拍摄按钮
      [self.takePhotosNextButton mas_makeConstraints:^(MASConstraintMaker *make) {
          make.bottom.equalTo(self.flashlightButton.mas_top).offset(-41);
          make.centerX.equalTo(self.changeButton);
          make.width.height.mas_equalTo(34);
      }];
      // 取消按钮
      [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerY.mas_equalTo(self.takePhotoButton);
          make.left.equalTo(self.standardImageView).offset(69);
          make.width.height.mas_equalTo(50);
      }];
      // 保存本张并进行下一张拍摄按钮
      [self.confirmNextButton mas_makeConstraints:^(MASConstraintMaker *make) {
          make.centerY.mas_equalTo(self.takePhotoButton);
          make.right.equalTo(self.standardImageView).offset(-69);
          make.width.height.mas_equalTo(50);
      }];
}

#pragma mark - 点击事件
/** 返回页面 */
- (void)actionBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/** 手电筒 */
- (void)flashlightAction:(UIButton *)button{

    button.selected = !button.selected;
    [AppPhotoUtils controlClashlightWith:button.selected];
 
}

#pragma mark - 懒加载
// 成像图
- (UIImageView *)outImageView{

    if (!_outImageView) {
        _outImageView = [[UIImageView alloc] init];
        _outImageView.backgroundColor = [UIColor whiteColor];
        _outImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _outImageView;
}
// 参考线框图
- (UIImageView *)tempImageView{

    if (!_tempImageView) {
        _tempImageView = [[UIImageView alloc] init];
        _tempImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _tempImageView;
}
// 标准对照图
- (UIImageView *)standardImageView{

    if (!_standardImageView) {
        _standardImageView = [[UIImageView alloc] init];
        _standardImageView.backgroundColor = [UIColor whiteColor];
        _standardImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _standardImageView;
}


 

@end
