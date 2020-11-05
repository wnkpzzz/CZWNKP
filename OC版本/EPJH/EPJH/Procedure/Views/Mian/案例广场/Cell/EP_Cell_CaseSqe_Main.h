//
//  EP_Cell_CaseSqe_Main.h
//  EPJH
//
//  Created by Hans on 2020/11/5.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EP_Model_CaseSqeList.h"

NS_ASSUME_NONNULL_BEGIN

@interface EP_Cell_CaseSqe_Main : RootTableViewCell

// Model
@property (nonatomic,strong) EP_Model_CaseSqeList *dataModel;

// Block点击事件
@property (copy,nonatomic) void (^collectClickBlock)(UITableViewCell * cell);   // 收藏
@property (copy,nonatomic) void (^popClickpBlock)(UITableViewCell * cell);      // 跳转


@end

NS_ASSUME_NONNULL_END
