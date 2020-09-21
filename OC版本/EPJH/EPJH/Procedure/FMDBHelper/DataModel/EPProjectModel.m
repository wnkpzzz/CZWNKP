//
//  EPProjectModel.m
//  EPJH
//
//  Created by Hans on 2020/8/3.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPProjectModel.h"
 
@implementation EPProjectModel
 
#pragma mark - YHFMDB

// 定义主键
+ (NSString *)yh_primaryKey{
    return @"projectId";
}

+ (NSDictionary *)yh_replacedKeyFromPropertyName{
    return @{@"projectId":YHDB_PrimaryKey};
}

/**
 *  将属性是一个模型对象:字典再根据属性名获取value作为字段名
 *
 */
+ (NSDictionary *)yh_replacedKeyFromDictionaryWhenPropertyIsObject{
    return @{
             @"userInfo":[NSString stringWithFormat:@"userInfo%@",YHDB_AppendingID]
             };
}

/**
 *  key : 模型对象的名字
 *  通过key获取类名
 */
+ (NSDictionary *)yh_getClassForKeyIsObject{
    return @{
             @"userInfo":[EPUserInfoModel class]
             };
}

/**
 *  将属性为数组
 *
 */
+ (NSDictionary *)yh_propertyIsInstanceOfArray{
    return @{
             @"cameraArr":[EPImageModel class]
             };
}





@end
