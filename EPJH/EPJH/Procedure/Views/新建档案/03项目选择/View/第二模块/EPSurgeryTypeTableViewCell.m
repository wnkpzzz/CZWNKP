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
 
@property (nonatomic,strong) UIPageControl * pageControl;
@property (nonatomic,strong) UICollectionView * collectionView;

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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadBaseConfig];
    }
    return self;
}

#pragma mark - 基础配置
- (void)loadBaseConfig{
     
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(self.contentView);
        make.height.equalTo(@20);
    }];

    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.contentView);
        make.bottom.equalTo(self.pageControl.mas_top);
    }];
    
}


-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectZero];
        _pageControl.currentPageIndicatorTintColor = kMainBlueColor;
        _pageControl.pageIndicatorTintColor = kMainTextColor;
        [self.contentView addSubview:_pageControl];
    }
    
    return _pageControl;
}

//列表
-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        if (self.listData.count >= numCountInRow *3) {
            EPCameraTypeLayout *layout = [[EPCameraTypeLayout alloc] init];
            [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
            layout.itemCountPerRow = numCountInRow;
            layout.rowCount = numCountIncolumn;
            layout.minimumLineSpacing = 25;
            layout.minimumInteritemSpacing = 15;
            _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        }else{
            
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
            layout.minimumLineSpacing = 25;
            layout.minimumInteritemSpacing = 15;
        }
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[EPSurgeryTypeCollectionViewCell class] forCellWithReuseIdentifier:[EPSurgeryTypeCollectionViewCell cellID]];
        [self addSubview:_collectionView];

        
    }
    return _collectionView;
}

- (void)setListData:(NSArray *)listData{
 
    _listData = listData;
     
     self.collectionView = nil;
     
     if (listData.count / (numCountInRow * numCountIncolumn )) {
         [self.pageControl mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.right.left.bottom.equalTo(self.contentView);
             make.height.equalTo(@20);
         }];
         
         if (listData.count % (numCountInRow * numCountIncolumn )) {
 
             _pageControl.numberOfPages = listData.count/(numCountInRow * numCountIncolumn )+1;
         }else{
             _pageControl.numberOfPages = listData.count/(numCountInRow * numCountIncolumn );
             
         }
         
         self.pageControl.hidden = NO;
         
     }else{
         [self.pageControl mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.right.left.bottom.equalTo(self.contentView);
             make.height.equalTo(@0);
         }];
         self.pageControl.hidden = YES;
     }
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.contentView);
        make.bottom.equalTo(self.pageControl.mas_top);
    }];
     
     [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat  LRMargin = 13;

    NSInteger itemW = (APP_WIDTH- LRMargin * numCountInRow * 2) / numCountInRow;

    return CGSizeMake(itemW, 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(8,13,8,13);//分别为上、左、下、右
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.listData.count / ( numCountInRow * numCountIncolumn )) {
        
        if (self.listData.count % ( numCountInRow * numCountIncolumn )) {
            return (self.listData.count / ( numCountInRow * numCountIncolumn ) + 1 ) * ( numCountInRow * numCountIncolumn );
        }else{
            return self.listData.count;
        }
    }else{
        return self.listData.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    EPSurgeryTypeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[EPSurgeryTypeCollectionViewCell cellID] forIndexPath:indexPath];

    cell.backgroundColor = [UIColor redColor];
    
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat scrollViewW = scrollView.frame.size.width;
    
    CGFloat x = scrollView.contentOffset.x;
    
    int page = (x + scrollViewW/2)/scrollViewW;
    
    _pageControl.currentPage = page;
    
}



@end

