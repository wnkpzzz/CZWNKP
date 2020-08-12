//
//  AppNetRequest.h
//  EPJH
//
//  Created by Hans on 2020/7/15.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppNetRequest : NSObject

@property (assign, nonatomic) BOOL showLog;

+(AppNetRequest *)ShareAppNetRequestWithShowLog:(BOOL)show;

+(AFHTTPSessionManager *)configManager;

#pragma mark - 普通请求

//Get 请求
-(void)AF_GetNetWorkWithHeaderUrlStr:(NSString *)urlStr Parameter:(id)parameter completion:(void (^)(NSDictionary *dic,NSError *error))completion;

//Post 请求
-(void)AF_PostNetWorkWithHeaderUrlStr:(NSString *)urlStr Parameter:(id)parameter completion:(void (^)(NSDictionary *dic,NSError *error))completion;

//图片上传
-(void)AF_UploadImgWithHeaderUrlStr:(UIImage *)image Parameter:(id)parameter completion:(void (^)(NSDictionary *dic,NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
