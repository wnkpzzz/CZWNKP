//
//  SqliteManager.h
//  EPJH
//
//  Created by Hans on 2020/8/13.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EPUserInfoModel.h"
#import "EPProjectModel.h"
#import "EPImageModel.h"

NS_ASSUME_NONNULL_BEGIN

//建表所需
@interface CreatTable : NSObject
@property (nonatomic,assign) int type;
@property (nonatomic,copy) NSString *Id;
@property (nonatomic,strong) FMDatabaseQueue *queue;
@property (nonatomic,copy) NSArray <NSString *> *sqlCreatTable;
@end


@interface SqliteManager : NSObject

/** 单例 */
+ (instancetype)sharedInstance;


#pragma mark ---------我的病人/用户---------

/*
 * 更新/插入单条用户数据
 * @param aFri         好友UserInfo
 * @param updateItems  传nil就是更新model的所有字段,否则更新数组里面的指定字段。eg:updateItems = @[@"userName",@"job"];
 * 更新好友的姓名和职位，注意字段名要填写正确
 */
- (void)updateOneFri:(EPUserInfoModel *)aFri updateItems:(NSArray <NSString *>*)updateItems complete:(void (^)(BOOL success,id obj))complete;

/*
 *  插入/更新多条用户数据
 */
- (void)updateFrisListWithFriID:(NSString *)friID frislist:(NSArray <EPUserInfoModel *>*)frislist complete:(void (^)(BOOL success,id obj))complete;

/*
 *  删除某一个病人数据
 */
- (void)deleteOneFriWithfriID:(NSString *)friID fri:(EPUserInfoModel *)fri userInfo:(NSDictionary *)userInfo complete:(void(^)(BOOL success,id obj))complete;

/*
 *  删除病人表数据
 */
- (void)deleteFrisTableWithFriID:(NSString *)friID complete:(void(^)(BOOL success,id obj))complete;

/*
 *  模糊/条件病人表
 *  @param userInfo       条件查询
 *  @param fuzzyUserInfo  模糊查询
 *  备注:userInfo = nil && fuzzyUserInfo = nil 为全文搜索
 */
- (void)queryFrisTableWithFriID:(NSString *)friID userInfo:(NSDictionary *)userInfo fuzzyUserInfo:(NSDictionary *)fuzzyUserInfo complete:(void (^)(BOOL success,id obj))complete;


/*
 * 模糊/条件查询病人数据
 *  @param userInfo       条件查询
 *  @param fuzzyUserInfo  模糊查询
 *  备注:多条件查询 @{@"sex":@"1",@"province":@"广东省"}
 *  备注:userInfo = nil && fuzzyUserInfo = nil 为全文搜索
 */
- (void)queryFrisTableWithTag:(NSString *)friID  userInfo:(NSDictionary *)userInfo fuzzyUserInfo:(NSDictionary *)fuzzyUserInfo otherSQLDict:(NSDictionary *)otherSQLDict complete:(void (^)(BOOL success,id obj))complete;

/*
 * 查询多个病人表
 * @param friIDs  表ID数组
 */
- (void)queryFrisWithfriIDs:(NSArray<NSString *> *)friIDs complete:(void (^)(NSArray *successUserInfos,NSArray *failUids))complete;


 

#pragma mark ---------图片存储---------
 
/** 根据名称从沙盒路径中取出原图/缩略图,是否大图 */
- (UIImage *)getImageFromSandboxWith:(NSString *)imageName isCacheImg:(BOOL)isCache isOriginal:(BOOL)isCompress;


@end

NS_ASSUME_NONNULL_END
