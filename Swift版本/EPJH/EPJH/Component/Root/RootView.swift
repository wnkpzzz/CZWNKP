//
//  RootView.swift
//  EPJH
//
//  Created by Hans on 2020/8/3.
//  Copyright © 2020 hans3d. All rights reserved.
//

import UIKit

class RootView: UIView {
 
   // MARK:- 纯代码初始化函数
   
    convenience init() {
       self.init(frame: CGRect.zero)
    }

    override init(frame: CGRect) {
       super.init(frame: frame)
       setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)

    }
      
    private func setupSubviews() {


    }

    override func layoutSubviews() {
        super.layoutSubviews()

    }

    // MARK:- XIB初始化函数
    func loadViewFromNib() -> UIView {
         let className = type(of: self)
         let bundle = Bundle(for: className)
         let name = NSStringFromClass(className).components(separatedBy: ".").last
         let nib = UINib(nibName: name!, bundle: bundle)
         let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
         return view
     }
    
    /** 显示弹框视图 */
    func showPopView()  {  UIApplication.shared.windows.first?.addSubview(self) }
    
    /** 隐藏弹框视图 */
    func dismissPopView()  { self.removeFromSuperview() }
   

}
