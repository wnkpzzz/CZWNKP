//
//  EPLaunchViewCtl.m
//  EPJH
//
//  Created by Hans on 2020/7/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPLaunchViewCtl.h"

@interface EPLaunchViewCtl ()<SDCycleScrollViewDelegate>

@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;

@end

@implementation EPLaunchViewCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.cycleScrollView];

}

- (void)goToNextViewCtl{
    
    if ([AppJump isLogin]) {  [AppJump goHomeVC]; }else{ [AppJump goLoginVC]; }
}

#pragma mark - SDCycleScrollViewDelegate

- (SDCycleScrollView *)cycleScrollView {
    
    if (!_cycleScrollView) {
        
        NSArray * imgArr = [[NSArray alloc] init];
        
        if (APP_HEIGHT > 812.0f) {
            
            UIImage * img0 = [UIImage imageNamed:@"launch_10"];
            UIImage * img1 = [UIImage imageNamed:@"launch_11"];
            UIImage * img2 = [UIImage imageNamed:@"launch_12"];
            UIImage * img3 = [UIImage imageNamed:@"launch_13"];
            imgArr = @[img0,img1,img2,img3];
            
        }else if  ([UIScreen mainScreen].bounds.size.height > 736.0f) {
            
            UIImage * img0 = [UIImage imageNamed:@"launch_4"];
            UIImage * img1 = [UIImage imageNamed:@"launch_5"];
            UIImage * img2 = [UIImage imageNamed:@"launch_6"];
            UIImage * img3 = [UIImage imageNamed:@"launch_7"];
            imgArr = @[img0,img1,img2,img3];
            
        }else{
            
            UIImage * img0 = [UIImage imageNamed:@"launch_0"];
            UIImage * img1 = [UIImage imageNamed:@"launch_1"];
            UIImage * img2 = [UIImage imageNamed:@"launch_2"];
            UIImage * img3 = [UIImage imageNamed:@"launch_3"];
            imgArr = @[img0,img1,img2,img3];
        }
        
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero shouldInfiniteLoop:YES imageNamesGroup:imgArr];
        _cycleScrollView.frame = CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT);
        _cycleScrollView.delegate = self;
        _cycleScrollView.showPageControl = NO;
        _cycleScrollView.autoScrollTimeInterval = 2;
        _cycleScrollView.autoScroll = YES;  // 是否自动滚动
    }
    
    return _cycleScrollView;
    
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    if (index == 0) {  [self goToNextViewCtl];  }
    if (index == 1) {  [self goToNextViewCtl];  }
    if (index == 2) {  [self goToNextViewCtl];  }
    if (index == 3) {  [self goToNextViewCtl];  }
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
    if (index == 3) {  [self performSelector:@selector(goToNextViewCtl) withObject:nil afterDelay:1.5f];  }
}

@end
