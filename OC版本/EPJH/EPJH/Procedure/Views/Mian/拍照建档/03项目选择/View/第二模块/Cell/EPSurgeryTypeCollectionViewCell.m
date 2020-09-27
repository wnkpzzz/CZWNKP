//
//  EPSurgeryTypeCollectionViewCell.m
//  EPJH
//
//  Created by Hans on 2020/8/26.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPSurgeryTypeCollectionViewCell.h" 
#import "UIImageView+WebCache.h"

 
@interface EPSurgeryTypeCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

@end

@implementation EPSurgeryTypeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 4;
 
}

- (void)setItemSelected:(BOOL)itemSelected{
    
    _itemSelected = itemSelected;
 
     if (itemSelected) {
         [self.picImageView setImage:kImage(@"icon_pro_surgery_type")];
              self.backgroundColor = RGB(234, 234, 234);
     }else{
         [self.picImageView setImage:nil];
         self.backgroundColor = RGB(244, 248, 254);
     }
}

- (void)setDataModel:(EPTypeListClassifyModel *)dataModel{
    
    _dataModel = dataModel;
    self.titleLab.text = dataModel.name;
}

@end

