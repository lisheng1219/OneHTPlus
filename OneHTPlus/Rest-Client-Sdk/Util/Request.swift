//
//  Request.swift
//  OneHTPlus
//
//  Created by lisheng on 17/9/2.
//  Copyright © 2017年 LS Software. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

/**
 Alamofire 请求扩展
 */
extension DataRequest {
    
    
    /**
     Alamofire 请求
     返回为普通实体类
     */
    @discardableResult
    public func responseObject<T: ResponseObjectSerializable> (completionHandler: @escaping (DataResponse <T?>) -> Void) -> Self {
        
        let responseSerializer = DataResponseSerializer<T?> { request, response, data, error in
            
            guard error == nil else { // 非系统返回错误
                return .failure(RestRequestException.restServiceDefaultError)
            }
            
            // 相应状态码
            let responseStatusCode = response?.statusCode
            
            let jsonResponseSerializer = DataRequest.stringResponseSerializer(encoding: String.Encoding.utf8)
            
            let result = jsonResponseSerializer.serializeResponse(request, response, data, error)
            
            switch result {
            case .success:
                switch responseStatusCode! {
                case 200: // 访问成功
                        if data != nil {
                            do {
                                let resultJSON = try JSON(data: data!)
                                if let responseObject = T(responseJSON: resultJSON) { // 正常返回并且正常解析
                                    return .success(responseObject)
                                }
                                return .failure(RestRequestException.restServiceAppError) // JSON 解析出错
                            }catch{
                                return .success(nil) // 没有返回值
                            }
                        }
                        return .success(nil) // 没有返回值
                case 400, 500: // 系统返回错误码
                    if data != nil {
                        do {
                            let errorJSON = try JSON(data: data!)
                            let errorStr = errorJSON["\(StringContants.RESPONSE_DATA_ERROR_CODE)"].stringValue
                            var errorData = errorJSON["\(StringContants.RESPONSE_DATA_ERROR_DATA)"].dictionaryObject
                            let errorMessageString =  errorJSON["\(StringContants.RESPONSE_DATA_ERROR_MESSAGE)"].string
                            if let jsonData = errorMessageString?.data(using: String.Encoding.utf8,allowLossyConversion: false){
                                //把JSON字符串转成json对象
                                let swiftJson = try JSON.init(data: jsonData)
                                let dic = swiftJson.dictionaryObject
                                if errorData == nil {
                                    errorData = dic
                                }
                            }
                            let errorCode = ErrorCode()
                            let restRequestResponseError = errorCode.valueOfErrorCode(exceptionCode: errorStr, exceptionData: errorData as NSDictionary?)
                            return .failure(restRequestResponseError)
                        }catch{
                            return .failure(RestRequestException.restServiceDefaultError) // 异常时未返回系统错误码
                        }
                    }
                    return .failure(RestRequestException.restServiceDefaultError) // 异常时未返回系统错误码
                default: // 非系统返回错误码（一般不考虑该情况，容错处理，默认错误提示 例如 404 等异常）
                    print("\(StringContants.LOG_REST_CLIENT_SDK) 非系统返回错误码（一般不考虑该情况，容错处理，默认错误提示.例如404等异常）StatusCode=\(responseStatusCode!)")
                    return .failure(RestRequestException.restServiceDefaultError)
                }
            case .failure(let error): // 请求失败，业务服务器异常，例如网络异常导致连接超时等
                print("\(StringContants.LOG_REST_CLIENT_SDK)请求失败，业务服务器异常，例如连接超时等.StatusCode=\(responseStatusCode)\n\(error)")
                return .failure(RestRequestException.restServiceAppError)
            }
        }
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
    
    
    /**
     Alamofire 请求
     返回为普通实体类集合
     */
    @discardableResult
    public func responseCollection<T: ResponseCollectionSerializable>(completionHandler: @escaping (DataResponse<[T]?>) -> Void) -> Self {
        
        let responseSerializer = DataResponseSerializer<[T]?> { request, response, data, error in
            guard error == nil else { // 非系统返回错误
                return .failure(RestRequestException.restServiceDefaultError)
            }
            // 相应状态码
            let responseStatusCode = response?.statusCode
            let jsonResponseSerializer = DataRequest.stringResponseSerializer(encoding: String.Encoding.utf8)
            let result = jsonResponseSerializer.serializeResponse(request, response, data, error)
            switch result {
            case .success:
                switch responseStatusCode! {
                case 200: // 访问成功
                        if data != nil {
                            do {
                                let resultJSON = try JSON(data: data!)
                                if let responseObject = T.collection(responseJSON: resultJSON) {
                                    return .success(responseObject)
                                }
                                return .failure(RestRequestException.restServiceAppError) // JSON 解析出错
                            }catch{
                                return .success(nil) // 没有返回值
                            }
                        }
                        return .success(nil) // 没有返回值
                case 400, 500: // 系统返回错误码
                    if data != nil {
                        do {
                            let errorJSON = try JSON(data: data!)
                            let errorStr = errorJSON["\(StringContants.RESPONSE_DATA_ERROR_CODE)"].stringValue
                            let errorData = errorJSON["\(StringContants.RESPONSE_DATA_ERROR_DATA)"].dictionaryObject
                            let errorCode = ErrorCode()
                            let restRequestResponseError = errorCode.valueOfErrorCode(exceptionCode: errorStr, exceptionData: errorData as NSDictionary?)
                            return .failure(restRequestResponseError)
                        }catch{
                            return .failure(RestRequestException.restServiceDefaultError) // 异常时未返回系统错误码
                        }
                    }
                    return .failure(RestRequestException.restServiceDefaultError) // 异常时未返回系统错误码
                default: // 非系统返回错误码（一般不考虑该情况，容错处理，默认错误提示 例如 404 等异常）
                    print("\(StringContants.LOG_REST_CLIENT_SDK) 非系统返回错误码（一般不考虑该情况，容错处理，默认错误提示.例如404等异常）StatusCode=\(responseStatusCode!)")
                    return .failure(RestRequestException.restServiceDefaultError)
                }
            case .failure(let error): // 请求失败，业务服务器异常，例如网络异常导致连接超时等
                print("\(StringContants.LOG_REST_CLIENT_SDK)请求失败，业务服务器异常，例如连接超时等.StatusCode=\(responseStatusCode)\n\(error)")
                return .failure(RestRequestException.restServiceAppError)
            }
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
    
    
    /**
     Alamofire 请求
     返回为基本数据类型
     */
    @discardableResult
    public func responseBasis<T> (completionHandler: @escaping (DataResponse <T?>) -> Void) -> Self {
        
        let responseSerializer = DataResponseSerializer<T?> { request, response, data, error in
            
            guard error == nil else { // 非系统返回错误
                return .failure(RestRequestException.restServiceDefaultError)
            }
            
            // 相应状态码
            let responseStatusCode = response?.statusCode
            
            let jsonResponseSerializer = DataRequest.stringResponseSerializer(encoding: String.Encoding.utf8)
            
            let result = jsonResponseSerializer.serializeResponse(request, response, data, error)
            
            switch result {
            case .success:
                switch responseStatusCode! {
                case 200: // 访问成功
                    
                    if result.value != nil {
                        let responseObject = result.value as! T
                        return .success(responseObject)
                    }
                    return .success(nil) // 没有返回值
                case 400, 500: // 系统返回错误码
                    if data != nil {
                        do {
                            let errorJSON = try JSON(data: data!)
                            let errorStr = errorJSON["\(StringContants.RESPONSE_DATA_ERROR_CODE)"].stringValue
                            let errorData = errorJSON["\(StringContants.RESPONSE_DATA_ERROR_DATA)"].dictionaryObject
                            let errorCode = ErrorCode()
                            let restRequestResponseError = errorCode.valueOfErrorCode(exceptionCode: errorStr, exceptionData: errorData as NSDictionary?)
                            return .failure(restRequestResponseError)
                        }catch{
                            return .failure(RestRequestException.restServiceDefaultError) // 异常时未返回系统错误码
                        }
                    }
                    return .failure(RestRequestException.restServiceDefaultError) // 异常时未返回系统错误码
                    
                default: // 非系统返回错误码（一般不考虑该情况，容错处理，默认错误提示 例如 404 等异常）
                    print("\(StringContants.LOG_REST_CLIENT_SDK) 非系统返回错误码（一般不考虑该情况，容错处理，默认错误提示.例如404等异常）StatusCode=\(responseStatusCode!)")
                    return .failure(RestRequestException.restServiceDefaultError)
                }
            case .failure(let error): // 请求失败，业务服务器异常，例如网络异常导致连接超时等
                print("\(StringContants.LOG_REST_CLIENT_SDK)请求失败，业务服务器异常，例如连接超时等.StatusCode=\(responseStatusCode)\n\(error)")
                return .failure(RestRequestException.restServiceAppError)
            }
        }
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}

