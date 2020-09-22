//
//  SqliteManager+friend.h
//  EPJH
//
//  Created by Hans on 2020/9/22.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "SqliteManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface SqliteManager (friend)


 

#pragma mark ---------我的病人/用户---------

/*
 * 更新表中【单条】数据
 * @param aFri         该条数据Model
 * @param updateItems  传nil就是更新model的所有字段,否则更新数组里面的指定字段。eg:updateItems = @[@"userName",@"job"];
 * 更新好友的姓名和职位，注意字段名要填写正确
 */
- (void)updateOneFri:(EPUserInfoModel *)aFri updateItems:(NSArray <NSString *>*)updateItems complete:(void (^)(BOOL success,id obj))complete;

/*
*  插入【表】中多/单条数据
*/
- (void)updateFrisListWithFriID:(NSString *)friID frislist:(NSArray <EPUserInfoModel *>*)frislist complete:(void (^)(BOOL success,id obj))complete;

/*
*  删除表中某一条数据
*/
- (void)deleteOneFriWithfriID:(NSString *)friID fri:(EPUserInfoModel *)fri userInfo:(NSDictionary *)userInfo complete:(void(^)(BOOL success,id obj))complete;

/*
*  模糊/条件查询表表数据
*  @param userInfo       条件查询
*  @param fuzzyUserInfo  模糊查询
*  备注:userInfo = nil && fuzzyUserInfo = nil 为全文搜索
*  备注:多条件/模糊查询 @{@"sex":@"1",@"province":@"广东省",@"city":@""}
*  备注:查询条件可以为空
*/
- (void)queryFrisTableWithFriID:(NSString *)friID userInfo:(NSDictionary *)userInfo fuzzyUserInfo:(NSDictionary *)fuzzyUserInfo complete:(void (^)(BOOL success,id obj))complete;

/*
*  模糊/条件查询表表数据
*  @param userInfo       条件查询
*  @param fuzzyUserInfo  模糊查询
*  备注:userInfo = nil && fuzzyUserInfo = nil 为全文搜索
*  备注:多条件/模糊查询 @{@"sex":@"1",@"province":@"广东省",@"city":@""}
*  备注:查询条件可以为空
*/
- (void)queryFrisTableWithTag:(NSString *)friID  userInfo:(NSDictionary *)userInfo fuzzyUserInfo:(NSDictionary *)fuzzyUserInfo otherSQLDict:(NSDictionary *)otherSQLDict complete:(void (^)(BOOL success,id obj))complete;



/*
 *  删除表数据
 */
- (void)deleteFrisTableWithFriID:(NSString *)friID complete:(void(^)(BOOL success,id obj))complete;


/*
 * 查询多个表数据
 * @param friIDs  表ID数组
 */
- (void)queryFrisWithfriIDs:(NSArray<NSString *> *)friIDs complete:(void (^)(NSArray *successUserInfos,NSArray *failUids))complete;


 


@end

NS_ASSUME_NONNULL_END
