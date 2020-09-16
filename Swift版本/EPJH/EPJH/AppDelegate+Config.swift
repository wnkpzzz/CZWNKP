//
//  AppDelegate+Config.swift
//  EPJH
//
//  Created by Hans on 2020/8/3.
//  Copyright © 2020 hans3d. All rights reserved.
//

import UIKit
import Foundation
 import IQKeyboardManagerSwift

extension AppDelegate {
    
    // 第三方SDK配置
    func configAppSetting(launchOptions:[UIApplication.LaunchOptionsKey: Any]?) {
        
        // IQKeyboardManagerSwift
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    
    // 初始化窗口
    func initWindow() {
        
          window = UIWindow(frame: UIScreen.main.bounds); window?.backgroundColor = UIColor.white
          AppJump.goLoginVC()
          window?.makeKeyAndVisible()
    }
    
    // 基础UI配置
    func configAppUI() {
          
        // 设置导航栏背景颜色，
        UINavigationBar.appearance().barTintColor = UIColor.white
        
        // 设置状态栏字体颜色TODO
        
        
        // 设置导航栏字体
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        
        // 设置 TabBar 背景颜色，
        UITabBar.appearance().barTintColor = UIColor.white
        
        // 设置 TabBar 字体颜色
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.gray], for:UIControl.State())
        
        // 设置 TabBar 选中图标颜色
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().tintColor = UIColor.red
        
        // 设置 TabBar 选中字体颜色
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.red], for:.selected)
    }
}
