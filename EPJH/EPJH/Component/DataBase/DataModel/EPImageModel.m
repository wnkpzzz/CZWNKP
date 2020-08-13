//
//  EPImageModel.m
//  EPJH
//
//  Created by Hans on 2020/8/3.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "EPImageModel.h"
#import "EPUserInfoModel.h"

@implementation EPImageModel


- (id)copyWithZone:(NSZone *)zone {
    EPImageModel *newModel = [[EPImageModel allocWithZone:zone] init];
    newModel.bindUserId = self.bindUserId;
    newModel.customerId = self.customerId;
    newModel.projectId = self.projectId;
    newModel.imageId = self.imageId;
    newModel.createTime = self.createTime;
    newModel.timeFormat = self.timeFormat;
    newModel.subCateId = self.subCateId;
    newModel.subCateName = self.subCateName;
    newModel.cateId = self.cateId;
    newModel.cateName = self.cateName;
    newModel.sort = self.sort;
    newModel.sortId = self.sortId;
    newModel.sortName = self.sortName;
    newModel.isPaiZhaoFlag = self.isPaiZhaoFlag;
    newModel.cameraImgStr = self.cameraImgStr;
    newModel.tempImgStr = self.tempImgStr;
    newModel.composeImgStr = self.composeImgStr;
    newModel.isSelected = self.isSelected;
    newModel.tempTitle = self.tempTitle;
    newModel.cameraImgUrlStr = self.cameraImgUrlStr;
    newModel.tempImgUrlStr = self.tempImgUrlStr;
    newModel.composeImgUrlStr = self.composeImgUrlStr;
    return newModel;
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    EPImageModel *newModel = [[EPImageModel allocWithZone:zone] init];
    newModel.bindUserId = self.bindUserId;
    newModel.customerId = self.customerId;
    newModel.projectId = self.projectId;
    newModel.imageId = self.imageId;
    newModel.createTime = self.createTime;
    newModel.timeFormat = self.timeFormat;
    newModel.subCateId = self.subCateId;
    newModel.subCateName = self.subCateName;
    newModel.cateId = self.cateId;
    newModel.cateName = self.cateName;
    newModel.sort = self.sort;
    newModel.sortId = self.sortId;
    newModel.sortName = self.sortName;
    newModel.isPaiZhaoFlag = self.isPaiZhaoFlag;
    newModel.cameraImgStr = self.cameraImgStr;
    newModel.tempImgStr = self.tempImgStr;
    newModel.composeImgStr = self.composeImgStr;
    newModel.isSelected = self.isSelected;
    newModel.tempTitle = self.tempTitle;
    newModel.cameraImgUrlStr = self.cameraImgUrlStr;
    newModel.tempImgUrlStr = self.tempImgUrlStr;
    newModel.composeImgUrlStr = self.composeImgUrlStr;
    return newModel;
}
 
// 定义主键
+ (NSString *)yh_primaryKey{
    return @"imageId";
}

+ (NSDictionary *)yh_replacedKeyFromPropertyName{
    return @{@"imageId":YHDB_PrimaryKey};
}

/** 将属性是一个模型对象:字典再根据属性名获取value作为字段名 */
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

@end
