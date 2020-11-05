//
//  LoginViewModel.h
//  EPJH
//
//  Created by Hans on 2020/7/16.
//  Copyright © 2020 hans3d. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 获取验证码枚举
typedef NS_ENUM(NSInteger, GetCodeRequestType) {
    GetCodeWithRegister  ,
    GetCodeWithFindPwd  ,
};

@interface LoginViewModel : RootViewModel

/** 用户登录 */
- (void)requestSignInWith:(NSString *)accountStr AndPwd:(NSString *)passwordStr;

/** 获取验证码 */
- (void)requestGetCodeWith:(NSString *)accountStr  withType:(GetCodeRequestType)type completion:(CallbackSimpleCompletion)handler;

/** 用户注册 */
- (void)requestSignUpWith:(NSString *)accountStr AndPwd:(NSString *)passwordStr AndCode:(NSString *)codeStr completion:(CallbackSimpleCompletion)handler;

/** 找回密码 */
- (void)requestFindPwdWith:(NSString *)accountStr AndPwd:(NSString *)passwordStr AndCode:(NSString *)codeStr completion:(CallbackSimpleCompletion)handler;


@end

NS_ASSUME_NONNULL_END

