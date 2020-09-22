//
//  SqliteManager+project.h
//  EPJH
//
//  Created by Hans on 2020/9/22.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "SqliteManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface SqliteManager (project)


#pragma mark ---------我的项目---------


/*
 * 向表中更新/插入单条数据
 * @param proModel         该条数据Model
 * @param updateItems      传nil就是更新Model的所有字段,否则更新数组里面的指定字段。
 * eg:updateItems = @[@"userName",@"job"]; 更新好友的姓名和职位，注意字段名要填写正确
 */
- (void)updateOneProjectWithUID:(NSString *)uid dataModel:(EPProjectModel *)proModel updateItems:(NSArray <NSString *>*)updateItems complete:(void (^)(BOOL success,id obj))complete;

/*
 * 向表中更新/插入多条数据
 */
- (void)updateProjectsListWithUID:(NSString *)uid frislist:(NSArray <EPProjectModel *>*)proslist complete:(void (^)(BOOL success,id obj))complete;

/*
 *  删除表中某一条数据
 */
- (void)deleteOneProjectWithUID:(NSString *)uid pro:(EPProjectModel *)proModel complete:(void(^)(BOOL success,id obj))complete;

/*
*  模糊/条件查询表表数据
*  @param accurateInfo       条件查询
*  @param fuzzyInfo          模糊查询
*  备注:userInfo = nil && fuzzyUserInfo = nil 为全文搜索
*  备注:多条件/模糊查询 @{@"sex":@"1",@"province":@"广东省",@"city":@""}
*  备注:查询条件可以为空
*/
- (void)queryProjectTableWithUID:(NSString *)uid accurateInfo:(NSDictionary *)accurateInfo fuzzyInfo:(NSDictionary *)fuzzyInfo otherSQLDict:(NSDictionary *)otherSQLDict complete:(void (^)(BOOL success,id obj))complete;

@end

NS_ASSUME_NONNULL_END
