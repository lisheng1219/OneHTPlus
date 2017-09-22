//
//  AlamofireRequestFactory.swift
//  OneHTPlus
//
//  Created by lisheng on 17/9/2.
//  Copyright © 2017年 LS Software. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import AdSupport

class AlamofireRequestFactory {
    
    // 请求头 Header
    var headerStr: [String: String]
    
    // Header key：用户信息
    private let HTTP_HEADER_USER_AGENT: String = "User-Agent"
    // Header key：认证信息
    private let HTTP_HEADER_ACCESS_TOKEN: String = "Authorization"
    // Header key：编码信息
    private let HTTP_HEADER_ACCEPT_ENCODING: String = "Accept-Encoding"
    // Header key：session_id
    fileprivate let HTTP_SESSION_ID: String = "session_id"
    
    /**
     初始化
     */
    init() {
        // 初始化请求头
        
        headerStr = [String: String]()
        // 设置用户信息（client_info）
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let clientInfo = appDelegate.clientInfo
        if clientInfo != nil {
            headerStr[HTTP_HEADER_USER_AGENT] = clientInfo!
        }
        // 设置用户认证信息（access_token）
        let systemAccessToken = appDelegate.accessToken
        if (systemAccessToken != nil && systemAccessToken!.access_token != nil) {
            headerStr[HTTP_HEADER_ACCESS_TOKEN] = "oauth2 \(systemAccessToken!.access_token!)"
        }
        // 设置编码信息（Accept-Encoding）
        headerStr[HTTP_HEADER_ACCEPT_ENCODING] = "gzip;q=1.0, compress;q=0.5"
        
        // 设置 session_id
        let sessionId = AppUtils.getDeviceUUID()
        if (sessionId != nil) {
            headerStr[HTTP_SESSION_ID] = sessionId!
        }
        
        
        // // 设置请求超时时间
        // let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        // configuration.timeoutIntervalForRequest = 60 // 秒
        // configuration.timeoutIntervalForResource = 20 // 秒
        // configuration.protocolClasses!.insert(<#T##newElement: Element##Element#>, atIndex: Int)
        // let manager = Alamofire.Manager(configuration: configuration)
    }
    
    /**
     rest 服务请求
     返回值为普通实体类
     */
    func onRestRequest<T: ResponseObjectSerializable> (method: HTTPMethod, url: String, param: Parameters?, onRequestResult: @escaping (_ result: T?) -> Void, onRequestError: ((_ error: RestRequestException) -> Void)?) {
        
        //无网络判断
        let networkManager = NetworkReachabilityManager(host: "www.baidu.com")
        guard networkManager?.networkReachabilityStatus != .notReachable else{	onRequestError!(RestRequestException.restServiceNotNetwork); return}
        
        let request: DataRequest = Alamofire.request(url, method: method, parameters: param, encoding: URLEncoding.default, headers: headerStr)
        
        request.responseObject { (response: DataResponse<T?>) in
            switch response.result {
            case .success(let value):
                onRequestResult(value)
            case .failure(let error):
                if (onRequestError != nil) {
                    onRequestError!(error as! RestRequestException)
                } else {
                    _ = ExceptionHandler.onErrorHandler(error: error as! RestRequestException)
                }
            }
        }
    }
    
    /**
     rest 服务请求
     返回值为普通实体类的集合
     */
    func onRestRequestCollection<T: ResponseCollectionSerializable> (method: HTTPMethod, url: String, param: Parameters?, onRequestResult: @escaping (_ result: [T]?) -> Void, onRequestError: ((_ error: RestRequestException) -> Void)?) {
        
        //无网络判断
        let networkManager = NetworkReachabilityManager(host: "www.baidu.com")
        guard networkManager?.networkReachabilityStatus != .notReachable else{	onRequestError!(RestRequestException.restServiceNotNetwork); return}
        
        let request: DataRequest = Alamofire.request(url, method: method, parameters: param, encoding: URLEncoding.default, headers: headerStr)
        
        request.responseCollection { (response: DataResponse<[T]?>) in
            switch response.result {
            case .success(let value):
                onRequestResult(value)
            case .failure(let error):
                if (onRequestError != nil) {
                    onRequestError!(error as! RestRequestException)
                } else {
                    _ = ExceptionHandler.onErrorHandler(error: error as! RestRequestException)
                }
            }
        }
    }
    
    /**
     rest 服务请求
     返回值为基本数据类型
     */
    func onRestRequestBasis<T> (method: HTTPMethod, url: String, param: Parameters?, onRequestResult: @escaping (_ result: T?) -> Void, onRequestError: ((_ error: RestRequestException) -> Void)?) {
        
        //无网络判断
        let networkManager = NetworkReachabilityManager(host: "www.baidu.com")
        guard networkManager?.networkReachabilityStatus != .notReachable else{	onRequestError!(RestRequestException.restServiceNotNetwork); return}
        
        let request: DataRequest = Alamofire.request(url, method: method, parameters: param, encoding: URLEncoding.default, headers: headerStr)
        
        request.responseBasis { (response: DataResponse<T?>) in
            switch response.result {
            case .success(let value):
                onRequestResult(value)
            case .failure(let error):
                if (onRequestError != nil) {
                    onRequestError!(error as! RestRequestException)
                } else {
                    _ = ExceptionHandler.onErrorHandler(error: error as! RestRequestException)
                }
            }
        }
    }
    
}

