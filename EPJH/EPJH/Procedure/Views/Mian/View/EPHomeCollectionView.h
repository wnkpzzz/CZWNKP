//
//  EPHomeCollectionView.h
//  EPJH
//
//  Created by Hans on 2020/7/16.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EPHomeCollectionView : RootView

@property (strong, nonatomic)  UICollectionView * collectionView;

@property (copy,nonatomic) void (^btnClickBlock)(UIView *, NSInteger index);

@end

NS_ASSUME_NONNULL_END
