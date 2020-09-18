//
//  SqliteData.m
//  EPJH
//
//  Created by Hans on 2020/8/13.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "SqliteData.h"

@interface SqliteData()

/** 用户表数据组 */
@property(nonatomic,strong) NSMutableArray  *kUserInfoArray;
/** 项目表数据组 */
@property(nonatomic,strong) NSMutableArray  *kProjectInfoArray;
/** 项目图片表数据组 */
@property(nonatomic,strong) NSMutableArray  *kProImageInfoArray;

@end

@implementation SqliteData

/** 单例 */
+ (instancetype)sharedInstance{
    static SqliteData *g_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_instance = [[SqliteData alloc] init];
        
    });
    return g_instance;
    
}


#pragma mark - 懒加载

- (NSMutableArray  *)kUserInfoArray{
    if (!_kUserInfoArray) {
        _kUserInfoArray = [NSMutableArray new];
    }
    return _kUserInfoArray;
}

- (NSMutableArray *)kProjectInfoArray{
    if (!_kProjectInfoArray) {
        _kProjectInfoArray = [NSMutableArray new];
    }
    return _kProjectInfoArray;
}

- (NSMutableArray *)kProImageInfoArray{
    if (!_kProImageInfoArray) {
        _kProImageInfoArray = [NSMutableArray new];
    }
    return _kProImageInfoArray;
}

@end
