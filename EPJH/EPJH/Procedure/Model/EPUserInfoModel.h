//
//  EPUserInfoModel.h
//  EPJH
//
//  Created by Hans on 2020/8/3.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EPUserInfoModel : NSObject

// 基础信息
@property (nonatomic,copy) NSString * bindUserId;   // 属于那个用户
@property (nonatomic,copy) NSString * uid;          // 本次病人主键
@property (nonatomic,copy) NSString * createTime;   // 创建时间
@property (nonatomic,copy) NSString * timeFormat;   // 格式化后的时间

// 个人信息
@property (nonatomic,copy) NSString * headImg;
@property (nonatomic,copy) NSString * headImgUrlStr;
@property (nonatomic,copy) NSString * realName;
@property (nonatomic,copy) NSString * sex;
@property (nonatomic,copy) NSString * age;
@property (nonatomic,copy) NSString * phone;
@property (nonatomic,copy) NSString * province;
@property (nonatomic,copy) NSString * city;
@property (nonatomic,copy) NSString * addr;

// 既往病史
@property (nonatomic,copy) NSString * medicalHistory;
@property (nonatomic,copy) NSString * medicalHistoryStr;

// 生理状况
@property (nonatomic,copy) NSString * physiologicalCondition;
@property (nonatomic,copy) NSString * physiologicalConditionStr;

// 医美史
@property (nonatomic,copy) NSString * position;
@property (nonatomic,copy) NSString * project;
@property (nonatomic,copy) NSString * material;
@property (nonatomic,copy) NSString * remark;

// 过敏病史
@property (nonatomic,copy) NSString * medicinal;
@property (nonatomic,copy) NSString * food;

// 其他备注
@property (nonatomic,copy) NSString * extr;

#pragma mark - 衍生
@property (nonatomic, assign) BOOL isSelected;

#pragma mark - 2019.12.06新增字段
@property (nonatomic,copy) NSString * isCollect;    // 收藏 1为收藏，0为没收藏

@end

NS_ASSUME_NONNULL_END
