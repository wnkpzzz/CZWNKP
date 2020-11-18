//
//  EP_Pop_CaseSqe_HeadView.h
//  EPJH
//
//  Created by Hans on 2020/11/5.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>


@class EP_Pop_CaseSqe_HeadView;

typedef NS_ENUM(NSInteger, EPCaseSqeHeadStatus) {
    EPCaseSqeHeadStatusChoice                = 0,        // 精选案例
    EPCaseSqeHeadStatusProject               = 1,        // 项目
    EPCaseSqeHeadStatusProduct               = 2,        // 产品
    EPCaseSqeHeadStatusCollect               = 3,        // 收藏

};

@protocol EP_Pop_CaseSqe_HeadViewDelegate <NSObject>


- (void)imageToolView:(EP_Pop_CaseSqe_HeadView *)headView didStyleStatusChanged:(EPCaseSqeHeadStatus )styleStatus;

@end

NS_ASSUME_NONNULL_BEGIN

@interface EP_Pop_CaseSqe_HeadView : RootView

@end

NS_ASSUME_NONNULL_END



