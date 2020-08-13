//
//  EPImageModel.h
//  EPJH
//
//  Created by Hans on 2020/8/3.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EPImageModel : NSObject

// 基础信息
@property (nonatomic,copy) NSString * bindUserId;   // 属于那个用户
@property (nonatomic,copy) NSString * customerId;   // 属于那个客户
@property (nonatomic,copy) NSString * projectId;    // 属于那个项目
@property (nonatomic,copy) NSString * imageId;      // 关于本次的图片主键
@property (nonatomic,copy) NSString * createTime;   // 创建时间
@property (nonatomic,copy) NSString * timeFormat;   // 格式化后的时间

// 时间节点
@property (nonatomic,copy) NSString * subCateId;    // 时间节点ID
@property (nonatomic,copy) NSString * subCateName;  // 时间节点名称

// 部位节点
@property (nonatomic,copy) NSString * cateId;       // 部位节点ID
@property (nonatomic,copy) NSString * cateName;     // 部位节点名称

// 编号相关
@property (nonatomic,assign) int  sort;             // 位置编号  5
@property (nonatomic,copy) NSString * sortId;       // 位置ID 100000790000005
@property (nonatomic,copy) NSString * sortName;     // 位置名称 "右侧90°"

// 图片相关
@property (nonatomic,copy) NSString * isPaiZhaoFlag;    // 是否拍照 YES NO
@property (nonatomic,copy) NSString * cameraImgStr;     // 本次拍照
@property (nonatomic,copy) NSString * tempImgStr;       // 对比照
@property (nonatomic,copy) NSString * composeImgStr;    // 合成照片

#pragma mark - 衍生
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic,copy) NSString * tempTitle;

@property (nonatomic,copy) NSString * cameraImgUrlStr;  // 本次拍照网络照片
@property (nonatomic,copy) NSString * tempImgUrlStr;    // 对比照网络照片
@property (nonatomic,copy) NSString * composeImgUrlStr; // 合成照片网络照片

@end

NS_ASSUME_NONNULL_END
