//
//  UserApi.swift
//  EPJH
//
//  Created by Hans on 2020/8/4.
//  Copyright © 2020 hans3d. All rights reserved.
//

import UIKit
import Foundation


class UserApi: NSObject {

    //MARK: - 用户登录请求
    public func requestLogin(params: [String : AnyObject], completion: @escaping (_ isSuccess: Bool, _ msgStr: String?) -> ()) {
  
       
         NetworkTools().requestNetData(urlStr: URL_user_signin, params: params, method: .POST, isShowLog: true, isShowMask: true, isWithToken: false, success: { (result) in
            
                if let resultDic = result as? [String : Any],let code = resultDic["statusCode"] as? String {
 
                    if code == "200" {
                         
                        UserInfoManager.setToken(token: resultDic["sid"] as! String)
                        if let userInfoDic = resultDic["partyView"] as? [String : Any]  {
                            UserInfoManager.setUid(uid: userInfoDic["id"] as! String)
                        }
                         
                        AppJump.goHomeVC()
                    }
                }
            
             completion(true,"")
            
        }) { (error) in
            
              completion(false,"")
        }
    }
    
       //MARK: - 用户信息
       public func requestGetUserInfo(params: [String : AnyObject], completion: @escaping (_ isSuccess: Bool, _ msgStr: String?) -> ()) {
     
        
            NetworkTools().requestNetData(urlStr: URL_user_info, params: params, method: .GET, isShowLog: true, isShowMask: true, isWithToken: false, success: { (result) in
               
                   if let resultDic = result as? [String : Any],let code = resultDic["statusCode"] as? String {
    
                       if code == "200" {
                            
                          DLog("-------\(resultDic)====")
                       }
                   }
               
                completion(true,"")
               
           }) { (error) in
               
                 completion(false,"")
           }
       }
    
    
}
