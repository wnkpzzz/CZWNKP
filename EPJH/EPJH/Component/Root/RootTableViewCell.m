//
//  RootTableViewCell.m
//  EPJH
//
//  Created by Hans on 2020/7/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "RootTableViewCell.h"

@implementation RootTableViewCell

+(NSString *)cellID{
    
    NSString * const ID = [NSString stringWithUTF8String:object_getClassName(self)];
    
    return ID;
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
