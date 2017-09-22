//
//  StringContants.swift
//  OneHTPlus
//
//  Created by lisheng on 17/9/2.
//  Copyright © 2017年 LS Software. All rights reserved.
//


import Foundation

class StringContants {
    
    // 异常：错误码
    static let RESPONSE_DATA_ERROR_CODE = "error_code"
    // 异常：rest
    static let RESPONSE_DATA_REST_ERRORCODE = "errorCode"
    // 异常：错误数据
    static let RESPONSE_DATA_ERROR_DATA = "data"
    // 异常：错误消息
    static let RESPONSE_DATA_ERROR_MESSAGE = "error_message"
    // 异常：描述信息
    static let RESPONSE_DATA_DESCRIPTION = "description"
    // 日志：rest-client-sdk
    static let LOG_REST_CLIENT_SDK = "rest-client-sdk:"
    // 日志：app
    static let LOG_APP = "app:"
    //mainStroyboard 的名称
    static let MAIN_STORYBOARD = "Main"
    // 常量：空字符串
    static let CONSTANT_EMPTY = ""
    // 常量：空格字符串
    static let CONSTANT_SPACE = " "
    // 常量：20102
    static let ERROR_CODE_20102 = "20102"
    
    
    // 字典key   results
    static let DICTIONARY_KEY_RESULTS = "results"
    // 字典key   nowTime
    static let DICTIONARY_KEY_NOW_TIME = "nowTime"
    // 字典key   topicId
    static let DICTIONARY_KEY_TOPIC_ID = "topicId"
    // 字典key   indexOfErrorWords
    static let DICTIONARY_KEY_INDEX_OF_ERRORWORDS = "indexOfErrorWords"
    // 字典key   errorWord
    static let DICTIONARY_KEY_ERRORWORD = "errorWord"
    // 字典key   success
    static let DICTIONARY_KEY_SUCCESS = "success"
    // 字典key   message
    static let DICTIONARY_KEY_MESSAGE = "message"
    
    
    // 请求返回：异常
    static let RESPONSE_RESULT_EXCEPTION = "exception"
    // 请求返回：结果
    static let RESPONSE_RESULT_RESULT = "result"
    // 请求返回：结果
    static let RESPONSE_RESULT_TRUE = "true"
    
    //无网络
    static let NO_NET_WORK = "NO_NET_WORK"
    //token 不存在 当前token被重新刷新后（在别处登录）
    static let INVALID_TOKEN_CODE = "11011"
    //token 过期 token失效了
    static let EXPIRE_TOKEN_CODE = "11012"
    //刷新 token 过期 刷新token失效了
    static let EXPIRE_REFRSH_TOKEN_CODE = "11013"
    //网络连接失败
    static let NETWORK_FIELD_CODE = "99999"
    //搜索无内容
    static let NO_SEARCH_RESULT_CODE = "88888"
    //网络连接失败
    static let MULTI_LOGIN_KICK_CODE = "11111"
}

