//
//  EPUserInfoModel.m
//  EPJH
//
//  Created by Hans on 2020/8/3.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPUserInfoModel.h"


@implementation EPUserInfoModel

#pragma mark - YHFMDB

// 定义主键
+ (NSString *)yh_primaryKey{
    return @"uid";
}

+ (NSDictionary *)yh_replacedKeyFromPropertyName{
    return @{@"uid":YHDB_PrimaryKey};
}


@end
