//
//  EPProjectModel.h
//  EPJH
//
//  Created by Hans on 2020/8/3.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EPImageModel.h"
#import "EPUserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EPProjectModel : NSObject

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

#pragma mark - 扩展
@property (nonatomic,strong) EPUserInfoModel *userInfo;  // 用户个人资料
@property (nonatomic,copy) NSString * realName;
@property (nonatomic,copy) NSString * sex;
@property (nonatomic,copy) NSString * age;
@property (nonatomic,copy) NSString * phone;
@property (nonatomic,copy) NSString * province;
@property (nonatomic,copy) NSString * city;
@property (nonatomic,copy) NSString * addr;

#pragma mark - 衍生
@property (nonatomic,assign) BOOL isSelected;


@end

NS_ASSUME_NONNULL_END




//项目表
//
//"bindUserId" : "100001066004168",   // 属于那个用户
//“customerId" : "100001066004168",  // 属于那个客户
//"createTime" : 1527585967000,  // 创建时间
//“partyId" : "100001065004785",  // 项目主键
//
//
//时间节点
//"subCateId" : "100000626000008"
//"subCateName" : "术后",
//部位节点
//"cateId" : "100000753000002",
//"cateName" : "面部",
//
//图片
//
//数组
//{
//    "cateId" : "100000626000002",
//    "subCateId" : "100000626000008",
//    "sort" : 1,
//    "name" : "正面",
//    "id" : "100000790000001",
//    "imageUrl" : "http:\/\/47.88.154.195\/photograph\/upload\/media\/fa30ebd6-e432-40d9-ab8c-68b2209dfae4.png",
//    "duibitu" : "http:\/\/47.88.154.195\/photograph\/upload\/media\/fa30ebd6-e432-40d9-ab8c-68b2209dfae4.png",
//
//}
//
//
//项目选择
//"position" : "眉眼部;胸部;鼻部;唇部",
//"subSubCateId" : "100000626000011,100000626000020",
//"project" : "袪黑眼圈;上睑下垂;胸部01;内眼角;",
//"subSubSubCateId" : "100000789000011,100000789000017,100000918001556,",
//"material" : "超体4;超体2;超体033",
//"subSubSubSubCateId" : "100000895000913,100000908000126",
//"extr" : "",

