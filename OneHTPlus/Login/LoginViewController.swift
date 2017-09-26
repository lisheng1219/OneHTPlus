//
//  LoginViewController.swift
//  OneHTPlus
//
//  Created by lisheng on 17/9/26.
//  Copyright © 2017年 LS Software. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //头像
    @IBOutlet weak var headPortraitView: UIView!
    //Email
    @IBOutlet weak var emailTextField: UITextField!
    //用户密码
    @IBOutlet weak var passwardTextField: UITextField!
    //登录按钮
    @IBOutlet weak var loginButton: UIButton!
    
    //设置默认视图
    func setDefaultView() {
        //头像变成圆形
        headPortraitView.layer.masksToBounds = true
        headPortraitView.layer.cornerRadius = headPortraitView.frame.height / 2.0
        //登录按钮圆角
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = loginButton.frame.height / 2.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置默认视图
        setDefaultView()

    }
    //登录按钮事件
    @IBAction func loginAction(_ sender: Any) {
        //登录成功后跳转到主storyboard
        jumpMain()
    }

    //jumptoMainStoryboard
    func jumpMain() {
        let storyboard = UIStoryboard(name: StringContants.MAIN_STORYBOARD, bundle: nil)
        
        let mainTabBarController = storyboard.instantiateViewController(withIdentifier: StringContants.MAIN_TABBAR_CONTROLLER)
        
        self.present(mainTabBarController, animated: true, completion: nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
