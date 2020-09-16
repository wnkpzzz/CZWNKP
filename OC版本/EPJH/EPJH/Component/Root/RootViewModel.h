//
//  RootViewModel.h
//  EPJH
//
//  Created by Hans on 2020/7/16.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


// 定义返回Block格式
typedef void(^CallbackSimpleCompletion)(BOOL isSuccess);
typedef void(^CallbackAllCompletion)(BOOL isSuccess, id response, NSString *msgStr);

@interface RootViewModel : NSObject



@end

NS_ASSUME_NONNULL_END
