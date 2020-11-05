//
//  EP_Pop_CaseSqe_SelectView.m
//  EPJH
//
//  Created by Hans on 2020/11/5.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EP_Pop_CaseSqe_SelectView.h"


@interface EP_Pop_CaseSqe_SelectView ()

/** 背景蒙版 */
@property (weak, nonatomic) IBOutlet UIView * maskBgView;

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint; // 控制视图左右位移

 
@end

@implementation EP_Pop_CaseSqe_SelectView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self loadBaseConfig];
}

- (void)loadBaseConfig {
    
    self.maskBgView.backgroundColor = RGB(0, 0, 0);
    self.maskBgView.alpha = 0.3;
    
    self.frame = CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT);
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];
}

@end
