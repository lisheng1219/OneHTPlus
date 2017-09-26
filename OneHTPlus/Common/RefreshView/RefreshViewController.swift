//
//  RefreshViewController.swift
//  Eageye
//  
//  下拉刷新，上拉加载通用组件
//
//  Created by mac on 16/5/4.
//  Copyright © 2016年 sakaiPeng. All rights reserved.
//

import UIKit

class RefreshViewController: UIViewController {
    
    //是否加载更多
    var loadMoreEnabled:Bool = false
    //加载更多视图
    var infiniteScrollingView:UIView?
    //下载刷新标准
    var refreshing: Bool = false {
        didSet {
            if (self.refreshing) {
                
                if self.refreshControl?.isRefreshing == false {
                    self.refreshControl?.beginRefreshing()
                }
                self.refreshControl?.attributedTitle = NSAttributedString(string: "  载入中")
                print("Loading...")
            }
            else {
                
                self.refreshControl?.endRefreshing()
                self.refreshControl?.attributedTitle = NSAttributedString(string: "  松手刷新")
                print("Loaded & set:Pull to Refresh")
            }
        }
    }
    var refreshControl: UIRefreshControl?

    override func viewDidLoad() {
        super.viewDidLoad()

        //添加下拉刷新控件
        self.refreshControl = UIRefreshControl()
        
        //增加上拉刷新控件
        self.setupInfiniteScrollingView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //增加上拉加载控件
    fileprivate func setupInfiniteScrollingView() {
        self.infiniteScrollingView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        self.infiniteScrollingView!.autoresizingMask = UIViewAutoresizing.flexibleWidth
        self.infiniteScrollingView!.backgroundColor = UIColor.white
        let activityViewIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        activityViewIndicator.color = UIColor.darkGray
        activityViewIndicator.frame = CGRect(x: self.infiniteScrollingView!.frame.size.width/2-activityViewIndicator.frame.width/2, y: self.infiniteScrollingView!.frame.size.height/2-activityViewIndicator.frame.height/2, width: activityViewIndicator.frame.width, height: activityViewIndicator.frame.height)
        activityViewIndicator.startAnimating()
        self.infiniteScrollingView!.addSubview(activityViewIndicator)
    }
    
    
    class InfiniteScrollingView:UIView{
        override init(frame: CGRect) {
            super.init(frame: frame)
            autoresizingMask = UIViewAutoresizing.flexibleWidth
            backgroundColor = UIColor.white
            let activityViewIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
            activityViewIndicator.color = UIColor.darkGray
            activityViewIndicator.frame = CGRect(x: frame.size.width/2-activityViewIndicator.frame.width/2, y: frame.size.height/2-activityViewIndicator.frame.height/2, width: activityViewIndicator.frame.width, height: activityViewIndicator.frame.height)
            activityViewIndicator.startAnimating()
            addSubview(activityViewIndicator)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
