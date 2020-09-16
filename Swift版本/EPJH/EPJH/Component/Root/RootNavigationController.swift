//
//  RootNavigationController.swift
//  EPJH
//
//  Created by Hans on 2020/8/3.
//  Copyright © 2020 hans3d. All rights reserved.
//

import UIKit

class RootNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    /**重写push方法*/
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        
        if self.viewControllers.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true
            
            let  leftBtn = UIButton.init(type: .custom)
            leftBtn.bounds = CGRect.init(x: 0, y: 0, width: 40, height: 18)
            leftBtn.addTarget(self, action: #selector(RootNavigationController.popViewController(animated:)), for: .touchUpInside)
            leftBtn.setImage(UIImage.init(named: "icon_common_back"), for: UIControl.State())
            leftBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 12)
            let leftItem = UIBarButtonItem.init(customView: leftBtn)
            viewController.navigationItem.leftBarButtonItem = leftItem
      
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    
    func back() {
        popViewController(animated: true)
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
