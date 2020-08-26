//
//  EPBodyPartTableViewCell.m
//  EPJH
//
//  Created by Hans on 2020/8/25.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPBodyPartTableViewCell.h"
#import "EPCameraBodyPartCollectionViewCell.h"
#import "EPCameraTypeLayout.h"

#define numCountInRow       4 // 每页N列,几个竖行。
#define numCountIncolumn    2 // 每页N行,几个横行。


@interface EPBodyPartTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation EPBodyPartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self loadBaseConfig];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 基础配置
- (void)loadBaseConfig{
    
    self.pageControl.currentPageIndicatorTintColor = kMainBlueColor;
    self.pageControl.pageIndicatorTintColor = kMainTextColor;
   
    EPCameraTypeLayout *layout = [[EPCameraTypeLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.rowCount = numCountIncolumn;
    layout.itemCountPerRow = numCountInRow;
    layout.minimumLineSpacing = 30;
    layout.minimumInteritemSpacing = 10;
    self.collectionView.collectionViewLayout = layout;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:[EPCameraBodyPartCollectionViewCell cellID] bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:[EPCameraBodyPartCollectionViewCell cellID]];
}

- (void)setListData:(NSArray *)listData{
    
    _listData = listData;
    
    if ( listData.count / (numCountInRow * numCountIncolumn)) {
        self.pageControl.numberOfPages = listData.count / (numCountInRow * numCountIncolumn) + 1;
    }else{
        self.pageControl.numberOfPages = listData.count / (numCountInRow * numCountIncolumn);
    }
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat  LRMargin = 15;

    NSInteger itemW = (APP_WIDTH - LRMargin * numCountInRow * numCountIncolumn) / numCountInRow;

    return CGSizeMake(itemW, 70);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(10,15,10,15);//分别为上、左、下、右

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (self.listData.count % (numCountInRow * numCountIncolumn)) {
        return (self.listData.count / (numCountInRow * numCountIncolumn)+1) * (numCountInRow * numCountIncolumn);
    }else{
        return self.listData.count;
    }
}
 
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    EPCameraBodyPartCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[EPCameraBodyPartCollectionViewCell cellID] forIndexPath:indexPath];

    if (indexPath.row >= self.listData.count) {
        cell.hidden = YES;
    }else{
        cell.hidden = NO;
        EPTypeListClassifyModel * classifyModel = self.listData[indexPath.row];
        cell.dataModel = classifyModel;
        cell.itemSelected = classifyModel.isSelected;
    }
 

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    EPTypeListClassifyModel * classifyModel = self.listData[indexPath.row];

    BOOL canSelect = NO;

    if (!classifyModel.isSelected) {
        canSelect = YES;
    }else{
        for (EPTypeListClassifyModel * model in self.listData) {
            if (model.isSelected && model !=classifyModel) {
            canSelect = YES;
            }
        }
    }

    if (canSelect) {

        classifyModel.isSelected = !classifyModel.isSelected;

        if (self.backSelectItemBlock) {
            self.backSelectItemBlock(indexPath.row,classifyModel.isSelected,NO);
        }
        [self.collectionView reloadData];
    }else{

        [MBProgressHUD showError:@"至少选择一个"];
        if (self.backSelectItemBlock) {
            self.backSelectItemBlock(indexPath.row,classifyModel.isSelected,YES);
        }
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat scrollViewW = scrollView.frame.size.width;
    
    CGFloat x = scrollView.contentOffset.x;
    
    int page = (x + scrollViewW/2)/scrollViewW;
    
    _pageControl.currentPage = page;
    
}

@end

