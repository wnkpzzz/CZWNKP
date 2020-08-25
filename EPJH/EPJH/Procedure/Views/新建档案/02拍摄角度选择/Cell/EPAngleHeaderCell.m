//
//  EPAngleHeaderCell.m
//  EPJH
//
//  Created by Hans on 2020/8/25.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPAngleHeaderCell.h"
 
@interface EPAngleHeaderCell()

@property (weak, nonatomic) IBOutlet UIButton *shuQianBtn;
@property (weak, nonatomic) IBOutlet UIButton *shuHouBtn;
@property (weak, nonatomic) IBOutlet UIButton *fuZhenBtn;

@property (nonatomic) UIColor * kShuQianColor;
@property (nonatomic) UIColor * kShuHouColor;
@property (nonatomic) UIColor * kFuZhenColor;

 
@end

@implementation EPAngleHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self loadBaseConfig];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadBaseConfig{

    self.kShuQianColor = RGB(77, 215, 217);   // 术前颜色
    self.kShuHouColor = RGB(119, 218, 164);   // 术后颜色
    self.kFuZhenColor = RGB(247, 176, 95);    // 复诊颜色
    
    [self.shuQianBtn setTitleColor:self.kShuQianColor forState:UIControlStateNormal];
    [self.shuQianBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    self.shuQianBtn.layer.borderColor = self.kShuQianColor.CGColor;
 
    self.shuHouBtn.layer.borderColor = self.kShuHouColor.CGColor;
    [self.shuHouBtn setTitleColor:self.kShuHouColor forState:UIControlStateNormal];
    [self.shuHouBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    [self.fuZhenBtn setTitleColor:self.kFuZhenColor forState:UIControlStateNormal];
    [self.fuZhenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    self.fuZhenBtn.layer.borderColor = self.kFuZhenColor.CGColor;

    // 默认选中
    self.shuQianBtn.selected = YES;
    [self.shuQianBtn setBackgroundColor:self.kShuQianColor];
}
 
- (IBAction)btnClickAction:(UIButton *)button {

    if (button.selected) { return; }

    button.selected = YES;
    NSInteger selectIndex = 0;

    if (button.tag == 0) {

        selectIndex = 0;
        [button setBackgroundColor:self.kShuQianColor];
        self.shuHouBtn.selected = NO;
        self.fuZhenBtn.selected = NO;
        [self.shuHouBtn setBackgroundColor:[UIColor whiteColor]];
        [self.fuZhenBtn setBackgroundColor:[UIColor whiteColor]];


    }else if (button.tag == 1) {

        selectIndex = 1;
        [button setBackgroundColor:self.kShuHouColor];
        self.shuQianBtn.selected = NO;
        self.fuZhenBtn.selected = NO;
        [self.shuQianBtn setBackgroundColor:[UIColor whiteColor]];
        [self.fuZhenBtn setBackgroundColor:[UIColor whiteColor]];

    }else if (button.tag == 2) {

        selectIndex = 2;
        [button setBackgroundColor:self.kFuZhenColor];
        self.shuQianBtn.selected = NO;
        self.shuHouBtn.selected = NO;
        [self.shuQianBtn setBackgroundColor:[UIColor whiteColor]];
        [self.shuHouBtn setBackgroundColor:[UIColor whiteColor]];

    }

    if (self.clickBlock) {  self.clickBlock(selectIndex);}

}

@end
