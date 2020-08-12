//
//  EPAngleHeaderCell.m
//  EPJH
//
//  Created by Hans on 2020/7/27.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPAngleHeaderCell.h"

#define kShuQianColor               RGB(77, 215, 217)   // 术前颜色
#define kShuHouColor                RGB(119, 218, 164)  // 术后颜色
#define kFuZhenColor                RGB(247, 176, 95)   // 复诊颜色

@interface EPAngleHeaderCell()
@property (nonatomic, strong) UIButton *shuQianBtn;
@property (nonatomic, strong) UIButton *shuHouBtn;
@property (nonatomic, strong) UIButton *fuZhenBtn;
@end

@implementation EPAngleHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadBaseConfig];
    }
    return self;
}

- (void)loadBaseConfig{
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"时间节点";
    label.font = [UIFont systemFontOfSize:16] ;
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(21);
        make.size.mas_equalTo(CGSizeMake(kWidth(80), kWidth(34)));
    }];
     
    self.shuHouBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shuHouBtn setTitle:@"术后" forState:UIControlStateNormal];
    [self.shuHouBtn setTitleColor:kShuHouColor forState:UIControlStateNormal];
    [self.shuHouBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    self.shuHouBtn.layer.cornerRadius = kWidth(16);
    self.shuHouBtn.layer.borderWidth = 1;
    self.shuHouBtn.layer.borderColor = kShuHouColor.CGColor;
    self.shuHouBtn.layer.masksToBounds = YES;
    self.shuHouBtn.tag = 1;
    [self.contentView addSubview:self.shuHouBtn];
    [self.shuHouBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(kWidth(7));
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(kWidth(80), kWidth(32)));
        make.bottom.equalTo(self.contentView).offset(-kWidth(16));
    }];
    [self.shuHouBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
     
    self.shuQianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shuQianBtn setTitle:@"术前" forState:UIControlStateNormal];
    [self.shuQianBtn setTitleColor:kShuQianColor forState:UIControlStateNormal];
    [self.shuQianBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    self.shuQianBtn.layer.cornerRadius = kWidth(16);
    self.shuQianBtn.layer.borderWidth = 1;
    self.shuQianBtn.layer.borderColor = kShuQianColor.CGColor;
    self.shuQianBtn.layer.masksToBounds = YES;
    self.shuQianBtn.tag = 0;
    [self.contentView addSubview:self.shuQianBtn];
    [self.shuQianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shuHouBtn);
        make.left.equalTo(self.contentView).offset(kWidth(21));
        make.size.mas_equalTo(CGSizeMake(kWidth(80), kWidth(32)));
    }];
    [self.shuQianBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
     
    self.fuZhenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.fuZhenBtn setTitle:@"复诊" forState:UIControlStateNormal];
    [self.fuZhenBtn setTitleColor:kFuZhenColor forState:UIControlStateNormal];
    [self.fuZhenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    self.fuZhenBtn.layer.cornerRadius = kWidth(16);
    self.fuZhenBtn.layer.borderWidth = 1;
    self.fuZhenBtn.layer.borderColor = kFuZhenColor.CGColor;
    self.fuZhenBtn.layer.masksToBounds = YES;
    self.fuZhenBtn.tag = 2;
    [self.contentView addSubview:self.fuZhenBtn];
    [self.fuZhenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shuHouBtn);
        make.right.equalTo(self.contentView).offset(-kWidth(21));
        make.size.mas_equalTo(CGSizeMake(kWidth(80), kWidth(32)));
    }];
    [self.fuZhenBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
 
    self.shuQianBtn.selected = YES;// 默认选中
    [self.shuQianBtn setBackgroundColor:kShuQianColor];
}

- (void)clickAction:(UIButton *)btn{
    
    if (btn.selected) { return; }
         
    btn.selected = YES;
    NSInteger selectIndex = 0;
    if (btn.tag == 0) {
        selectIndex = 0;
        [btn setBackgroundColor:kShuQianColor];
        self.shuHouBtn.selected = NO;
        self.fuZhenBtn.selected = NO;
        [self.shuHouBtn setBackgroundColor:[UIColor whiteColor]];
        [self.fuZhenBtn setBackgroundColor:[UIColor whiteColor]];
    }else if(btn.tag == 1){
        selectIndex = 1;
        [btn setBackgroundColor:kShuHouColor];
        self.shuQianBtn.selected = NO;
        self.fuZhenBtn.selected = NO;
        [self.shuQianBtn setBackgroundColor:[UIColor whiteColor]];
        [self.fuZhenBtn setBackgroundColor:[UIColor whiteColor]];
    }else if(btn.tag == 2){
        selectIndex = 2;
        [btn setBackgroundColor:kFuZhenColor];
        self.shuQianBtn.selected = NO;
        self.shuHouBtn.selected = NO;
        [self.shuQianBtn setBackgroundColor:[UIColor whiteColor]];
        [self.shuHouBtn setBackgroundColor:[UIColor whiteColor]];
    }
    if (self.clickBlock) {
        self.clickBlock(selectIndex);
    }
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
