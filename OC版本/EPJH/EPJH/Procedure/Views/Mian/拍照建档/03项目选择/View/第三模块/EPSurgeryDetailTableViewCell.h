//
//  EPSurgeryDetailTableViewCell.h
//  EPJH
//
//  Created by Hans on 2020/8/25.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EPSurgeryDetailTableViewCell : RootTableViewCell

/** 时间节点 */
@property (nonatomic,strong) UILabel * timeLabel;
/** 部位 */
@property (nonatomic,strong) UILabel * partLabel;
/** 项目 */
@property (nonatomic,strong) UILabel * surgetyTypeLabel;
/** 材料 */
@property (nonatomic,strong) UILabel * materialsLabel;
/** 备注 */
@property (nonatomic,strong) UILabel * remarkLabel;
/** 备注输入框 */
@property (nonatomic,strong) UITextField * remarkTextView;
/** 备注占位字 */
@property (nonatomic,strong) UILabel * remarkPlaceHolder;
/** 是否显示备注 */
@property (nonatomic,assign) BOOL showRemark;
/** 输入回调 */
@property (nonatomic ,copy) void(^textChangeBlock)(NSString * changeText);

@end

NS_ASSUME_NONNULL_END
