//
//  SqliteManager.m
//  EPJH
//
//  Created by Hans on 2020/8/13.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "SqliteManager.h"


@implementation CreatTable @end

@interface SqliteManager()
@property(nonatomic,retain) FMDatabaseQueue *dbQueue;
@end

@implementation SqliteManager

/** 单例 */
+ (instancetype)sharedInstance{
    
    static SqliteManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SqliteManager alloc] init];
    });
    return instance;
}

#pragma mark - 懒加载

- (NSMutableArray<CreatTable *> *)kUserInfoArray{
    if (!_kUserInfoArray) {
        _kUserInfoArray = [NSMutableArray new];
    }
    return _kUserInfoArray;
}

- (NSMutableArray<CreatTable *> *)kProjectInfoArray{
    if (!_kProjectInfoArray) {
        _kProjectInfoArray = [NSMutableArray new];
    }
    return _kProjectInfoArray;
}

- (NSMutableArray<CreatTable *> *)kImageProInfoArray{
    if (!_kImageProInfoArray) {
        _kImageProInfoArray = [NSMutableArray new];
    }
    return _kImageProInfoArray;
}

- (NSMutableArray<CreatTable *> *)kContrastInfoArray{
    if (!_kContrastInfoArray) {
        _kContrastInfoArray = [NSMutableArray new];
    }
    return _kContrastInfoArray;
}

@end
