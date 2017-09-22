//
//  ExceptionHandler.swift
//  OneHTPlus
//
//  Created by lisheng on 17/9/2.
//  Copyright © 2017年 LS Software. All rights reserved.
//

import Foundation

class ExceptionHandler {
    
    // 真正处理请求异常的方法（默认异常处理）
    static func onErrorHandler(error: RestRequestException) -> NSMutableDictionary {
        let errorDic = NSMutableDictionary()
        var errorStr = ""
        switch error {
        case .restServiceSystemErrorCode(let errorCode, _, let description, _, let data):
            errorStr = description
            errorDic.setObject(errorCode, forKey: StringContants.RESPONSE_DATA_REST_ERRORCODE as NSCopying)
            if data != nil  {
                errorDic.setObject(data!, forKey: StringContants.RESPONSE_DATA_ERROR_DATA as NSCopying)
            }
            print("\(StringContants.LOG_APP) ExceptionHandler 系统错误 \(errorStr)")
        case .restServiceDefaultError:
            errorStr = NSLocalizedString("systemErrorPleaseWait", comment: "")
            print("\(StringContants.LOG_APP) ExceptionHandler 服务器异常 \(error)")
        case .restServiceAppError:
            errorStr = NSLocalizedString("dataErrorPleaseWait", comment: "")
            print("\(StringContants.LOG_APP) ExceptionHandler app 转换错误 \(error)")
        case .restNoMoreData:
            errorStr = NSLocalizedString("noMoreData", comment: "")
            print(errorStr)
        case .restServiceNotNetwork:
            errorStr = NSLocalizedString("connectionFieldPleaseWait", comment: "")
            print(errorStr)
        case .noSearchResult:
            errorStr = NSLocalizedString("haveNoSearch", comment: "")
            errorDic.setObject("88888", forKey: StringContants.RESPONSE_DATA_REST_ERRORCODE as NSCopying)
            print(errorStr)
        }
        errorDic.setObject(errorStr, forKey: StringContants.RESPONSE_DATA_DESCRIPTION as NSCopying)
        return errorDic
    }
}
