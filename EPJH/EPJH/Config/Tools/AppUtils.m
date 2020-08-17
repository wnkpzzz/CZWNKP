//
//  AppUtils.m
//  EPJH
//
//  Created by Hans on 2020/7/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "AppUtils.h"

@implementation AppUtils

/**
 *  md5加密, 小写32位
 */
+ (NSString *)app_md5:(NSString *)string{
    
    if (string == nil || [string length] == 0) {return nil; }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02X", (int)(digest[i])];
    }
    
    return [ms lowercaseString];
    //    return [ms substringWithRange:NSMakeRange(8, 16)];
}
/**
 *  判断字符串是空
 *  这里面的"空"指的是"", nil, NSNull对象, 只有多个空格
 */
+ (BOOL)app_isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
/**
 *  base64编码
 */
+ (NSString *)app_base64EncodedString:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}
/**
 *  base64解码
 */
+ (NSString *)app_base64DecodedString:(NSString *)string {
    //替换string里面所有空格，将空格替换成+
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
/**
 *  获取uudi
 */
+ (NSString *)app_getUUID {
    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
    NSMutableString *tmpResult = result.mutableCopy; // 去除“-”
    NSRange range = [tmpResult rangeOfString:@"-"];
    while (range.location != NSNotFound) {
        [tmpResult deleteCharactersInRange:range];
        range = [tmpResult rangeOfString:@"-"];
    }
    
    return [tmpResult copy];
}

/** 获得当前时间戳 */
+ (NSString *)getNowTimeCuo{
     
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // hh与HH的区别:分别表示12小时制,24小时制
      
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"]; //设置时区
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
    
}
@end
