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

    let ERROR_1001 = RestRequestException.restServiceSystemErrorCode(errorCode: "1001", type: "code is not empty", description: "校验码不能为空", httpStatusCode: 500, data: nil)
    let ERROR_1002 = RestRequestException.restServiceSystemErrorCode(errorCode: "1002", type: "email is not empty", description: "email不能为空", httpStatusCode: 500, data: nil)
    let ERROR_1003 = RestRequestException.restServiceSystemErrorCode(errorCode: "1003", type: "regist is fail", description: "注册失败", httpStatusCode: 500, data: nil)
    let ERROR_1004 = RestRequestException.restServiceSystemErrorCode(errorCode: "1004", type: "token is illegal", description: "token 失效或者不正确", httpStatusCode: 500, data: nil)
    let ERROR_1005 = RestRequestException.restServiceSystemErrorCode(errorCode: "1005", type: "Email does not exist or password is incorrect", description: "密码不正确或者用户不存在", httpStatusCode: 500, data: nil)
    let ERROR_2001 = RestRequestException.restServiceSystemErrorCode(errorCode: "2001", type: "collections name can not be null", description: "收藏夹名字不能为空", httpStatusCode: 500, data: nil)
    let ERROR_2002 = RestRequestException.restServiceSystemErrorCode(errorCode: "2002", type: "this collections does not exist", description: "没有这个收藏夹", httpStatusCode: 500, data: nil)
    let ERROR_2003 = RestRequestException.restServiceSystemErrorCode(errorCode: "2003", type: "this article does not exist", description: "没有这个文章", httpStatusCode: 500, data: nil)
    let ERROR_2004 = RestRequestException.restServiceSystemErrorCode(errorCode: "2004", type: "this article does exist", description: "这个文章已经存在", httpStatusCode: 500, data: nil)
    let ERROR_2005 = RestRequestException.restServiceSystemErrorCode(errorCode: "2005", type: "this article in the blacklist", description: "url地址在黑名单中", httpStatusCode: 500, data: nil)
    let ERROR_2006 = RestRequestException.restServiceSystemErrorCode(errorCode: "2006", type: "this article not in this collections", description: "没有在这个收藏夹中找到该文章", httpStatusCode: 500, data: nil)
    let ERROR_2007 = RestRequestException.restServiceSystemErrorCode(errorCode: "2007", type: "tag does not exist", description: "没有在这个标签", httpStatusCode: 500, data: nil)
    let ERROR_3001 = RestRequestException.restServiceSystemErrorCode(errorCode: "3001", type: "this user does not exist", description: "未找到该用户", httpStatusCode: 500, data: nil)
    let ERROR_9001 = RestRequestException.restServiceSystemErrorCode(errorCode: "9001", type: "Illegal parameter calibration", description: "参数校验不合法", httpStatusCode: 500, data: nil)
    let ERROR_9401 = RestRequestException.restServiceSystemErrorCode(errorCode: "9401", type: "not login", description: "没有登录", httpStatusCode: 500, data: nil)
    let ERROR_9403 = RestRequestException.restServiceSystemErrorCode(errorCode: "9403", type: "not auth", description: "没有权限", httpStatusCode: 500, data: nil)
    let ERROR_9404 = RestRequestException.restServiceSystemErrorCode(errorCode: "9404", type: "not fond", description: "未找到", httpStatusCode: 500, data: nil)
    let ERROR_9999 = RestRequestException.restServiceSystemErrorCode(errorCode: "9999", type: "system error", description: "其他系统错误", httpStatusCode: 500, data: nil)

    
    
    // 集合
    var restRequestExceptions = [RestRequestException]()
    
    init() {
        restRequestExceptions.append(ERROR_1001)
        restRequestExceptions.append(ERROR_1002)
        restRequestExceptions.append(ERROR_1003)
        restRequestExceptions.append(ERROR_1004)
        restRequestExceptions.append(ERROR_1005)
        restRequestExceptions.append(ERROR_2001)
        restRequestExceptions.append(ERROR_2002)
        restRequestExceptions.append(ERROR_2003)
        restRequestExceptions.append(ERROR_2004)
        restRequestExceptions.append(ERROR_2005)
        restRequestExceptions.append(ERROR_2006)
        restRequestExceptions.append(ERROR_2007)
        restRequestExceptions.append(ERROR_3001)
        restRequestExceptions.append(ERROR_9001)
        restRequestExceptions.append(ERROR_9401)
        restRequestExceptions.append(ERROR_9403)
        restRequestExceptions.append(ERROR_9404)
        restRequestExceptions.append(ERROR_9999)
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

