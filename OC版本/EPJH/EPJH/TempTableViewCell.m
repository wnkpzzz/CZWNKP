//
//  TempTableViewCell.m
//  EPJH
//
//  Created by Hans on 2020/7/27.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "TempTableViewCell.h"

@implementation TempTableViewCell

- (void)setDataDic:(NSDictionary *)dataDic{
    
    self.nameLab.text  = dataDic[@"name"];
    self.titleLab.text = dataDic[@"title"];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
