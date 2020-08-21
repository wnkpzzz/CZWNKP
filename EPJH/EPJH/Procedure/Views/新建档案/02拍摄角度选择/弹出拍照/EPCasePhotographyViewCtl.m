//
//  EPCasePhotographyViewCtl.m
//  EPJH
//
//  Created by Hans on 2020/8/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPCasePhotographyViewCtl.h"
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

#pragma mark - 基础配置
- (void)loadBaseConfig{
    
    [self.view addSubview:self.popView];

}

/** 传入数据 */
- (void)reloadDataWithModel:(EPProjectModel *)proModel pictureArr:(NSArray *)takeCasePicArr nowSign:(NSInteger)nowIndex{
    
}

- (EPCasePhotographySuspensionView *)popView{

    if (!_popView) {
        _popView = [EPCasePhotographySuspensionView initWithCustomView];
        _popView.frame = FullViewRect;
        _popView.Vc = self;
    }
    return _popView;
}
 
@end
