//
//  EPHomeCycleScrollView.m
//  EPJH
//
//  Created by Hans on 2020/7/16.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPHomeCycleScrollView.h"

@interface EPHomeCycleScrollView ()<SDCycleScrollViewDelegate>

@end

@implementation EPHomeCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.cycleScrollView];
        
    }
    
    return self;
}

-(SDCycleScrollView *)cycleScrollView{
    
    if (!_cycleScrollView) {
        
        UIImage * img = [UIImage imageNamed:@"icon_home_placeHolder"]; 
        NSArray * imgArr = @[img,img];
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.width, self.height) imageNamesGroup:imgArr];
        _cycleScrollView.delegate = self;
        _cycleScrollView.autoScroll = YES;
        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.pageControlBottomOffset = 10;
        _cycleScrollView.pageDotColor = [UIColor whiteColor];
        _cycleScrollView.currentPageDotColor = kMainBlueColor;
        _cycleScrollView.placeholderImage = [UIImage imageNamed:@"ic_home_bg"];
        
    }
    
    return _cycleScrollView;
}

/** 点击图片回调 */
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    // NSLog(@">>>>>> 点击到第%ld张图", (long)index);

    self.btnClickBlock(self, index);

}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
    // NSLog(@">>>>>> 滚动到第%ld张图", (long)index);
}


@end
