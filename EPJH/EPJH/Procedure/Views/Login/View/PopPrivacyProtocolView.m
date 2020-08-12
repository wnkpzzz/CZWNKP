//
//  PopPrivacyProtocolView.m
//  EPJH
//
//  Created by Hans on 2020/3/2.
//  Copyright © 2020 Hans3D. All rights reserved.
//

#import "PopPrivacyProtocolView.h"

@interface PopPrivacyProtocolView ()

/** 背景蒙版 */
@property (weak, nonatomic) IBOutlet UIView * maskBgView;

/** Block数据返回 */
@property (copy, nonatomic) PrivacyProtocolBackBlock completeBlock;

@end

@implementation PopPrivacyProtocolView
 
+ (void)showPopViewWithComplete:(PrivacyProtocolBackBlock)complete{

    PopPrivacyProtocolView *popView = [PopPrivacyProtocolView initWithCustomView];
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

    if (sender.tag == 0)      {  self.completeBlock(PopPrivacyProtocolAgreement);}
    else if (sender.tag == 1) {  self.completeBlock(PopPrivacyProtocolPolicy);}
    else if (sender.tag == 2) { [NSUSERDEFAULTS setObject:@"YES" forKey:kCheckInstallFlag];}
    else if (sender.tag == 3) { [self exitApplication];}
    
}
 
- (void)exitApplication {
    
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
    [UIView animateWithDuration:0.2f animations:^{  window.alpha = 0; } completion:^(BOOL finished) {exit(0); }];
    
}

@end
