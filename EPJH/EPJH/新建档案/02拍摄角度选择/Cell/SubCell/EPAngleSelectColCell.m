//
//  EPAngleSelectColCell.m
//  EPJH
//
//  Created by Hans on 2020/8/13.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPAngleSelectColCell.h"

@implementation EPAngleSelectColCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self loadBaseConfig];
    }
    return self;
}

- (void)loadBaseConfig{
    
    self.mainLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.mainLabel];
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    self.mainLabel.textAlignment = NSTextAlignmentCenter;
    self.mainLabel.font = [UIFont systemFontOfSize:14];
    self.mainLabel.layer.cornerRadius = kWidth(10);
    self.mainLabel.layer.masksToBounds = YES;
}

@end
