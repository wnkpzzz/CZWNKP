//
//  EPTypeMaterialListTableViewCell.m
//  EPJH
//
//  Created by Hans on 2020/8/26.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPTypeMaterialListTableViewCell.h"


@interface EPTypeMaterialListTableViewCell ()
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIButton * selectBtn;
@end

@implementation EPTypeMaterialListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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

- (void)loadBaseConfig{
    
    //标题
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.centerY.equalTo(self.contentView);
    }];
    
    //选择图标
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-20);
        make.centerY.equalTo(self.contentView);
        make.width.height.equalTo(@27);
    }];
    
}
  
- (void)setDataModel:(EPTypeListClassifyModel *)dataModel{
    
    _dataModel = dataModel;
    self.titleLabel.text = dataModel.name;
    self.selectBtn.selected = dataModel.isSelected;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
 
- (UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:kImage(@"icon_pro_material_out") forState:UIControlStateNormal];
        [_selectBtn setImage:kImage(@"icon_pro_material_on") forState:UIControlStateSelected];
        _selectBtn.userInteractionEnabled = NO;
        [self.contentView addSubview:_selectBtn];
    }
    return _selectBtn;
}

@end
