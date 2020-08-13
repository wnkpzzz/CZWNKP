//
//  EPPopCameraViewCtl.h
//  EPJH
//
//  Created by Hans on 2020/8/12.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EPPopCameraViewCtl : UIViewController

// 上半部分
@property(nonatomic,strong) UIImage *tempImage;          // 参照虚线图 

// 下半部分
@property(nonatomic,strong) UIImage *standrandImage;    // 标准照图片
@property(nonatomic,copy) NSString *standrandImageUrl;  // 标准照图片地址

/** 数据入口 */
- (void)reloadDataWithModel:(EPProjectModel *)model photoArr:(NSArray *)photoArr nowIndex:(NSInteger)nowIndex;

/** Block数据回调,proModel:数据源 photoArr:图片源（有占位数据） */
@property (nonatomic,copy)void(^saveClickBlock)(EPProjectModel *proModel, NSArray *photoArr);

@end

NS_ASSUME_NONNULL_END
