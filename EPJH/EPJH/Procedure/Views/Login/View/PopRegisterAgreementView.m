//
//  PopRegisterAgreementView.m
//  EPJH
//
//  Created by Hans on 2020/7/16.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "PopRegisterAgreementView.h"

@interface PopRegisterAgreementView ()

/** 背景蒙版 */
@property (weak, nonatomic) IBOutlet UIView * maskBgView;

/** Block数据返回 */
@property (copy, nonatomic) RegisterAgreementBackBlock completeBlock;

@end

@implementation PopRegisterAgreementView
 
+ (void)showPopViewWithComplete:(RegisterAgreementBackBlock)complete{
    
    PopRegisterAgreementView *popView = [PopRegisterAgreementView initWithCustomView];
    popView.completeBlock = complete;
}

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
 
- (IBAction)btnClickAction:(UIButton *)sender {
    
    [self dismissPopView];
    
    if (sender.tag == 0) {  self.completeBlock(YES);}
    else if (sender.tag == 1) {  self.completeBlock(NO);}
    
    
}

@end
