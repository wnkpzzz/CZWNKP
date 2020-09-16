//
//  RootViewController.swift
//  EPJH
//
//  Created by Hans on 2020/8/3.
//  Copyright © 2020 hans3d. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    public var isPull = false

     override func viewDidLoad() {
         super.viewDidLoad()

         // 所有坐标在Nav下面下移64个单位为（0.0）
         self.edgesForExtendedLayout = UIRectEdge()
     }

     // 点击任何界面关闭键盘
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         super.touchesBegan(touches, with: event) 
        UIApplication.shared.windows.first?.endEditing(true)
     }
     
     override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
         // Dispose of any resources that can be recreated.
     }
     

     /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
     }
     */

}
