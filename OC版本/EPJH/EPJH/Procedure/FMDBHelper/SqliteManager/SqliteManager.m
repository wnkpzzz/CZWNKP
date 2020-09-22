//
//  SqliteManager.m
//  EPJH
//
//  Created by Hans on 2020/8/13.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "SqliteManager.h"

#define kDocumentDir            [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define kUserInfoPath           [kDocumentDir stringByAppendingPathComponent:@"kUserInfoTab.sqlite"]
#define kUserProjectPath        [kDocumentDir stringByAppendingPathComponent:@"kUserProjectTab.sqlite"]
#define kUserProImagePath       [kDocumentDir stringByAppendingPathComponent:@"kUserProImageTab.sqlite"]
#define kUserContrastPath       [kDocumentDir stringByAppendingPathComponent:@"kUserContrastTab.sqlite"]

@implementation CreatTable @end

@interface SqliteManager()
@property(nonatomic,retain) FMDatabaseQueue *dbQueue;
@end

@implementation SqliteManager

/** 单例 */
+ (instancetype)sharedInstance{
    static SqliteManager *g_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_instance = [[SqliteManager alloc] init];
    });
    return g_instance;
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

- (NSMutableArray<CreatTable *> *)kContrastInfoArray{
    if (!_kContrastInfoArray) {
        _kContrastInfoArray = [NSMutableArray new];
    }
    return _kContrastInfoArray;
}

@end
