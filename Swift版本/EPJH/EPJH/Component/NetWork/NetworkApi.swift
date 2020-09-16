//
//  NetworkApi.swift
//  EPJH
//
//  Created by Hans on 2020/8/5.
//  Copyright © 2020 hans3d. All rights reserved.
//


import Foundation


let AppHost                = "http://112.74.35.130:8080/app-admin"  // 根域名

// 登录
let URL_user_signin              = "\(AppHost)/api/biz/ou/v1/partys/login.htm" // 登录
let URL_user_info                = "\(AppHost)/api/biz/ou/v1/partys/get.htm" // 获取用户信息

let URL_user_register            = "\(AppHost)user/signup" // 注册
let URL_user_forgetPwd           = "\(AppHost)user/forgetpassword" // 找回密码
let URL_user_getCode             = "\(AppHost)user/sendverifycode" // 获取短信验证码



// 用户信息
