//
//  RegisterViewController.swift
//  OneHTPlus
//
//  Created by lisheng on 17/9/27.
//  Copyright © 2017年 LS Software. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    //用户头像
    @IBOutlet weak var headPortraitView: UIView!
    //email
    @IBOutlet weak var emailTextField: UITextField!
    //用户名
    @IBOutlet weak var nameTextField: UITextField!
    //验证码
    @IBOutlet weak var verifyCodeTextField: UITextField!
    //获取验证码按钮
    @IBOutlet weak var getVerifyCodeButton: UIButton!
    //密码
    @IBOutlet weak var passwardTextField: UITextField!
    //注册按钮
    @IBOutlet weak var registerButton: UIButton!
    
    //设置默认视图
    func setDefaultView() {
        //头像变成圆形
        headPortraitView.layer.masksToBounds = true
        headPortraitView.layer.cornerRadius = headPortraitView.frame.height / 2.0
        //登录按钮圆角
        registerButton.layer.masksToBounds = true
        registerButton.layer.cornerRadius = registerButton.frame.height / 2.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置默认视图
        setDefaultView()
    
    }
    //获取验证码按钮事件
    @IBAction func getVerifyCodeAction(_ sender: Any) {
    }
    //注册按钮事件
    @IBAction func registerAction(_ sender: Any) {
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
