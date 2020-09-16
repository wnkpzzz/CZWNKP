//
//  EPHomeCollectionView.m
//  EPJH
//
//  Created by Hans on 2020/7/16.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPHomeCollectionView.h"
#import "HomeCollectionViewCell.h"

@interface EPHomeCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation EPHomeCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {

        [self addSubview:self.collectionView];

    }
    
    return self;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        CGFloat viewW = self.width;
        CGFloat viewH = self.height;
        
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        float theItemWidth = viewW  * 0.23;
        flowLayout.itemSize = CGSizeMake(theItemWidth, viewH);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        CGRect rect = CGRectMake(0, 0, viewW, viewH);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = [UIColor whiteColor];
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass( [HomeCollectionViewCell class] ) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:[HomeCollectionViewCell cellID]];
        _collectionView = collectionView;
        
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HomeCollectionViewCell cellID] forIndexPath:indexPath];
    NSArray * titleArr = @[@"案例广场",@"档案查询",@"拼图工具",@"手术百科",@"我的案例"];
    NSArray * imgArr = @[@"iocn_home_caseplaza",@"iocn_home_query",@"iocn_home_pictool",@"iocn_home_surgery",@"iocn_home_mycase"];
    cell.titleLabel.text = titleArr[indexPath.row];
    cell.titleImgView.image  = [UIImage imageNamed:imgArr[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
      
    self.btnClickBlock(self, indexPath.row);
    
}

@end
