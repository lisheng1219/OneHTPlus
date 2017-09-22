//
//  RestRequestException.swift
//  OneHTPlus
//
//  Created by lisheng on 17/9/2.
//  Copyright © 2017年 LS Software. All rights reserved.
//


import Foundation

public enum RestRequestException: Error {
    // 系统返回错误异常
    case restServiceSystemErrorCode(errorCode: String, type: String, description: String, httpStatusCode: Int, data: NSDictionary?)
    // 业务服务器异常（请求失败时未返回系统错误码，请求地址或参数发生错误时的异常，例如 404 一些非系统定义错误码等）
    case restServiceDefaultError
    // 应用端异常（目前支持 json 解析失败，网络异常导致连接超时等）
    case restServiceAppError
    // 无更多数据
    case restNoMoreData
    // 无网络
    case restServiceNotNetwork
    //无搜索结果
    case noSearchResult
}

public func == (
    lhs: RestRequestException,
    rhs: RestRequestException)
    -> Bool
{
    switch (lhs, rhs) {
    case (RestRequestException.restServiceDefaultError, RestRequestException.restServiceDefaultError):
        return true
    case (RestRequestException.restServiceAppError, RestRequestException.restServiceAppError):
        return true
    case (RestRequestException.restServiceNotNetwork, RestRequestException.restServiceNotNetwork):
        return true
    default:
        return false
    }
}
