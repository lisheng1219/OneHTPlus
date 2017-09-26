//
//  RefreshHeaderView.swift
//  Eageye
//
//  Created by mac on 16/5/13.
//  Copyright © 2016年 sakaiPeng. All rights reserved.
//

import UIKit
import Kingfisher

class RefreshHeaderView: UIView {

	/*
	 // Only override drawRect: if you perform custom drawing.
	 // An empty implementation adversely affects performance during animation.
	 override func drawRect(rect: CGRect) {
	 // Drawing code
	 }
	 */

	fileprivate var scrollView: UIScrollView?

	fileprivate var contentView: UIView!

	fileprivate var actIndicator: UIActivityIndicatorView!

	fileprivate var arrowView: UIImageView!

	fileprivate var textLabel: UILabel!

	var msg: String?

	var stateMap: [String: String]? {
		didSet {
			if let state = stateMap?["\(status)"] {
				textLabel.text = state
			}
		}
	}

	var status: XLRefreshStatus {
		didSet {
			switch status {
			case .normal:
				textLabel.text = stateMap?["normal"] ?? XLStateMap["normal"]
				self.scrollView?.contentInset.top = 0
			case .willRefresh:
				willRefresh()
			case .refreshing:
				headerRefresh()
			case .showMessage:
				textLabel.text = msg
			case .endRefresh:
				UIView.animate(withDuration: 0.4, animations: {
					self.scrollView?.contentInset.top = 0// -= XLRefreshHeaderHeight
				})
				textLabel.text = stateMap?["normal"] ?? XLStateMap["normal"]
				if actIndicator != nil && actIndicator.isAnimating {
					actIndicator.stopAnimating()
				}
				arrowView.transform = CGAffineTransform(rotationAngle: CGFloat(0))
				arrowView.isHidden = false
			}
		}
	}

	var refreshAction: (() -> Void)!

	// MARK: ---- 初始化 ----
	override init(frame: CGRect) {
		status = .normal

		super.init(frame: frame)

		self.frame.size.height = XLRefreshHeaderHeight

		self.contentView = UIView(frame: CGRect(x: 0, y: 0, width: 130, height: 30))

		// 下拉箭头
		let arrowV = UIImageView.init(image: UIImage.init(named: "arrow_refresh"))
		arrowV.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
		arrowV.contentMode = .scaleAspectFit
		self.arrowView = arrowV
		self.contentView.addSubview(arrowV)

		// 文本
		let textL = UILabel(frame: CGRect(x: 30, y: 0, width: 100, height: 30))
		textL.textAlignment = .left
		textL.text = XLStateMap["\(XLRefreshStatus.normal)"]
		self.textLabel = textL
		self.textLabel.textColor = UIColor.darkGray
		self.textLabel.font = UIFont.systemFont(ofSize: 14)

		self.contentView.addSubview(textL)

		self.addSubview(self.contentView)

		self.backgroundColor = UIColor.clear
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	convenience init(action: @escaping () -> Void) {
		self.init()
		self.refreshAction = action
	}

	// MARK: ---- 覆盖UIView的方法 ----
	override func layoutSubviews() {
		super.layoutSubviews()
		// 居中
        /*!
         解决居中便宜问题
         
         */
		contentView.center = CGPoint(x: (bounds.width) / 2 + 25 , y: bounds.height / 2)
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
			frame.origin.y = -XLRefreshHeaderHeight - newView.contentInset.top

			scrollView = newView
			scrollView?.alwaysBounceVertical = true

			scrollView?.addObserver(self, forKeyPath: XLContentOffsetPath, options: [.new, .old], context: nil)
			scrollView?.addObserver(self, forKeyPath: XLContentSizePath, options: [.new, .old], context: nil)

		}
	}

	// MARK: ---- KVO ----
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {

		if keyPath == XLContentSizePath {
			frame.size.width = scrollView!.frame.width
		}
		else if keyPath == XLContentOffsetPath {

			if status == .endRefresh {
				status = .normal
			}

			guard status != .refreshing else {
				return
			}

			let curOffset = ((change! as NSDictionary)["new"]! as AnyObject).cgPointValue
			let releaseLen = scrollView!.contentInset.top + XLRefreshHeaderHeight // 释放长度

//            print("releaseLen:\(releaseLen)  curOffset.y:\(curOffset.y)")

			// 30为下移偏移量，下拉90才会进入松开加载的状态
//            if scrollView!.dragging && status == .Normal && curOffset.y + 30 < -releaseLen {
			if status == .normal && curOffset!.y < -releaseLen { // + 25 <= -releaseLen {
				status = .willRefresh
			} else if status == .willRefresh {
				let oldOffset = ((change! as NSDictionary)["old"]! as AnyObject).cgPointValue
				if curOffset!.y > oldOffset!.y {
					status = .refreshing
				}
			}
		}
	}

	// MARK: ---- Customed refresh action ----
	func willRefresh() {
		textLabel.text = stateMap?["willRefresh"] ?? XLStateMap["willRefresh"]
		UIView.animate(withDuration: 0.3, animations: {
			self.arrowView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
			if self.scrollView?.isDragging == false {
//            self.scrollView?.contentInset.top = XLRefreshHeaderHeight
				self.scrollView?.contentOffset.y = -XLRefreshHeaderHeight
			}
		}) 

	}

	func headerRefresh() {
		scrollView?.contentInset.top += XLRefreshHeaderHeight
		arrowView.isHidden = true
		textLabel.text = stateMap?["refreshing"] ?? XLStateMap["refreshing"]
		if actIndicator == nil {
			actIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
			actIndicator.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
			contentView.addSubview(actIndicator)
		}

		actIndicator.startAnimating()
		refreshAction?()
	}

	func startRefresh() {
		scrollView?.setContentOffset(CGPoint(x: 0, y: -(XLRefreshHeaderHeight + 5)), animated: true)
	}

	func endRefresh() {
		status = .endRefresh
	}

	func showMesageAction(_ msg: String) {
		self.msg = msg
		status = .showMessage
	}

//    // MARK: - Get resource in self resource bundle
//    func imageWithName(name: String) -> UIImage? {
//        var img: UIImage?
//        let fwBundle = NSBundle(forClass: RefreshHeaderView.self)
//        if let resBundlePath = fwBundle.pathForResource("XLRefreshSwift", ofType: "bundle") {
//            if let resBundle = NSBundle(path: resBundlePath) {
//                img = UIImage(named: name, inBundle: resBundle, compatibleWithTraitCollection: nil)
//            }
//        }
//        return img
//    }

}
