//
//  EP_Main_Cs_DetailsViewCtl.m
//  EPJH
//
//  Created by Hans on 2020/11/18.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EP_Main_Cs_DetailsViewCtl.h"
#import "EP_Cell_CaseSqe_Details.h"

@interface EP_Main_Cs_DetailsViewCtl ()<UICollectionViewDelegate,UICollectionViewDataSource>

 
// UICollectionView
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray * collectionItems;

// 底部数据
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *brandLab;
@property (weak, nonatomic) IBOutlet UILabel *projectLab;
@property (weak, nonatomic) IBOutlet UIView *downView;


 

@end

@implementation EP_Main_Cs_DetailsViewCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadBaseConfig];
    [self createCollectionView];

}

#pragma mark --- 基础配置

- (void)loadBaseConfig{
    
    self.navigationItem.title = @"案例";
    
    self.collectionItems = [NSMutableArray arrayWithCapacity:10];
   
    [AppUtils addShadowToView:self.downView withColor:[UIColor blackColor]];
    
    self.brandLab.text = [NSString stringWithFormat:@"品牌: %@",_dataModel.brandName];
    self.projectLab.text = [NSString stringWithFormat:@"项目: %@",_dataModel.projectName];
    self.timeLab.text =[AppUtils timestampChangeTime:[NSString stringWithFormat:@"%ld",(long)_dataModel.caseDate] WithFormat:@"yyyy/MM/dd"];
    self.nameLab.text = _dataModel.uploadName;
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:_dataModel.uploadHeadImage] placeholderImage:placeHolderImg];
     
}
 
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (void)createCollectionView{

    // UICollectionView
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    float theItemWidth = (APP_WIDTH - 20) * 0.5;
    flowLayout.itemSize = CGSizeMake(theItemWidth, theItemWidth);  // 设置每个Item大小
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical; // 横纵滚动方式
    flowLayout.minimumLineSpacing = 10; // 两个Item上下间距大小
    flowLayout.minimumInteritemSpacing = 10;  // 两个Item左右间距大小
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5); // 每一个 section 与周边的间距
     
    self.collectionView.frame = CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT);
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.alwaysBounceVertical = YES;  // 垂直
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass( [EP_Cell_CaseSqe_Details class] ) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:[EP_Cell_CaseSqe_Details cellID]];

    [self.collectionItems addObjectsFromArray:_dataModel.imageList];
    [self.collectionView reloadData];
  
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.collectionItems.count + 2; // 增加滚动区域
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    EP_Cell_CaseSqe_Details *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[EP_Cell_CaseSqe_Details cellID] forIndexPath:indexPath];
    
    if (indexPath.row <= self.collectionItems.count - 1) { // 增加滚动区域做出判断
 
        NSDictionary * dic = self.collectionItems[indexPath.row];  cell.dataDic = dic;
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row > self.collectionItems.count - 1) { return; }  // 增加滚动区域做出判断

        
//    NSUInteger index = indexPath.row;
//
//    if (index % 2 == 0) {
//
//        if (index + 1 == self.collectionItems.count) {  return; }
        
//        NSDictionary * dicL = self.collectionItems[index];
//        NSDictionary * dicR = self.collectionItems[index + 1 ];
//
//        YPCompareScanController *Vc = [[YPCompareScanController alloc] init];
//        Vc.standardImageUrl = dicL[@"imageUrl"];
//        Vc.outImageUrl =  dicR[@"imageUrl"];
//        UIViewController *current = [UIViewController app_getCurrentVC];
//        Vc.modalPresentationStyle = UIModalPresentationFullScreen;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [current presentViewController:Vc animated:YES completion:nil];
//        });
//    }else{

//        NSDictionary * dicL = self.collectionItems[index - 1];
//        NSDictionary * dicR = self.collectionItems[index];
        
//        YPCompareScanController *Vc = [[YPCompareScanController alloc] init];
//        Vc.standardImageUrl = dicL[@"imageUrl"];
//        Vc.outImageUrl =  dicR[@"imageUrl"];
//        UIViewController *current = [UIViewController app_getCurrentVC];
//        Vc.modalPresentationStyle = UIModalPresentationFullScreen;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [current presentViewController:Vc animated:YES completion:nil];
//        });
//    }
}


@end
