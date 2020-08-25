//
//  CZAlbumScrollView.m
//  EPJH
//
//  Created by Hans on 2020/8/17.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "CZAlbumScrollView.h"

 
@interface CZAlbumScrollView () <UIScrollViewDelegate>



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
    self.bouncesZoom = NO;
    [self setZoomScale:1.0];
    self.alwaysBounceVertical = YES;
    self.alwaysBounceHorizontal = YES;
    self.minimumZoomScale = 0.01; //最小缩放比例
    self.maximumZoomScale =  10.0;    //最大缩放比例
    self.contentInset = UIEdgeInsetsMake(800, 800, 800, 800);  // 增加额外的滚动区域
    
    [self addSubview:self.contentImageView];
}

- (void)layoutSubviews{

    [super layoutSubviews];
    

 
}

 

- (UIImageView *)contentImageView{

    if (!_contentImageView) {
        _contentImageView = [[UIImageView alloc] init];
        _contentImageView.contentMode = UIViewContentModeScaleToFill;
        _contentImageView.frame = CGRectMake(0, 0, self.width, self.height);

         
    }
    return _contentImageView;
}


- (void)setImageModel:(CZAlbumScanModel *)imageModel{
    
    _imageModel = imageModel;
   
}

@end

