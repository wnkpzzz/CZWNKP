//
//  EPSurgeryDetailTableViewCell.m
//  EPJH
//
//  Created by Hans on 2020/8/25.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPSurgeryDetailTableViewCell.h"

@interface EPSurgeryDetailTableViewCell ()<UITextFieldDelegate>

@end

@implementation EPSurgeryDetailTableViewCell

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
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    [self.partLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).offset(15);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    [self.surgetyTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.partLabel.mas_bottom).offset(15);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        
    }];
    
    [self.materialsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.surgetyTypeLabel.mas_bottom).offset(15);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.materialsLabel.mas_bottom).offset(15);
        make.left.equalTo(self.contentView).offset(15);
        make.width.equalTo(@40);
    }];
    
    [self.remarkTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.materialsLabel.mas_bottom).offset(2);
        make.left.equalTo(self.remarkLabel.mas_right);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.equalTo(@40);
    }];
    
    
}

- (void)setShowRemark:(BOOL)showRemark{
    _showRemark = showRemark;
    self.remarkLabel.hidden = !showRemark;
    self.remarkTextView.hidden = !showRemark;
    self.remarkPlaceHolder.hidden = !showRemark;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.textChangeBlock) {
        self.textChangeBlock(textField.text);
    }
}

#pragma mark - 懒加载

//时间节点
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = @"术前";
        _timeLabel.textColor = [UIColor blackColor];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.numberOfLines = 1;
        [self.contentView addSubview:_timeLabel];
        
    }
    return _timeLabel;
}

//部位
- (UILabel *)partLabel{
    if (!_partLabel) {
        _partLabel = [[UILabel alloc]init];
        _partLabel.text = @"部位:";
        _partLabel.textColor =[UIColor blackColor];
        _partLabel.font = [UIFont systemFontOfSize:14];
        _partLabel.numberOfLines = 1;
        [self.contentView addSubview:_partLabel];
    }
    return _partLabel;
}

//项目
- (UILabel *)surgetyTypeLabel{
    if (!_surgetyTypeLabel) {
        _surgetyTypeLabel = [[UILabel alloc]init];
        _surgetyTypeLabel.text = @"项目:";
        _surgetyTypeLabel.textColor = [UIColor blackColor];
        _surgetyTypeLabel.font = [UIFont systemFontOfSize:14];
        _surgetyTypeLabel.numberOfLines = 1;
        [self.contentView addSubview:_surgetyTypeLabel];
    }
    return _surgetyTypeLabel;
}

//材料
- (UILabel *)materialsLabel{
    if (!_materialsLabel) {
        _materialsLabel = [[UILabel alloc]init];
        _materialsLabel.text = @"材料:";
        _materialsLabel.textColor = [UIColor blackColor];
        _materialsLabel.font = [UIFont systemFontOfSize:14];
        _materialsLabel.numberOfLines = 1;
        [self.contentView addSubview:_materialsLabel];
    }
    return _materialsLabel;
}

//备注
- (UILabel *)remarkLabel{
    if (!_remarkLabel) {
        _remarkLabel = [[UILabel alloc]init];
        _remarkLabel.text = @"备注:";
        _remarkLabel.textColor = [UIColor blackColor];
        _remarkLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_remarkLabel];
    }
    return _remarkLabel;
}

//备注输入框
- (UITextField *)remarkTextView{
    if (!_remarkTextView) {
        _remarkTextView = [[UITextField alloc]init];
        _remarkTextView.font = [UIFont systemFontOfSize:14];
        _remarkTextView.delegate = self;
        _remarkTextView.placeholder = @"可输入备注信息";
        _remarkTextView.textColor = [UIColor blackColor];
        [self.contentView addSubview:_remarkTextView];
 
    }
    return _remarkTextView;
}

@end
