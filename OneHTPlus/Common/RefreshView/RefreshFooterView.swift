//
//  RefreshFooterView.swift
//  Eageye
//
//  Created by mac on 16/5/13.
//  Copyright © 2016年 sakaiPeng. All rights reserved.
//

import UIKit

class RefreshFooterView: UIView {

	/*
	 // Only override drawRect: if you perform custom drawing.
	 // An empty implementation adversely affects performance during animation.
	 override func drawRect(rect: CGRect) {
	 // Drawing code
	 }
	 */

	fileprivate var scrollView: UIScrollView?

	fileprivate var textLabel: UILabel!

	fileprivate var actIndicator: UIActivityIndicatorView?

	var stateStr: String = "已显示全部内容" {
		didSet {
			textLabel.text = stateStr
		}
	}

	var refreshAction: (() -> Void)?

	var status: XLRefreshStatus {
		didSet {
			switch status {
			case .normal:
				textLabel.text = stateStr
			case .refreshing:
				textLabel.isHidden = true
				footerRefreshing()
			case .endRefresh:
				actIndicator?.stopAnimating()
				textLabel.isHidden = false
			default:
				break
			}
		}
	}

	// MARK: - Initializer
	override init(frame: CGRect) {

		status = .normal

		super.init(frame: frame)

		self.frame.size.height = XLRefreshFooterHeight

		self.textLabel = UILabel()
		self.textLabel.textAlignment = .center
		self.textLabel.textColor = UIColor.darkGray
		self.textLabel.font = UIFont.systemFont(ofSize: 12)
		self.textLabel.text = stateStr
		self.addSubview(textLabel)

		self.backgroundColor = UIColor.clear
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	convenience init(action: @escaping () -> Void) {
		self.init()
		self.refreshAction = action
	}

	// MARK: - UIView methods override
	override func layoutSubviews() {
		super.layoutSubviews()

		textLabel.frame.size = frame.size

	}

	override func willMove(toSuperview newSuperview: UIView?) {

		super.willMove(toSuperview: newSuperview)

		if let superV = superview as? UIScrollView {
			superV.removeObserver(self, forKeyPath: XLContentOffsetPath)
			superV.removeObserver(self, forKeyPath: XLContentSizePath)
		}

		if let newView = newSuperview as? UIScrollView {

			frame.size.width = newView.frame.width
			frame.origin.x = 0

			scrollView = newView

			scrollView?.contentInset.bottom += frame.height

			scrollView?.addObserver(self, forKeyPath: XLContentOffsetPath, options: [.new, .old], context: nil)
			scrollView?.addObserver(self, forKeyPath: XLContentSizePath, options: [.new, .old], context: nil)

		}
	}

	// MARK: - KVO
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {

		let scrollContentH = scrollView!.contentSize.height
		let visualH = scrollContentH + scrollView!.contentInset.top + scrollView!.contentInset.bottom

		if keyPath == XLContentSizePath {

			frame.size.width = scrollView!.frame.width

			// 可视距离小于屏幕高度，内容不足一个屏幕
			if visualH < scrollView!.frame.height {
				// 显示在屏幕最下方
				frame.origin.y = scrollView!.frame.height// - scrollView!.contentInset.bottom
			} else {
				// 显示在内容最下方
				frame.origin.y = scrollView!.contentSize.height
			}

		}

		if keyPath == XLContentOffsetPath {

			if status == .endRefresh {
				status = .normal
			}

			guard status == .normal else {
				return
			}

			// curOffsetY上滑是正值，下滑是负值
			let curOffset = ((change! as NSDictionary)["new"] as AnyObject).cgPointValue
			let curOffsetY = curOffset == nil ? 0 : curOffset!.y
			// 拉动距离差，当前窗口位置+窗口高度 - 内容高度
			var pullLen = curOffsetY + scrollView!.frame.height - scrollContentH

			// 可视距离小于屏幕高度，内容不足一个屏幕
			if visualH < scrollView!.frame.height {
				pullLen = curOffsetY + scrollView!.contentInset.top + scrollView!.contentInset.bottom
				if pullLen > scrollView!.contentInset.bottom {
					status = .refreshing
				}
			} else {
				// 滑动窗口最下面40像素是加载更多窗口，当触发加载更多
				if pullLen > -40 {
					status = .refreshing
				}
			}
		}

	}

	// MARK: - Customed refresh action
	func footerRefreshing() {
		if actIndicator == nil {
			actIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
			actIndicator!.frame = bounds
			addSubview(actIndicator!)
		}

		actIndicator!.startAnimating()

		refreshAction?()
	}

	func endRefresh() {
		status = .endRefresh
	}
}
