//
//  KCountdownButton.h
//  EPJH
//
//  Created by Hans on 2020/7/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>
 
@protocol KCountdownButtonDelegate <NSObject>
@required
- (void)countdownButtonClick;//点击代理方法
@end

@protocol KCountdownButtonWithParameterDelegate <NSObject>
- (void)countdownButtonClickWithParameter:(id)parameter;
@end

@interface KCountdownButton : UIButton

//开始倒计时
-(void)startCountdown;

/** 代理 */
@property (nonatomic,weak)id<KCountdownButtonDelegate> delegate;

/** 含参数代理 */
@property (nonatomic,weak)id<KCountdownButtonWithParameterDelegate> delegateWithParamater;
 
@end

