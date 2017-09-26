//
//  BaseTableViewController.swift
//  OneHTPlus
//
//  Created by lisheng on 17/9/23.
//  Copyright © 2017年 LS Software. All rights reserved.
//

import UIKit
import Async


// MARK: - 操作接口
protocol BaseTableViewDelegate {
    // 清除数据
    func clearData()
    // 刷新数据
    func refreshData()
}

// MARK: - 数据接口
@objc protocol BaseTableViewDataSource {
    
    // 首次加载数据
    func firstLoadData()
    // 加载更多数据
    func loadMoreData()
    
    // 点击跳转
    @objc optional func emptyDataSetDidTapButton()
}

class BaseTableViewController: UITableViewController {
    // 数据源
    var dataSource: BaseTableViewDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        // 去除tableView 多余行的方法 添加一个tableFooterView 后面多余行不再显示
        self.tableView.tableFooterView = UIView()
        // 设置上拉刷新下拉加载
        if self.dataSource != nil {
            self.tableView.rfHeader = RefreshHeaderView(action: {
                self.dataSource!.firstLoadData()
            })
            self.tableView.rfFooter = RefreshFooterView(action: {
                self.dataSource!.loadMoreData()
            })
            // 新建刷新数据
            Async.main() {
                self.tableView?.startHeaderRefresh()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
