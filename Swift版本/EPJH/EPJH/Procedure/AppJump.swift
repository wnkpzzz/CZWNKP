//
//  AppJump.swift
//  EPJH
//
//  Created by Hans on 2020/8/3.
//  Copyright © 2020 hans3d. All rights reserved.
//

import UIKit

class AppJump: NSObject {

    //  引导页
    class func goGuideVC(){

    //        let window = UIApplication.shared.delegate?.window
    //        window??.rootViewController = PageViewCtl()
    }
    //  登录页
    class func goLoginVC(){
//
        let navCtl = RootNavigationController()
        navCtl.addChild(EPLoginViewCtl()) 
        let window = UIApplication.shared.delegate?.window
        window??.rootViewController = navCtl
         
         
    }
    //  主页面
    class func goHomeVC(){
        let window = UIApplication.shared.delegate?.window
        window??.rootViewController = EPHomeViewCtl()
    }
    //  退出登录
    class func exitLogin(){

        // 设置退出标志
        UserDefaults.standard.removeObject(forKey: String.kUToken)
        UserDefaults.standard.removeObject(forKey: String.kUserID)
        UserDefaults.standard.synchronize()
        // 逻辑调整登录页面
        AppJump.goLoginVC()
 
    }

}
