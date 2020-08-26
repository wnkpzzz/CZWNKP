//
//  EPCameraBodyPartCollectionViewCell.m
//  EPJH
//
//  Created by Hans on 2020/8/26.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPCameraBodyPartCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface EPCameraBodyPartCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

@end

@implementation EPCameraBodyPartCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItemSelected:(BOOL)itemSelected{
    
    _itemSelected = itemSelected;

    NSString * imgStr = itemSelected ? _dataModel.imageChooseUrl : _dataModel.imageUrl ;
    
    self.picImageView.image = [UIImage imageNamed:imgStr];
     
}

- (void)setDataModel:(EPTypeListClassifyModel *)dataModel{
    
    _dataModel = dataModel; 
    self.titleLab.text = dataModel.name;
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.imageUrl]];
}

@end

