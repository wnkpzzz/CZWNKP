//
//  EPCitySelectViewCtl.h
//  EPJH
//
//  Created by Hans on 2020/9/28.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, EPCitySelectType) {
    EPCitySelectTypeProvince = 0,
    EPCitySelectTypeCity,
};

NS_ASSUME_NONNULL_BEGIN

@interface EPCitySelectViewCtl : RootViewController

- (instancetype)initWithCitySelectType:(EPCitySelectType)type parentId:(NSString *)parentId titleName:(NSString *)titleName;

@property (nonatomic, copy) void(^addressCompleted)(NSString *province, NSString *city);




@end

NS_ASSUME_NONNULL_END
