//
//  UserInfoManager.swift
//  EPJH
//
//  Created by Hans on 2020/8/4.
//  Copyright © 2020 hans3d. All rights reserved.
//

import UIKit
import Foundation




class UserInfoManager: NSObject {
 
    //MARK: - 保存获取Token
    class func setToken(token:String){
        UserDefaults.standard.set(token, forKey: String.kUToken)
        UserDefaults.standard.synchronize()
    }
    class func getToken()->String{
        if let token = UserDefaults.standard.object(forKey: String.kUToken) as? String{
            return token
        }
        return ""
    }
    
    //MARK: - 保存获取Uid
     class func setUid(uid:String){
         UserDefaults.standard.set(uid, forKey: String.kUserID)
         UserDefaults.standard.synchronize()
     }
     class func getUid()->String{
         if let uid = UserDefaults.standard.object(forKey: String.kUserID) as? String{
             return uid
         }
         return ""
     }
    
    
    //MARK: - 保存获取登录手机
    class func setLoginPhone(loginPhone:String){
        UserDefaults.standard.set(loginPhone, forKey: String.kPhoneNum)
        UserDefaults.standard.synchronize()
    }
    class func getLoginPhone()->String{
        if let loginPhone = UserDefaults.standard.object(forKey: String.kPhoneNum) as? String{
            return loginPhone
        }
        return ""
    }
    
    //MARK: - 清除数据
     class func clearUserData(){
     
     }
    
}
