//
//  SqliteData.m
//  EPJH
//
//  Created by Hans on 2020/8/13.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "SqliteData.h"

@interface SqliteData()

@property(nonatomic,strong) NSMutableArray  *kUserInfoArray;  // 用户表数据组
@property(nonatomic,strong) NSMutableArray  *kProjectInfoArray; // 项目表数据组

@end

@implementation SqliteData

//单例
+ (instancetype)sharedInstance{
    static SqliteData *g_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_instance = [[SqliteData alloc] init];
        
    });
    return g_instance;
    
}


#pragma mark - Lazy Load

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

@end
