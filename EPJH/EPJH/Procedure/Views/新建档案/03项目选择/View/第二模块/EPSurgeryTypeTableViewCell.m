//
//  EPSurgeryTypeTableViewCell.m
//  EPJH
//
//  Created by Hans on 2020/8/25.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPSurgeryTypeTableViewCell.h"
#import "EPCameraTypeLayout.h"
#import "EPSurgeryTypeCollectionViewCell.h"

#define numCountInRow       3 // 每页N列,几个竖行。
#define numCountIncolumn    3 // 每页N行,几个横行。

@interface EPSurgeryTypeTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation EPSurgeryTypeTableViewCell

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
    layout.minimumLineSpacing = 25;
    layout.minimumInteritemSpacing = 15;
    self.collectionView.collectionViewLayout = layout;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:[EPSurgeryTypeCollectionViewCell cellID] bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:[EPSurgeryTypeCollectionViewCell cellID]];
}

- (void)setListData:(NSArray *)listData{
    
    _listData = listData;
      
    if (listData.count / (numCountInRow * 3)) {
      
        if (listData.count % (numCountInRow * 3)) {
            self.pageControl.numberOfPages = listData.count / (numCountInRow * 3) + 1;
        }else{
            self.pageControl.numberOfPages = listData.count / (numCountInRow * 3);
        }
        self.pageControl.hidden = NO;
        
    }else{
      
        self.pageControl.hidden = YES;
    }
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat  LRMargin = 13;

    NSInteger itemW = (APP_WIDTH- LRMargin * numCountInRow * numCountIncolumn) / numCountInRow;

    return CGSizeMake(itemW, 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(8,13,8,13);//分别为上、左、下、右
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.listData.count/(numCountInRow*numCountIncolumn)) {
        
        if (self.listData.count%(numCountInRow*numCountIncolumn)) {
            return (self.listData.count/(numCountInRow*numCountIncolumn)+1)*(numCountInRow*numCountIncolumn);
        }else{
            return self.listData.count;
        }
    }else{
        return self.listData.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    EPSurgeryTypeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[EPSurgeryTypeCollectionViewCell cellID] forIndexPath:indexPath];

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
    classifyModel.isSelected = !classifyModel.isSelected;
    if (self.backSelectItemBlock) { self.backSelectItemBlock(indexPath.row,classifyModel.isSelected);}
    [self.collectionView reloadData];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat scrollViewW = scrollView.frame.size.width;
    
    CGFloat x = scrollView.contentOffset.x;
    
    int page = (x + scrollViewW/2)/scrollViewW;
    
    _pageControl.currentPage = page;
    
}



@end

