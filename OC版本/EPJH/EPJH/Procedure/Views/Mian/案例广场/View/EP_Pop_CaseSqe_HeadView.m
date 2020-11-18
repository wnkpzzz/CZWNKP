//
//  EP_Pop_CaseSqe_HeadView.m
//  EPJH
//
//  Created by Hans on 2020/11/5.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EP_Pop_CaseSqe_HeadView.h"

@interface EP_Pop_CaseSqe_HeadView ()

@property (nonatomic,strong) NSArray * btnArray;

@property (weak, nonatomic) IBOutlet UIButton *caseBtn;
@property (weak, nonatomic) IBOutlet UIView *lineView1;

@property (weak, nonatomic) IBOutlet UIButton *projectBtn;
@property (weak, nonatomic) IBOutlet UIImageView *projectImg;
@property (weak, nonatomic) IBOutlet UIView *lineView2;

@property (weak, nonatomic) IBOutlet UIButton *productBtn;
@property (weak, nonatomic) IBOutlet UIImageView *productImg;
@property (weak, nonatomic) IBOutlet UIView *lineView3;

@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIImageView *collectImg;
@property (weak, nonatomic) IBOutlet UIView *lineView4;

@end

@implementation EP_Pop_CaseSqe_HeadView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self loadBaseConfig];
}

- (void)loadBaseConfig {
    
 
}

// 点击事件
- (IBAction)clickAction:(UIButton *)sender {
    
    // 精选案例
    if (sender == self.caseBtn) {
   
        self.lineView1.backgroundColor = kMainBlueColor;
        self.lineView2.backgroundColor = kWhiteColor;
        self.lineView3.backgroundColor = kWhiteColor;
        self.lineView4.backgroundColor = kWhiteColor;

        [self changeBtnsStatusAction:self.caseBtn];
        
    }
    // 项目
    if (sender == self.projectBtn) {
       
  
        self.lineView1.backgroundColor = kWhiteColor;
        self.lineView2.backgroundColor = kMainBlueColor;
        self.lineView3.backgroundColor = kWhiteColor;
        self.lineView4.backgroundColor = kWhiteColor;
        

        
        [self changeBtnsStatusAction:self.projectBtn];
       
    }
    // 产品
    if (sender == self.productBtn) {
     

        self.lineView1.backgroundColor = kWhiteColor;
        self.lineView2.backgroundColor = kWhiteColor;
        self.lineView3.backgroundColor = kMainBlueColor;
        self.lineView4.backgroundColor = kWhiteColor;
        

        [self changeBtnsStatusAction:self.productBtn];
    }
    // 收藏
    if (sender == self.collectBtn) {
        
      
        self.lineView1.backgroundColor = kWhiteColor;
        self.lineView2.backgroundColor = kWhiteColor;
        self.lineView3.backgroundColor = kWhiteColor;
        self.lineView4.backgroundColor = kMainBlueColor;
        
        [self changeBtnsStatusAction:self.collectBtn];
    }
     

}

// 点击Btn状态
- (void)changeBtnsStatusAction:(UIButton *)btn{
    
    for (UIButton * tempBtn in self.btnArray) {
        
        UIColor * btnColor = [UIColor new];
        
        if (btn == tempBtn) { btnColor = kMainBlueColor; }else{  btnColor = kMainTextColor; }
        
        [tempBtn setTitleColor:btnColor forState:UIControlStateNormal];
    }
    
    if (btn == self.projectBtn) {
        [self.projectImg setImage:[UIImage imageNamed:@"case_searchbar_sea_1"]];
    }else{
        [self.projectImg setImage:[UIImage imageNamed:@"case_searchbar_sea_0"]];
    }
    
    if (btn == self.productBtn) {
        [self.productImg setImage:[UIImage imageNamed:@"case_searchbar_sea_1"]];
    }else{
        [self.productImg setImage:[UIImage imageNamed:@"case_searchbar_sea_0"]];
    }
    
    if (btn == self.collectBtn) {
        [self.collectImg setImage:[UIImage imageNamed:@"case_searchbar_col_1"]];
    }else{
        [self.collectImg setImage:[UIImage imageNamed:@"case_searchbar_col_0"]];
    }
    
}
 

@end
