//
//  EPTypeMaterialListView.h
//  EPJH
//
//  Created by Hans on 2020/8/26.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^typeMaterialListResultBlock)(NSArray * listArray);

@interface EPTypeMaterialListView : RootView

//选择展示回调
+ (void)showTypeMaterialListWithDataArr:(NSArray *)dataArr resultBlock:(typeMaterialListResultBlock)complete;

@end

NS_ASSUME_NONNULL_END

