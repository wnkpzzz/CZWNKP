//
//  AppUtils.h
//  EPJH
//
//  Created by Hans on 2020/7/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppUtils : NSObject

/**
 *  md5加密, 小写32位
 */
+ (NSString *)app_md5:(NSString *)string;
/**
 *  判断字符串是空
 *  这里面的"空"指的是"", nil, NSNull对象, 只有多个空格
 */
+ (BOOL)app_isBlankString:(NSString *)string;
/**
 *  base64编码
 */
+ (NSString *)app_base64EncodedString:(NSString *)string;

/**
 *  base64解码
 */
+ (NSString *)app_base64DecodedString:(NSString *)string;

/**
 *  获取uudi
 */
+ (NSString *)app_getUUID;

/** iOS全面屏屏判断 */
+ (BOOL)isIPhoneX;

/** 读取本地JSON文件 */
+ (NSDictionary * )readLocalFileWithName:(NSString *)name;

/** 获得当前时间戳 */
+ (NSString *)getNowTimeCuo;

/** 时间戳转换为时间 */
+ (NSString *)timestampChangeTime:(NSString *)timestamp WithFormat:(NSString *)formatStr;

/** 获取一个随机整数，范围在[from,to），包括from，不包括to */
+ (int)getRandomNumber:(int)from to:(int)to ;

@end

NS_ASSUME_NONNULL_END
