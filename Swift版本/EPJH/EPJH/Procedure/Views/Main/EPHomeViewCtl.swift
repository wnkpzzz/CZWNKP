//
//  EPHomeViewCtl.swift
//  EPJH
//
//  Created by Hans on 2020/8/3.
//  Copyright © 2020 hans3d. All rights reserved.
//

import UIKit


class EPHomeViewCtl: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
        
    }


    
    @IBAction func clickAction(_ sender: Any) {
       
      // 请求参数
        var params = [String: AnyObject]()
        params["partyId"] = UserInfoManager.getUid() as AnyObject? 
        UserApi().requestGetUserInfo(params: params) { (isSuccess, msgStr) in
           

        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        AppJump.goLoginVC()
    }
    

}
