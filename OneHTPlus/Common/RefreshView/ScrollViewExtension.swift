//
//  ScrollViewExtension.swift
//  Eageye
//
//  Created by mac on 16/5/13.
//  Copyright © 2016年 sakaiPeng. All rights reserved.
//

import UIKit

extension UIScrollView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    fileprivate struct AssociatedKeys {
        static var refreshHeader = "RefreshHeaderViewKey"
        static var refreshFooter = "RefreshFooterViewKey"
    }
    
    var rfHeader: RefreshHeaderView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.refreshHeader) as? RefreshHeaderView
        }
        set {
            if let oldValue = self.rfHeader {
                oldValue.removeFromSuperview()
            }
            
            if let newValue = newValue {
                self.addSubview(newValue)
            }
            objc_setAssociatedObject(self, &AssociatedKeys.refreshHeader, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var rfFooter: RefreshFooterView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.refreshFooter) as? RefreshFooterView
        }
        set {
            if let oldValue = self.rfFooter {
                oldValue.removeFromSuperview()
            }
            
            if let newValue = newValue {
                self.addSubview(newValue)
            }
            objc_setAssociatedObject(self, &AssociatedKeys.refreshFooter, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func startHeaderRefresh() {
        self.rfHeader?.startRefresh()
    }
    
    public func endHeaderRefresh() {
        self.rfHeader?.endRefresh()
    }
    
    public func endFooterRefresh() {
        self.rfFooter?.endRefresh()
    }
}
