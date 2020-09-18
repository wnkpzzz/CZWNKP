//
//  SqliteManager.h
//  EPJH
//
//  Created by Hans on 2020/8/13.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <Foundation/Foundation.h>

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


#pragma mark --------------------------- 图片存储 --------------------------- 
 
/** 根据名称从沙盒路径中取出原图/缩略图,是否大图 */
- (UIImage *)getImageFromSandboxWith:(NSString *)imageName isCacheImg:(BOOL)isCache isOriginal:(BOOL)isCompress;


@end

NS_ASSUME_NONNULL_END
