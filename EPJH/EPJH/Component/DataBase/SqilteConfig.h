//
//  SqilteConfig.h
//  EPJH
//
//  Created by Hans on 2020/8/13.
//  Copyright © 2020 hans3d. All rights reserved.
//

#ifndef SqilteConfig_h
#define SqilteConfig_h

#import "FMDatabase+YHDatabase.h"
#import "NSObject+YHDBRuntime.h"


#import "ProjectDataCommon.h"

#import "AppUtils.h"
#import "SqliteData.h"
#import "SqliteManager.h"

#import "EPImageModel.h"
#import "EPProjectModel.h"
#import "EPUserInfoModel.h"
 
/** ******************宏定义************** */

#define kDatabaseVersionKey       @"ZC_DBVersion" // 记录本次数据库版本
#define kDBCunInfoKey             [NSString stringWithFormat:@"%@DBCunInfo",KUID] // 旧版对比相册数据存储

//Document目录路径
#define ZCDocumentDir [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

//Cache目录路径
#define ZCCacheDir [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

//用户数据目录路径
#define ZCUserDir [ZCDocumentDir stringByAppendingPathComponent:KUID]

 
/** ******************用户表************** */

//病人表数据目录
#define ZCFriendsDir [ZCUserDir stringByAppendingPathComponent:@"Friends"]

//病人表路径
static inline NSString *pathFrisWithDir( NSString *dir,NSString *friID){
    NSString *pathLog = [dir stringByAppendingPathComponent:[NSString stringWithFormat:@"fri_%@.sqlite",friID]];
    return pathLog;
}

//病人表名的命名方式
static inline NSString *tableNameFris(NSString *friID){
    
    return [NSString stringWithFormat:@"fri_%@",[friID stringByReplacingOccurrencesOfString:@"-" withString:@""]];
}

/** ******************项目表************** */


//项目表数据目录
#define ZCProjectDir [ZCUserDir stringByAppendingPathComponent:@"Project"]

//项目表路径
static inline NSString *pathProjectWithDir( NSString *dir,NSString *friID){
    NSString *pathLog = [dir stringByAppendingPathComponent:[NSString stringWithFormat:@"pro_%@.sqlite",friID]];
    return pathLog;
}

//项目表名的命名方式
static inline NSString *tableNameProject(NSString *friID){

    return [NSString stringWithFormat:@"pro_%@",[friID stringByReplacingOccurrencesOfString:@"-" withString:@""]];
}

/** ******************图片存储文件夹************** */

//图片存储文件夹
#define ZCImageDir [ZCUserDir stringByAppendingPathComponent:@"ImageIcon"]

//图片的命名方式
static inline NSString *tableNameImage(NSString *friID,NSString *userID,NSString *timeID,NSString *numID){
    return [NSString stringWithFormat:@"image_%@_%@_%@_%@.png",friID,userID,timeID,numID];
}


#endif /* SqilteConfig_h */
