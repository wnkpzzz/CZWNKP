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

/** 用户表数据组 */
@property(nonatomic,strong) NSMutableArray < CreatTable *>*kUserInfoArray;
/** 项目表数据组 */
@property(nonatomic,strong) NSMutableArray < CreatTable *>*kProjectInfoArray;
/** 图片表数据组 */
@property(nonatomic,strong) NSMutableArray < CreatTable *>*kImageProInfoArray;
/** 对比相册表数据组 */
@property(nonatomic,strong) NSMutableArray < CreatTable *>*kContrastInfoArray;

@end

NS_ASSUME_NONNULL_END


//
