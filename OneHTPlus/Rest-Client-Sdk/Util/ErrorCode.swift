//
//  ErrorCode.swift
//  OneHTPlus
//
//  Created by lisheng on 17/9/2.
//  Copyright © 2017年 LS Software. All rights reserved.
//


import Foundation

class ErrorCode {
    
    /*************************公共基础错误码***********************/
    
    /**
     * 公共基础异常
     */
//    let ERROR_00100 = RestRequestException.restServiceSystemErrorCode(errorCode: "00100", type: "公共基础异常", description: "公共基础异常", httpStatusCode: 500, data: nil)
    
    // 集合
    var restRequestExceptions = [RestRequestException]()
    
    init() {
//        restRequestExceptions.append(ERROR_00100)
    }
    
    /**
     * 根据错误 code 获取相应的 ErrorCode
     * @param exceptionCode 错误 code
     * @param exceptionData 错误 data
     * @return RestRequestException
     */
    
    
    let errorDescription = ExceptionHandler.onErrorHandler(error: .restServiceAppError).object(forKey: StringContants.RESPONSE_DATA_DESCRIPTION) as! String
    let errorDescriptions = ExceptionHandler.onErrorHandler(error: .restServiceAppError).object(forKey: StringContants.RESPONSE_DATA_DESCRIPTION)
    
    func valueOfErrorCode (exceptionCode: String, exceptionData: NSDictionary?) -> RestRequestException {
        if !exceptionCode.isEmpty { // 非空判断
            // 轮询所有的错误码
            
            for restRequestException in restRequestExceptions {
                switch restRequestException {
                case .restServiceSystemErrorCode(let errorCode, let type, let description, let httpStatusCode, _): // 系统返回错误码时
                    if exceptionCode == errorCode { // 非空判断，并且 errorCode 相等时返回相应的错误
                        
                        if (errorCode == StringContants.INVALID_TOKEN_CODE || errorCode == StringContants.EXPIRE_TOKEN_CODE || errorCode == StringContants.EXPIRE_REFRSH_TOKEN_CODE || errorCode == StringContants.MULTI_LOGIN_KICK_CODE){
                            //token 失效在其它地方登录了
//                            NotificationCenter.default.post(name: Notification.Name(rawValue: StringContants.NOTIFICATIO_TOKEN_FAILED), object: errorCode)
                        }
                        
                        if exceptionData != nil  { // 非空判断
                            return .restServiceSystemErrorCode(errorCode: errorCode, type: type, description: description, httpStatusCode: httpStatusCode, data: exceptionData)
                        }
                        return restRequestException
                    }
                    
                case .restServiceNotNetwork:
                    //无网络
                    NotificationCenter.default.post(name: Notification.Name(rawValue: StringContants.NO_NET_WORK), object: nil)
                default: // 错误码未匹配时，返回默认的错误码
                    return .restServiceAppError
                }
            }
            // 错误码未匹配时，返回默认的错误码
            return .restServiceAppError
        } else { // 返回的错误码没有值（服务器端返回异常）
            return .restServiceDefaultError
        }
    }
}

