//
//  YPProjectModel.h
//  EPJH
//
//  Created by Hans on 2020/11/23.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPProjectModel : NSObject

// 基础信息
@property (nonatomic,copy) NSString * bindUserId;   // 属于那个用户
@property (nonatomic,copy) NSString * customerId;   // 属于那个客户
@property (nonatomic,copy) NSString * projectId;    // 本次项目主键
@property (nonatomic,copy) NSString * createTime;   // 创建时间
@property (nonatomic,copy) NSString * timeFormat;   // 格式化后的时间

// 时间节点
@property (nonatomic,copy) NSString * subCateId;    // 时间节点ID
@property (nonatomic,copy) NSString * subCateName;  // 时间节点名称

// 部位节点
@property (nonatomic,copy) NSString * cateId;       // 部位节点ID
@property (nonatomic,copy) NSString * cateName;     // 部位节点名称

// 照片数组
@property (nonatomic,strong) NSMutableArray<EPImageModel *> *cameraArr; // 拍照数组

// 部位选择
@property (nonatomic,copy) NSString * position;
@property (nonatomic,copy) NSString * subSubCateId;

// 项目选择
@property (nonatomic,copy) NSString * project;
@property (nonatomic,copy) NSString * subSubSubCateId;

// 材料
@property (nonatomic,copy) NSString * material;
@property (nonatomic,copy) NSString * subSubSubSubCateId;

// 项目备注
@property (nonatomic,copy) NSString * remark;

@end

NS_ASSUME_NONNULL_END
