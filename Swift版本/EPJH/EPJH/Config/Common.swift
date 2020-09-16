//
//  Common.swift
//  EPJH
//
//  Created by Hans on 2020/8/5.
//  Copyright © 2020 hans3d. All rights reserved.
//

import UIKit
import Foundation
 
/** 请求返回正确码 */
let AppNetCode    : String  = "200"
/** 请求顶号校验码 */
let AppWarnCode   : String  = "84512"


// MARK: - 相关尺寸（注：此高度暂时没有适配Iphone X）
let App_Width      =    UIScreen.main.bounds.width
let App_Height     =    UIScreen.main.bounds.height
let Nav_Height     :    CGFloat = 64
let Tabbar_Height  :    CGFloat = 49

// MARK:- 颜色方法
func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

// MARK:- 字符串方法
extension String {
    
    static let appName   = "WNKP"
    static let appDevID  = UIDevice.current.identifierForVendor?.uuidString.replacingOccurrences(of: "-", with: "")

    // MARK: - 关键Key
    static let kUToken             = "kUToken"      // 用户令牌
    static let kUserID             = "kUserID"      // 用户ID
    static let kPhoneNum           = "kPhoneNum"    // 用户手机号
 
    // MARK: - 第三方
    static let kWeChatKey          = "wx9405d1ddcf"    // 微信
    static let kMAMapKey           = "ef5002393f35b72e61a65d" // 高德地图


}

// MARK:- 自定义打印方法
func DLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\(fileName):(\(lineNum))-\(message)")
    #endif
}
