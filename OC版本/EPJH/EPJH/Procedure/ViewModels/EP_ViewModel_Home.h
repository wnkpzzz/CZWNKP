//
//  EP_ViewModel_Home.h
//  EPJH
//
//  Created by Hans on 2020/11/5.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EP_ViewModel_Home : RootViewModel

/** 案例广场 */
- (void)requestCaseSquareWithBrand:(NSString *)brandId
                           Project:(NSString *)proId
                        Completion:(CallbackAllCompletion)handler;


@end

NS_ASSUME_NONNULL_END
