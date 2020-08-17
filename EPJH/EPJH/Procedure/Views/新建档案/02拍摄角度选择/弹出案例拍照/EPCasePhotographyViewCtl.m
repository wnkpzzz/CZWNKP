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

#import "EPCasePhotographySuspensionView.h"


@interface EPCasePhotographyViewCtl ()
 
@property (nonatomic, strong) EPCasePhotographySuspensionView *popView;



 

 
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

/** 传入数据 */
- (void)reloadDataWithModel:(EPProjectModel *)model photoArr:(NSArray *)photoArr nowIndex:(NSInteger)nowIndex{
    
}


#pragma mark - 基础配置
- (void)loadBaseConfig{
    
    [self.view addSubview:self.popView];

}

- (EPCasePhotographySuspensionView *)popView{

    if (!_popView) {
        _popView = [EPCasePhotographySuspensionView initWithCustomView];
        _popView.frame = FullViewRect;
        _popView.takePicStatusType = CaseTakePicStatusTypeDefault;
    }
    return _popView;
}
 


 
//#pragma mark - 懒加载
//// 成像图
//- (UIImageView *)outImageView{
//
//    if (!_outImageView) {
//        _outImageView = [[UIImageView alloc] init];
//        _outImageView.backgroundColor = [UIColor whiteColor];
//        _outImageView.contentMode = UIViewContentModeScaleAspectFit;
//    }
//    return _outImageView;
//}
//// 参考线框图
//- (UIImageView *)tempImageView{
//
//    if (!_tempImageView) {
//        _tempImageView = [[UIImageView alloc] init];
//        _tempImageView.contentMode = UIViewContentModeScaleAspectFit;
//    }
//    return _tempImageView;
//}
//// 标准对照图
//- (UIImageView *)standardImageView{
//
//    if (!_standardImageView) {
//        _standardImageView = [[UIImageView alloc] init];
//        _standardImageView.backgroundColor = [UIColor whiteColor];
//        _standardImageView.contentMode = UIViewContentModeScaleAspectFit;
//    }
//    return _standardImageView;
//}


 

@end
