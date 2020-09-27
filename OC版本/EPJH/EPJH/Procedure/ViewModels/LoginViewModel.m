//
//  LoginViewModel.m
//  EPJH
//
//  Created by Hans on 2020/7/16.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

/** 用户登录 */
- (void)requestSignInWith:(NSString *)accountStr AndPwd:(NSString *)passwordStr{

    if (accountStr.length != 11  || passwordStr.length < 6 ) {  [MBProgressHUD showError:@"请填写正确账号密码信息！"];return; }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = accountStr;
    params[@"passWord"] = [AppUtils app_md5:passwordStr];
    
    [KAppNetRequestWithShowLog(YES) AF_PostNetWorkWithHeaderUrlStr:URL_Login_login Parameter:params completion:^(NSDictionary *dic, NSError *error) {
        
        if (!error) {
            
            if ([dic[@"statusCode"] isEqualToString:@"200"]) {
               
                [MBProgressHUD showSuccess:@"登录成功"];
                
                // 1 保存账号信息
                NSDictionary * partyViewDic = dic[@"partyView"];
                [NSUSERDEFAULTS setObject:dic[@"sid"] forKey:kUserSID];
                [NSUSERDEFAULTS setObject:partyViewDic[@"id"] forKey:kUserID];
                [NSUSERDEFAULTS setObject:partyViewDic[@"profile"] forKey:kUserImage];
                [NSUSERDEFAULTS setObject:accountStr forKey:kPhoneNum];
 
                // 2 跳转页面
                [AppJump goHomeVC];
                
            }else{
                [MBProgressHUD showError:dic[@"msg"]];
            }
        }
    }];
    
}

/** 获取验证码 */
- (void)requestGetCodeWith:(NSString *)accountStr withType:(GetCodeRequestType)type completion:(CallbackSimpleCompletion)handler{
    

    if ([AppUtils app_isBlankString:accountStr]) {  [MBProgressHUD showError:@"请输入手机号码"]; return; }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = accountStr;
    param[@"prix"] = @"86";
    if (type == GetCodeWithRegister) {param[@"isRegister"] = @"YES";}
    if (type == GetCodeWithFindPwd)  {param[@"isRegister"] = @"NO";}

    [KAppNetRequestWithShowLog(YES) AF_GetNetWorkWithHeaderUrlStr:URL_Login_getCode Parameter:param completion:^(NSDictionary *dic, NSError *error) {
 
        if (!error) {
            
            if ([dic[@"statusCode"] isEqualToString:@"200"]) {
                
                [MBProgressHUD showSuccess:@"短信已发送"];
                
                handler(YES);
                
            }else{
                [MBProgressHUD showError:dic[@"msg"]];
            }
            
        }
    }];
}

/** 用户注册 */
- (void)requestSignUpWith:(NSString *)accountStr AndPwd:(NSString *)passwordStr AndCode:(NSString *)codeStr completion:(CallbackSimpleCompletion)handler{
    
    if (accountStr.length != 11 || codeStr.length == 0 || passwordStr.length < 6 ) {  [MBProgressHUD showError:@"请输入正确格式的数据！"]; return; }
       
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = accountStr;
    param[@"smsCode"] = codeStr;
    param[@"passWord"] = [AppUtils app_md5:passwordStr];
    param[@"yqmCode"] = @"";
    param[@"type"] = @"1";
    param[@"age"] = @"";
    param[@"sex"] = @"";
    param[@"city"] = @"";
    param[@"province"] = @"";
    param[@"realName"] = @"";
    
    [KAppNetRequestWithShowLog(YES) AF_PostNetWorkWithHeaderUrlStr:URL_Login_register Parameter:param completion:^(NSDictionary *dic, NSError *error) {
 
        if (!error) {
            
            if ([dic[@"statusCode"] isEqualToString:@"200"]) {
                
                [NSUSERDEFAULTS setObject:accountStr forKey:kPhoneNum];
                
                handler(YES);
 
            }else{
                [MBProgressHUD showError:dic[@"msg"]];
            }
        }
    }];
}

/** 找回密码 */
- (void)requestFindPwdWith:(NSString *)accountStr AndPwd:(NSString *)passwordStr AndCode:(NSString *)codeStr completion:(CallbackSimpleCompletion)handler{
    
    if (accountStr.length != 11 || codeStr.length == 0 || passwordStr.length < 6 ) {  [MBProgressHUD showError:@"请输入正确格式的数据！"]; return; }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = accountStr;
    param[@"smsCode"] = codeStr;
    param[@"passWord"] = [AppUtils app_md5:passwordStr];
    
    [KAppNetRequestWithShowLog(YES) AF_PostNetWorkWithHeaderUrlStr:URL_Login_forgetPwd Parameter:param completion:^(NSDictionary *dic, NSError *error) {
        
        if (!error) {
            
            if ([dic[@"statusCode"] isEqualToString:@"200"]) {
                 
                handler(YES);
                
            }else{
                [MBProgressHUD showError:dic[@"msg"]];
            }
        }
    }];
}

@end
