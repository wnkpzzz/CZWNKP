//
//  UserModel.swift
//  EPJH
//
//  Created by Hans on 2020/8/4.
//  Copyright © 2020 hans3d. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

class UserModel: NSObject, StaticMappable {
 
    /** 设置单例 */
    static let shared = UserModel()
    
    /** 用户Token */
    var token: String?
    
    private override init() {
           
        super.init()
   }
   
   static func objectForMapping(map: Map) -> BaseMappable? {
       
       shared.mapping(map: map)
       
       return shared
   }
    
    func mapping(map: Map) {
        
    }
}
