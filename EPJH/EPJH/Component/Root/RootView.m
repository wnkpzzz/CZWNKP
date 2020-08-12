//
//  RootView.m
//  EPJH
//
//  Created by Hans on 2020/7/16.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "RootView.h"

@implementation RootView

/** 初始化XIB */
+ (instancetype)initWithCustomView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

/** 初始化 */
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

/** 显示弹框视图 */
- (void)showPopView{
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}

/** 隐藏弹框视图 */
- (void)dismissPopView{
    [self removeFromSuperview];
}

@end
