//
//  EPAngleSelectCell.m
//  EPJH
//
//  Created by Hans on 2020/7/27.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPAngleSelectCell.h"

@interface EPAngleSelectCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *showBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *selectView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectViewHeight;// 选择视图高度约束

@property (nonatomic, strong) NSArray * titleArr;
@property (nonatomic, assign) NSInteger rowIndex;// 显示行数
@property (nonatomic, assign) NSInteger selectedIndex;// 选中索引

@end

@implementation EPAngleSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self loadBaseConfig];
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

#pragma mark - 基础配置

- (void)loadBaseConfig{
       
    self.rowIndex = 0;
    self.selectedIndex = 0;
    [self createCollectionView];
}

- (void)reloadDataWithArray:(NSArray *)dataArray{
    
    self.titleArr = [[NSArray alloc] init];
    self.titleArr = [NSArray arrayWithArray:dataArray];
    [self.selectView reloadData];
    self.rowIndex = self.titleArr.count%5==0?self.titleArr.count%5:(self.titleArr.count%5+1);
}

- (IBAction)shouAction:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.selectViewHeight.constant = self.rowIndex*kWidth(30);
    }else{
        self.selectViewHeight.constant = kWidth(30);
    }
    if (self.showBlock) {
        self.showBlock();// 刷新界面
    }
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (void)createCollectionView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((APP_WIDTH - 40 - kWidth(60))/5, kWidth(20));
    flowLayout.minimumLineSpacing = kWidth(10);
    flowLayout.minimumInteritemSpacing = kWidth(15);
    flowLayout.sectionInset = UIEdgeInsetsMake(kWidth(10), 20, 0, 20);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.selectView.collectionViewLayout = flowLayout;
    
    self.selectView.delegate = self;
    self.selectView.dataSource = self;
    self.selectViewHeight.constant = kWidth(30);
    [self.selectView registerClass:[EPAngleSelectColCell class] forCellWithReuseIdentifier:[EPAngleSelectColCell cellID]];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    EPAngleSelectColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[EPAngleSelectColCell cellID] forIndexPath:indexPath];
    cell.mainLabel.text = self.titleArr[indexPath.item];
    if (_selectedIndex == indexPath.item) {
        cell.mainLabel.textColor = [UIColor whiteColor];
        cell.mainLabel.backgroundColor = [UIColor colorWithHexString:@"#00B0FF"];
    }else{
        cell.mainLabel.textColor = [UIColor colorWithHexString:@"#737373"];
        cell.mainLabel.backgroundColor = [UIColor colorWithHexString:@"#FAFAFA"];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_selectedIndex == indexPath.item) {
        return;
    }
    if (self.selectBlock) {
        self.selectBlock(indexPath.item);
    }
    _selectedIndex = indexPath.item;
    [self.selectView reloadData];
}

@end

