//
//  AppNetRequest.m
//  EPJH
//
//  Created by Hans on 2020/7/15.
//  Copyright © 2020 hans3d. All rights reserved.
//


#import "AppNetRequest.h"

static NSTimeInterval app_timeout = 30.0f;                          // 请求超时时间
static NSDictionary *app_httpHeaders = nil;                         // 请求头

@interface AppNetRequest ()<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@end

@implementation AppNetRequest

+(AppNetRequest *)ShareAppNetRequestWithShowLog:(BOOL)show{
    
    AppNetRequest *itans = [[AppNetRequest alloc] initShowLog:show];
    
    return itans;
}

-(instancetype)initShowLog:(BOOL)show{
    if (self = [super init]) {
        self.showLog = show;
    } 
    return self;
}

// 配置请求管理者
+ (AFHTTPSessionManager *)configManager{
    
    //创建管理器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //设置请求的编码方式为UTF-8
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    
    //设置当前APP特有的请求头
    if ([AppJump isLogin]) {
        NSString *sessionId =  KSID;
        if (sessionId.length) {
            NSString *cookie = [NSString stringWithFormat:@"JSESSIONID=%@", sessionId];
            [self configCommonHttpHeaders:@{@"Cookie": cookie}];
            
        }
    }
    
    //设置公共请求头
    for (NSString *key in app_httpHeaders.allKeys) {
        if (app_httpHeaders[key] != nil) {
            [manager.requestSerializer setValue:app_httpHeaders[key] forHTTPHeaderField:key];
        }
    }
    
    //设置可处理的响应格式
    NSArray *serializerArray = @[@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:serializerArray];
    
    //设置请求超时请求时间
    manager.requestSerializer.timeoutInterval = app_timeout;
    
    //设置请求并发最大数
    manager.operationQueue.maxConcurrentOperationCount = 6;
    
    return manager;
}

// 配置公共请求头
+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders {
    app_httpHeaders = httpHeaders;
}

#pragma mark - 普通请求

-(void)AF_GetNetWorkWithHeaderUrlStr:(NSString *)urlStr Parameter:(id)parameter completion:(void (^)(NSDictionary *dic,NSError *error))completion{
    
    
    if (self.showLog) {
        
        NSLog(@"上传服务器的参数:%@",[NSString stringWithFormat:@"%@%@",urlStr,parameter]);
    }
    
    //获取请求管理者
    AFHTTPSessionManager *manager = [AppNetRequest configManager];
    
    [manager GET:urlStr parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict = (NSDictionary *)responseObject;
            if (self.showLog){
                
                NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"服务器返回的结果:%@",str);
            }
            
            //登录超时，请重新登录(或者未登录)
            if ([dict[@"statusCode"] isEqualToString:@"84512"]) {   [AppJump goExitVc];  }
            
            completion(dict,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"服务器错误结果:%@",error);
        completion(nil,error);
        
    }];
    
}

-(void)AF_PostNetWorkWithHeaderUrlStr:(NSString *)urlStr Parameter:(id)parameter completion:(void (^)(NSDictionary *dic,NSError *error))completion{
    
    if (self.showLog) {
        
        NSLog(@"上传服务器的参数:%@",[NSString stringWithFormat:@"%@?%@",urlStr,parameter]);
    }
    
    //获取请求管理者
    AFHTTPSessionManager *manager = [AppNetRequest configManager];
    
    [manager POST:urlStr parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict = (NSDictionary *)responseObject;
            
            if (self.showLog){
                
                NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"服务器返回的结果:%@",str);
            }
            
            //登录超时，请重新登录(或者未登录)
            if ([dict[@"statusCode"] isEqualToString:@"84512"]) {   [AppJump goExitVc];  }
            
            completion(dict,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        NSLog(@"错误结果:%@",error);
        completion(nil,error);
        
        
    }];
}

-(void)AF_UploadImgWithHeaderUrlStr:(UIImage *)image Parameter:(id)parameter completion:(void (^)(NSDictionary *dic,NSError *error))completion{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    [manager POST:URL_img_upload parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:UIImagePNGRepresentation(image)
                                    name:@"picturePath"
                                fileName:[NSString stringWithFormat:@"%@.png",image]
                                mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        completion(dic,nil);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"错误结果:%@",error);
        completion(nil,error);
        
    }];
    
}

@end
