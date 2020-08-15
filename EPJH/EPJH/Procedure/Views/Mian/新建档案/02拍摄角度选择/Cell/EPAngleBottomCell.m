//
//  EPAngleBottomCell.m
//  EPJH
//
//  Created by Hans on 2020/7/27.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPAngleBottomCell.h"

@interface EPAngleBottomCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView * bottomCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * bottomViewHeight; // 选择视图高度约束

@property (nonatomic, assign) NSInteger rowIndex;// 显示行数
@property (nonatomic, strong) NSMutableArray *collectionItems;// 新数据源，为了显示新增加号

@end

@implementation EPAngleBottomCell

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
       
    self.rowIndex = 0;
    self.isShowAdd = NO;
    self.collectionItems = [NSMutableArray arrayWithCapacity:10];
    
    [self createCollectionView];
}

- (void)reloadDataSource:(NSArray *)dataArray{
    
    [self.collectionItems removeAllObjects]; // 清空
    [self.collectionItems addObjectsFromArray:dataArray];// 构造新数据源，新增加号占位图
       
    if (dataArray.count < 12 && self.isShowAdd) {
        EPPhotoModel *model = [EPPhotoModel new];
        model.cameraImage = [UIImage imageNamed:@"icon_pro_add_take"];
        model.title = @"添加";
        [self.collectionItems addObject:model];
    }
    [self updataViewHeight];
}
 
- (void)updataViewHeight{
    
    // 设置高度
    if (self.collectionItems.count%2 == 0) { self.rowIndex = self.collectionItems.count/2; }
    else{  self.rowIndex = self.collectionItems.count/2 + 1;}
    
    // 更新高度
    self.bottomViewHeight.constant = ((APP_WIDTH - kWidth(10) - 40)/2 + kWidth(28))*self.rowIndex + kWidth(20)+60 + kWidth(10)*(self.rowIndex - 1);
    [self.bottomCollectionView reloadData];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (void)createCollectionView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((APP_WIDTH - kWidth(10) - 40)/2, (APP_WIDTH - kWidth(10) - 40)/2 + kWidth(28));
    flowLayout.minimumLineSpacing = kWidth(10);
    flowLayout.minimumInteritemSpacing = kWidth(10);
    flowLayout.sectionInset = UIEdgeInsetsMake(kWidth(20), 20, 60, 20);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.estimatedItemSize = CGSizeZero;
    self.bottomCollectionView.collectionViewLayout = flowLayout;

    self.bottomCollectionView.delegate = self;
    self.bottomCollectionView.dataSource = self;
    self.bottomViewHeight.constant = ((APP_WIDTH - kWidth(10) - 40)/2 + kWidth(28))*self.rowIndex + kWidth(20)+60 + kWidth(10)*(self.rowIndex - 1);
    [self.bottomCollectionView registerNib:[UINib nibWithNibName:[EPBottomImgSelectColCell cellID] bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:[EPBottomImgSelectColCell cellID]];
     
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.collectionItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    EPBottomImgSelectColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[EPBottomImgSelectColCell cellID] forIndexPath:indexPath];
    EPPhotoModel *model = [self.collectionItems objectAtIndex:indexPath.item];
    cell.nameLab.text = model.title;
    if (model.cameraImage) { cell.contentImgView.image = model.cameraImage; }
    else{
        if (model.defaultImage) { cell.contentImgView.image = model.defaultImage;}
        else{  cell.contentImgView.image = [UIImage imageNamed:kDefaultTempImageArray[model.partsIndex][indexPath.item]];}
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.angleSelectBlock) { self.angleSelectBlock(indexPath.item); }
    
}

@end
