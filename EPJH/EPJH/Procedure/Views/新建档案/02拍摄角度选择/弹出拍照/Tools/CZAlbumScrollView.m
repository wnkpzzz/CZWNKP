//
//  CZAlbumScrollView.m
//  EPJH
//
//  Created by Hans on 2020/8/17.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "CZAlbumScrollView.h"

 
@interface CZAlbumScrollView () <UIScrollViewDelegate>

/**图片*/
@property(nonatomic,strong) UIImageView *contentImageView;

@end

@implementation CZAlbumScrollView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
         
        [self setupUI];
    }
    return self;
}



#pragma mark - UI
- (void)setupUI{
 
    self.bounces = NO;
    self.alwaysBounceVertical = YES;
    self.alwaysBounceHorizontal = YES;
    self.bouncesZoom = NO;
    [self setZoomScale:1.0];
    // 增加额外的滚动区域
    self.contentInset = UIEdgeInsetsMake(1000, 1000, 1000, 1000);
     
}

- (void)layoutSubviews{

    [super layoutSubviews];

     
    
}

- (void)setContentImg:(UIImage *)contentImg{
 
    self.contentImageView.image = contentImg;
    
}

- (UIImageView *)contentImageView
{
    if (!_contentImageView) {
        _contentImageView = [[UIImageView alloc] init];
        _contentImageView.contentMode = UIViewContentModeScaleToFill;
        _contentImageView.frame = self.bounds;
        [self addSubview:_contentImageView];
    }
    return _contentImageView;
}

@end
