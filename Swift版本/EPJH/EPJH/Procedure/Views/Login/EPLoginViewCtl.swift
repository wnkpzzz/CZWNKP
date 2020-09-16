//
//  EPLoginViewCtl.swift
//  EPJH
//
//  Created by Hans on 2020/8/5.
//  Copyright © 2020 hans3d. All rights reserved.
//

import UIKit

class EPLoginViewCtl: RootViewController {

     override func viewDidLoad() {
        super.viewDidLoad()

        title = "12312"
        
    }

    @IBAction func signInAction(_ sender: Any) {
         
   
        
        // 请求参数
        var params = [String: AnyObject]()
        params["phone"] = "17688899301" as AnyObject?
        params["passWord"] = "e10adc3949ba59abbe56e057f20f883e" as AnyObject?
        UserApi().requestLogin(params: params) { (isSuccess, msgStr) in }
            
      }
    
    @IBAction func signUpAction(_ sender: Any) {
       
        self.navigationController?.pushViewController(EPHomeViewCtl(), animated: true)
            
    }
    
}
