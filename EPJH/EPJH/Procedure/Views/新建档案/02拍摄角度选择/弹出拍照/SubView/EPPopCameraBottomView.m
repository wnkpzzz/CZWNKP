//
//  EPPopCameraBottomView.m
//  EPJH
//
//  Created by Hans on 2020/8/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPPopCameraBottomView.h"

@interface EPPopCameraBottomView ()
 
@property (nonatomic,weak) UIButton *backButton; /** 返回按钮 */
@property (nonatomic,weak) UIButton *saveButton; /** 完成并保存按钮 */

@property (nonatomic,weak) UIButton *changeButton; /** 切换摄像头 */
@property (nonatomic,weak) UIButton *takePhotoButton;/** 拍照按钮 */
@property (nonatomic,weak) UIButton *albumButton;/** 相册按钮 */
@property (nonatomic,weak) UIButton *flashlightButton;/** 手电筒按钮 */
@property (nonatomic,weak) UIButton *takePhotosNextButton;/** 拍摄下一张按钮 */
@property (nonatomic,weak) UIButton *confirmNextButton;/** 确认并进入下一张拍摄按钮 */
@property (nonatomic,weak) UIButton *cancelButton;/** 取消当前拍摄 */
 

@end

@implementation EPPopCameraBottomView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {

//        [self addSubview:self.collectionView];

    }
    
    return self;
}

//- (UICollectionView *)collectionView {
//
//    if (!_collectionView) {
//
//        CGFloat viewW = self.width;
//        CGFloat viewH = self.height;
//
//        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        float theItemWidth = viewW  * 0.23;
//        flowLayout.itemSize = CGSizeMake(theItemWidth, viewH);
//        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        flowLayout.minimumLineSpacing = 0;
//        flowLayout.minimumInteritemSpacing = 0;
//        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//
//        CGRect rect = CGRectMake(0, 0, viewW, viewH);
//        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
//        collectionView.delegate = self;
//        collectionView.dataSource = self;
//        collectionView.showsHorizontalScrollIndicator = NO;
//        collectionView.backgroundColor = [UIColor whiteColor];
//        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass( [HomeCollectionViewCell class] ) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:[HomeCollectionViewCell cellID]];
//        _collectionView = collectionView;
//
//    }
//    return _collectionView;
//}
@end
