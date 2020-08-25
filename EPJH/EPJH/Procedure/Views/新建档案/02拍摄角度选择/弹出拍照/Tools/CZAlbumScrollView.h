//
//  CZAlbumScrollView.h
//  EPJH
//
//  Created by Hans on 2020/8/17.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZAlbumScanModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZAlbumScrollView : UIScrollView

 
@property(nonatomic,strong) CZAlbumScanModel *imageModel;
/**图片*/
@property(nonatomic,strong) UIImageView *contentImageView;

@end

NS_ASSUME_NONNULL_END
