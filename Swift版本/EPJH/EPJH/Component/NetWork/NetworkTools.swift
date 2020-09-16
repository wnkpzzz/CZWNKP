//
//  NetworkTools.swift
//  EPJH
//
//  Created by Hans on 2020/8/5.
//  Copyright © 2020 hans3d. All rights reserved.
//


import Foundation
import Alamofire
import MBProgressHUD

/** 枚举 */
@objc enum NetMethod: Int {
    case GET
    case POST
}
 
class NetworkTools: NSObject {

    /** 设置单例 */
    static let shared = NetworkTools()
     
    /** 配置请求头 */
    lazy var httpHeaders: HTTPHeaders = {
        var headers: HTTPHeaders = [:]
        if UserInfoManager.getToken() != "" {
            headers["Cookie"] = "JSESSIONID=" + UserInfoManager.getToken()
        }
        return headers
    }()
    
    /** SessionManager */
    lazy var almofireManager: Session = {
         let config = URLSessionConfiguration.default
         config.timeoutIntervalForRequest = 30
         let session = Session(configuration: config)
         return session
    }()
 
    /*!
     * @Alamofire
     *
     * @普通POST、GET请求
     *
     * @url 请求网址
     *
     * @params 请求参数JSON
     *
     * @isShowLog 控制是否打印请求和返回数据的输出开关
     *
     * @isShowMask 控制是否请求出现蒙版效果
     *
     * @isWithToken 控制是否拼接Token
     *
     * @success/failure 返回请求数据，请求结果，提示数据
     *
     */
     func requestNetData(urlStr : String,
                              params : [String: AnyObject]? = nil,
                              method : NetMethod = .POST,
                              isShowLog  : Bool = true,
                              isShowMask : Bool = true,
                              isWithToken : Bool = false,
                              success:@escaping(_ result:Any)->(),
                              failure:@escaping(_ fail:Any)->()){
                              
        /// 菊花延迟开关
        isShowMask ? MBProgressHUD.showInWindow() : ()
        /// 请求类型
        let httpMethod: HTTPMethod = method == .GET ? .get : .post
        /// Token自动拼接开关
        var parameters = params
        if  parameters == nil { parameters = [String : AnyObject]() }
        parameters!["uid"]  =  UserInfoManager.getUid() as AnyObject
        parameters!["token"] = UserInfoManager.getToken() as AnyObject
 
        AF.request(urlStr,
                method: httpMethod,
                parameters: parameters,
                encoding: URLEncoding.default,
                headers: httpHeaders,
                interceptor: nil).responseJSON { (response) in

                /// 菊花延迟开关
                isShowMask ? MBProgressHUD.hiddenInWindow() : ()
                /// 日志输出开关
                isShowLog ?  DLog(" \n 请求地址:\(urlStr) \n 请求参数:\(params ?? ["空":"空" as AnyObject]) \n 返回数据:\(String(describing: response.result.value)) ") : ()
                /// 返回数据处理
                self.handleResult(response: response, success: success, failure: failure)
  
        }
   
    }
 
    func handleResult(response: DataResponse<Any>,
                      success:@escaping(_ result:Any)->(),
                      failure:@escaping(_ fail:Any)->()){

        switch response.result {
        case .success:

          var resultDic:[String : Any] = [:]
          if let result = response.result.value as? [String : Any] { resultDic = result }
          if let code = resultDic["statusCode"] as? String { if code == AppWarnCode { AppJump.exitLogin() }}
                   
          success(resultDic as Any)

          break
        case .failure:

          failure(response.result.error as Any)
          
          break
        }

    }

}
