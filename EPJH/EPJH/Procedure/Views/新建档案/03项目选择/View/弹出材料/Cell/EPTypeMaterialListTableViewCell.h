//
//  EPTypeMaterialListTableViewCell.h
//  EPJH
//
//  Created by Hans on 2020/8/26.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPTypeListClassifyModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EPTypeMaterialListTableViewCell : RootTableViewCell

@property (nonatomic,strong) EPTypeListClassifyModel * dataModel;

@end

NS_ASSUME_NONNULL_END
