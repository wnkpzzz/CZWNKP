//
//  EP_Cell_CaseSqe.m
//  EPJH
//
//  Created by Hans on 2020/11/5.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EP_Cell_CaseSqe.h"
#import "EP_Model_CaseSqeList.h"
#import "EP_Cell_CaseSqe_Details.h"

@interface EP_Cell_CaseSqe ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *brandLab;
@property (weak, nonatomic) IBOutlet UILabel *projectLab;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;

@property (weak, nonatomic) IBOutlet UICollectionView *albumCollView;
@property (nonatomic,strong) NSMutableArray *collectionItems;

@end

@implementation EP_Cell_CaseSqe

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // 基础UI
    self.timeLab.textColor = kLightTextColor;
    self.brandLab.textColor = kMainTextColor;
    self.collectionItems = [NSMutableArray arrayWithCapacity:10];

    [self createCollectionView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataModel:(EP_Model_CaseSqeList *)dataModel{
    
    _dataModel = dataModel;

    self.nameLab.text = dataModel.uploadName;
    [self.collectBtn setSelected:dataModel.isCollection];
    self.brandLab.text = [NSString stringWithFormat:@"品牌: %@",dataModel.brandName];
    self.projectLab.text = [NSString stringWithFormat:@"项目: %@",dataModel.projectName];
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:dataModel.uploadHeadImage] placeholderImage:placeHolderImg];
    self.timeLab.text = [AppUtils timestampChangeTime:[NSString stringWithFormat:@"%ld",(long)dataModel.caseDate] WithFormat:@"yyyy/MM/dd"];
 
    [self.collectionItems removeAllObjects];
    [self.collectionItems addObjectsFromArray:dataModel.imageList];
    [self.albumCollView reloadData];
 
}

#pragma mark - 点击事件

- (IBAction)collectBtnAction:(id)sender { if (self.collectClickBlock) { self.collectClickBlock(self); } }

- (IBAction)popBtnAction:(id)sender { if (self.popClickpBlock) { self.popClickpBlock(self); } }
 
#pragma mark - UICollectionViewDataSource

- (void)createCollectionView{
 
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    float theItemWidth = (APP_WIDTH - 70) * 0.5;
    flowLayout.itemSize = CGSizeMake(theItemWidth, theItemWidth);  // 设置每个Item大小
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal; // 横纵滚动方式
    flowLayout.minimumLineSpacing = 5; // 两个Item上下间距大小
    flowLayout.minimumInteritemSpacing = 0;  // 两个Item左右间距大小
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0); // 每一个 section 与周边的间距

    self.albumCollView.collectionViewLayout = flowLayout;
    self.albumCollView.delegate = self;
    self.albumCollView.dataSource = self;
    self.albumCollView.showsHorizontalScrollIndicator = NO;
    self.albumCollView.backgroundColor = [UIColor whiteColor];
    [self.albumCollView registerNib:[UINib nibWithNibName:NSStringFromClass( [EP_Cell_CaseSqe_Details class] ) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:[EP_Cell_CaseSqe_Details cellID]];
    }

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  
    if (self.collectionItems.count >= 2) { return 2; }else{  return self.collectionItems.count; }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    EP_Cell_CaseSqe_Details *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[EP_Cell_CaseSqe_Details cellID] forIndexPath:indexPath];

    cell.dataDic = self.collectionItems[indexPath.row];
    
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
 
}

@end
