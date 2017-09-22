//
//  AppUtils.swift
//  OneHTPlus
//
//  Created by lisheng on 17/9/2.
//  Copyright © 2017年 LS Software. All rights reserved.
//

import UIKit

class AppUtils {
    
    /**
     *  获取屏幕的宽
     *
     *  @return 屏幕的宽
     */
    class func getDisplayWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    /**
     *  获取屏幕的高
     *
     *  @return 屏幕的高
     */
    class func getDisplayHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    /**
     *  获取屏幕的分辨率
     *
     *  @return 屏幕的分辨率
     */
    class func getDisplayResolution() -> String {
        return "\(getDisplayWidth())*\(getDisplayHeight())"
    }
    
    
    // 获取系统版本
    class func getSystemVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    // 获取 App 的版本号
    class func getAppVersion() -> String? {
        let infoDic = Bundle.main.infoDictionary
        return infoDic?["CFBundleShortVersionString"] as? String
    }
    
    
    // 获取设备的 UUID
    class func getDeviceUUID() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
    
}
