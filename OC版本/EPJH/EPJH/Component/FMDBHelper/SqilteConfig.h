//
//  SqilteConfig.h
//  EPJH
//
//  Created by Hans on 2020/8/13.
//  Copyright © 2020 hans3d. All rights reserved.
//

#ifndef SqilteConfig_h
#define SqilteConfig_h

#import "NSObject+YHDBRuntime.h"
#import "FMDatabase+YHDatabase.h"

#import "AppUtils.h"
#import "EPImageModel.h"
#import "EPProjectModel.h"
#import "EPUserInfoModel.h"

#import "SqliteManager.h"
#import "SqliteDefaultData.h"
#import "SqliteManager+user.h"
#import "SqliteManager+project.h"
#import "SqliteManager+Image.h"

#import "SqliteLogicHandler.h"

/** ******************宏定义************** */

#define kDatabaseVersionKey       @"ZC_DBVersion" // 记录本次数据库版本

//Document目录路径
#define ZCDocumentDir [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

//Cache目录路径
#define ZCCacheDir [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

//用户数据目录路径
#define ZCUserDir [ZCDocumentDir stringByAppendingPathComponent:KUID]
 
//数据库文件目录
#define ZCFriendsDir [ZCDocumentDir stringByAppendingPathComponent:KUID]
#define ZCProjectDir [ZCDocumentDir stringByAppendingPathComponent:KUID]
#define ZCImageProDir [ZCDocumentDir stringByAppendingPathComponent:KUID]
#define ZCContrastDir [ZCDocumentDir stringByAppendingPathComponent:KUID]
//#define ZCFriendsDir [ZCUserDir stringByAppendingPathComponent:@"Friends"]    //用户数据库数据目录
//#define ZCProjectDir [ZCUserDir stringByAppendingPathComponent:@"Project"]    //项目数据库数据目录
//#define ZCImageProDir [ZCUserDir stringByAppendingPathComponent:@"ImagePro"]  //图片数据库数据目录
//#define ZCContrastDir [ZCUserDir stringByAppendingPathComponent:@"Contrast"]  //对比工具数据库数据目录

//数据库文件路径
//病人路径
static inline NSString *pathFrisWithDir( NSString *dir,NSString *friID){
    NSString *pathLog = [dir stringByAppendingPathComponent:[NSString stringWithFormat:@"fri_%@.sqlite",friID]];
    return pathLog;
}
//项目路径
static inline NSString *pathProjectWithDir( NSString *dir,NSString *friID){
//    NSString *pathLog = [dir stringByAppendingPathComponent:[NSString stringWithFormat:@"pro_%@.sqlite",friID]];
    NSString *pathLog = [dir stringByAppendingPathComponent:[NSString stringWithFormat:@"epjh_%@.sqlite",friID]];
    return pathLog;
}
//图片路径
static inline NSString *pathImageProWithDir( NSString *dir,NSString *friID){
//    NSString *pathLog = [dir stringByAppendingPathComponent:[NSString stringWithFormat:@"imagePro_%@.sqlite",friID]];
    NSString *pathLog = [dir stringByAppendingPathComponent:[NSString stringWithFormat:@"epjh_%@.sqlite",friID]];
    return pathLog;
}
//对比表路径
static inline NSString *pathContrastWithDir( NSString *dir,NSString *friID){
//    NSString *pathLog = [dir stringByAppendingPathComponent:[NSString stringWithFormat:@"duibi_%@.sqlite",friID]];
    NSString *pathLog = [dir stringByAppendingPathComponent:[NSString stringWithFormat:@"epjh_%@.sqlite",friID]];
    return pathLog;
}

/** ******************用户表************** */

//病人表名的命名方式
static inline NSString *tableNameFris(NSString *friID){
    return [NSString stringWithFormat:@"fri_%@",[friID stringByReplacingOccurrencesOfString:@"-" withString:@""]];
}

/** ******************项目表************** */

//项目表名的命名方式
static inline NSString *tableNameProject(NSString *friID){
    return [NSString stringWithFormat:@"pro_%@",[friID stringByReplacingOccurrencesOfString:@"-" withString:@""]];
}
 
/** ******************图片表************** */

//项目表名的命名方式
static inline NSString *tableNameImagePro(NSString *friID){
    return [NSString stringWithFormat:@"imagePro_%@",[friID stringByReplacingOccurrencesOfString:@"-" withString:@""]];
}

/** ******************对比相册表************** */
 
//对比相册表名的命名方式
static inline NSString *tableNameContrast(NSString *friID){
    return [NSString stringWithFormat:@"duibi_%@",[friID stringByReplacingOccurrencesOfString:@"-" withString:@""]];
}

/** ******************图片存储文件夹************** */

//图片存储文件夹
#define ZCImageDir [ZCUserDir stringByAppendingPathComponent:@"ImageIcon"]

//图片的命名方式
static inline NSString *tableNameImage(NSString *friID,NSString *userID,NSString *timeID,NSString *numID){
    return [NSString stringWithFormat:@"image_%@_%@_%@_%@.png",friID,userID,timeID,numID];
}


#endif /* SqilteConfig_h */
