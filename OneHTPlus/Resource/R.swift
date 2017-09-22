//
//  R.swift
//  OneHTPlus
//
//  Created by lisheng on 17/9/2.
//  Copyright © 2017年 LS Software. All rights reserved.
//

import UIKit

class R {
    
    enum color: String {
        case default_background = "#F1F100"
    }
    
    enum image {
//        case add_event_platform_down_icon
    }
    
    enum string {
//        case about_theme
    }
    
}

extension NSObject {
    
    func color(_ r: R.color) -> UIColor {
        let argb = r.rawValue
        
        var alpha: CGFloat = 1.0
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        if argb.hasPrefix("#") {
            let index   = argb.characters.index(argb.startIndex, offsetBy: 1)
            let hex     = argb.substring(from: index)
            let scanner = Scanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexInt64(&hexValue) {
                switch (hex.characters.count) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat( hexValue & 0x00F)             / 15.0
                case 4:
                    alpha = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    red   = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    green = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    blue  = CGFloat( hexValue & 0x000F)            / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat( hexValue & 0x0000FF)          / 255.0
                case 8:
                    alpha = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    red   = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    green = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    blue  = CGFloat( hexValue & 0x000000FF)        / 255.0
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
                }
            } else {
                print("Scan hex error")
            }
        } else {
            print("Invalid RGB string, missing '#' as prefix", terminator: "")
        }
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func image(_ r: R.image) -> UIImage? {
        return UIImage(named: String(describing: r))
    }
    
    func string(_ r: R.string) -> String {
        return NSLocalizedString(String(describing: r), tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func getColor(_ r: R.color) -> UIColor {
        return color(r)
    }
    
    func getImage(_ r: R.image) -> UIImage? {
        return image(r)
    }
    
    func getString(_ r: R.string) -> String {
        return string(r)
    }
}
