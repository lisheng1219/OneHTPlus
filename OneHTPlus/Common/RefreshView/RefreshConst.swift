//
//  RefreshConst.swift
//  Eageye
//
//  Created by mac on 16/5/13.
//  Copyright © 2016年 sakaiPeng. All rights reserved.
//
import UIKit

enum XLRefreshStatus: Int {
	case normal
	case willRefresh
	case refreshing
	case showMessage
	case endRefresh
}

let XLStateMap = ["\(XLRefreshStatus.normal)": "下拉刷新",
	"\(XLRefreshStatus.willRefresh)": "松开刷新",
	"\(XLRefreshStatus.refreshing)": "载入中",
	"\(XLRefreshStatus.showMessage)": "",
	"\(XLRefreshStatus.endRefresh)": "刷新X条数据"]

let XLRefreshHeaderHeight: CGFloat = 60.0 // 44.0
let XLRefreshFooterHeight: CGFloat = 40.0

let XLContentOffsetPath = "contentOffset"
let XLContentSizePath = "contentSize"
