//
//  EPCameraTypeLayout.h
//  EPJH
//
//  Created by Hans on 2020/8/26.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EPCameraTypeLayout : UICollectionViewFlowLayout

@property (nonatomic,assign) NSUInteger rowCount;           // 一页显示多少行
@property (nonatomic,assign) NSUInteger itemCountPerRow;    // 一行中 cell 的个数

@end

NS_ASSUME_NONNULL_END
