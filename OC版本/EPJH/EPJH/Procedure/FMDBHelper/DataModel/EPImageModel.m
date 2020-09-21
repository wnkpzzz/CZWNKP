//
//  EPImageModel.m
//  EPJH
//
//  Created by Hans on 2020/8/3.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPImageModel.h"
 
@implementation EPImageModel

#pragma mark - YHFMDB

// 定义主键
+ (NSString *)yh_primaryKey{
    return @"imageId";
}

+ (NSDictionary *)yh_replacedKeyFromPropertyName{
    return @{@"imageId":YHDB_PrimaryKey};
}

 
@end
