//
//  EPProjectModel.m
//  EPJH
//
//  Created by Hans on 2020/8/3.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPProjectModel.h"
 
@interface EPProjectModel()<NSCopying,NSMutableCopying>

@end

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

#pragma mark - NSCopying,NSMutableCopying

- (id)copyWithZone:(NSZone *)zone {
    
    EPProjectModel *newModel = [[EPProjectModel alloc] init];
    newModel.bindUserId = self.bindUserId;
    newModel.customerId = self.customerId;
    newModel.projectId = self.projectId;
    newModel.createTime = self.createTime;
    newModel.timeFormat = self.timeFormat;
    newModel.subCateId = self.subCateId;
    newModel.subCateName = self.subCateName;
    newModel.cateId = self.cateId;
    newModel.cateName = self.cateName;
    newModel.cameraArr = self.cameraArr;
    newModel.position = self.position;
    newModel.subSubCateId = self.subSubCateId;
    newModel.project = self.project;
    newModel.subSubSubCateId = self.subSubSubCateId;
    newModel.material = self.material;
    newModel.subSubSubSubCateId = self.subSubSubSubCateId;
    newModel.remark = self.remark;
    newModel.userInfo = self.userInfo;
    newModel.realName = self.realName;
    newModel.sex = self.sex;
    newModel.age = self.age;
    newModel.phone = self.phone;
    newModel.province = self.province;
    newModel.city = self.city;
    newModel.addr = self.addr;
    newModel.isSelected = self.isSelected;
    return newModel;
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    
    EPProjectModel *newModel = [[EPProjectModel allocWithZone:zone] init];
    newModel.bindUserId = self.bindUserId;
    newModel.customerId = self.customerId;
    newModel.projectId = self.projectId;
    newModel.createTime = self.createTime;
    newModel.timeFormat = self.timeFormat;
    newModel.subCateId = self.subCateId;
    newModel.subCateName = self.subCateName;
    newModel.cateId = self.cateId;
    newModel.cateName = self.cateName;
    newModel.cameraArr = [self.cameraArr mutableCopy];
    newModel.position = self.position;
    newModel.subSubCateId = self.subSubCateId;
    newModel.position = self.position;
    newModel.subSubCateId = self.subSubCateId;
    newModel.project = self.project;
    newModel.subSubSubCateId = self.subSubSubCateId;
    newModel.material = self.material;
    newModel.subSubSubSubCateId = self.subSubSubSubCateId;
    newModel.remark = self.remark;
    newModel.userInfo = self.userInfo;
    newModel.realName = self.realName;
    newModel.sex = self.sex;
    newModel.age = self.age;
    newModel.phone = self.phone;
    newModel.province = self.province;
    newModel.city = self.city;
    newModel.addr = self.addr;
    newModel.isSelected = self.isSelected;
    return newModel;
}


@end
