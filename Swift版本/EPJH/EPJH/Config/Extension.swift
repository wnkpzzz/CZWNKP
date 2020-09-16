//
//  Extension.swift
//  EPJH
//
//  Created by Hans on 2020/8/4.
//  Copyright © 2020 hans3d. All rights reserved.
//

import UIKit
import Foundation
import MBProgressHUD
 
extension MBProgressHUD{
   
    /** 蒙版效果展示在Window */
    class func showInWindow(){
       if UIApplication.shared.keyWindow != nil{
           MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
       }
    }
    /** 蒙版效果从Window移除 */
    class func hiddenInWindow(){
        if UIApplication.shared.keyWindow != nil{
             MBProgressHUD.hide(for: UIApplication.shared.keyWindow!, animated: true)
         }
    }
    
}

extension UIWindow {

   class func getKeywindows() -> UIWindow? {
     
        var window:UIWindow? = nil
     
        if #available(iOS 13.0, *) {
     
            for windowScene:UIWindowScene in ((UIApplication.shared.connectedScenes as?  Set<UIWindowScene>)!) {
     
                if windowScene.activationState == .foregroundActive {
     
                    window = windowScene.windows.first
     
                  break
                }
            }
     
            return window
     
        }else{
     
            return  UIApplication.shared.keyWindow
     
        }
    }
     

}
