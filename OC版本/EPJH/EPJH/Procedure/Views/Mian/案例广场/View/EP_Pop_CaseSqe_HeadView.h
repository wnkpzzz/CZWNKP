//
//  EP_Pop_CaseSqe_HeadView.h
//  EPJH
//
//  Created by Hans on 2020/11/5.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EP_Pop_CaseSqe_HeadView : RootView

@property (nonatomic,strong) NSArray * btnArray;
@property (weak, nonatomic) IBOutlet UIButton *caseBtn;
@property (weak, nonatomic) IBOutlet UIButton *projectBtn;
@property (weak, nonatomic) IBOutlet UIButton *productBtn;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;

@property (weak, nonatomic) IBOutlet UIImageView *projectImg;
@property (weak, nonatomic) IBOutlet UIImageView *productImg;
@property (weak, nonatomic) IBOutlet UIImageView *collectImg;

@property (weak, nonatomic) IBOutlet UIView *lineView1;
@property (weak, nonatomic) IBOutlet UIView *lineView2;
@property (weak, nonatomic) IBOutlet UIView *lineView3;
@property (weak, nonatomic) IBOutlet UIView *lineView4;

@end

NS_ASSUME_NONNULL_END



