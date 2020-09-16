//
//  KCountdownButton.m
//  EPJH
//
//  Created by Hans on 2020/7/15.
//  Copyright © 2020 hans3d. All rights reserved.
//


#import "KCountdownButton.h"

@interface KCountdownButton ()

// 定时器
@property (nonatomic, weak) NSTimer *timer;
// 倒计时
@property (nonatomic,assign) NSInteger timeDesCount;

@end


@implementation KCountdownButton

- (void)awakeFromNib{
    
    [super awakeFromNib];
    self.timeDesCount = 60;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.timeDesCount = 60;
    }
    
    return self;
}

- (void)setDelegate:(id<KCountdownButtonDelegate>)delegate{
    
    [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    _delegate = delegate;
}

- (void)setDelegateWithParamater:(id<KCountdownButtonWithParameterDelegate>)delegateWithParamater{
   
    [self addTarget:self action:@selector(clickWithParameter:) forControlEvents:UIControlEventTouchUpInside];
    _delegateWithParamater = delegateWithParamater;
}

- (void)startCountdown{
  
    [self.timer setFireDate:[NSDate distantPast]];//开定时器
    self.enabled = NO;
}

- (void)click{
    
    if ([self.delegate respondsToSelector:@selector(countdownButtonClick)]) {
        [self.delegate countdownButtonClick];
    }
}

- (void)clickWithParameter:(id)parameter{
    
    if ([self.delegateWithParamater respondsToSelector:@selector(countdownButtonClickWithParameter:)]) {
        [self.delegateWithParamater countdownButtonClickWithParameter:parameter];
        
    }
}

#pragma mark - 定时器计时

- (void)timerTick:(NSTimer *)timer{
    
    [self setTitle:[NSString stringWithFormat:@"%ld秒后重发",(long)_timeDesCount] forState:UIControlStateNormal];
    _timeDesCount--;
    
    if (_timeDesCount == 0) {
        self.enabled = YES;
        _timeDesCount = 60;
        [self.timer setFireDate:[NSDate distantFuture]];//暂停
        [self setTitle:@"再次发送" forState:UIControlStateNormal];
    }
}

- (NSTimer *)timer{
    
    if (!_timer) {
        //开始定时
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        
    }
    return _timer;
}

- (void)dealloc{
    
    [self.timer invalidate];
    self.timer = nil;
}

@end
