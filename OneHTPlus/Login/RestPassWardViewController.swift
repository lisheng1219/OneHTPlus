//
//  RestPassWardViewController.swift
//  OneHTPlus
//
//  Created by lisheng on 17/9/27.
//  Copyright © 2017年 LS Software. All rights reserved.
//

import UIKit

class RestPassWardViewController: UIViewController {
    //用户头像
    @IBOutlet weak var headPortraitView: UIView!
    //email
    @IBOutlet weak var emailTextField: UITextField!
    //验证码
    @IBOutlet weak var verifyCodeTextField: UITextField!
    //获取验证码按钮
    @IBOutlet weak var getVerifyCodeButton: UIButton!
    //密码
    @IBOutlet weak var passwardTextField: UITextField!
    //确认按钮
    @IBOutlet weak var confirmButton: UIButton!
    //设置默认视图
    func setDefaultView() {
        //头像变成圆形
        headPortraitView.layer.masksToBounds = true
        headPortraitView.layer.cornerRadius = headPortraitView.frame.height / 2.0
        //登录按钮圆角
        confirmButton.layer.masksToBounds = true
        confirmButton.layer.cornerRadius = confirmButton.frame.height / 2.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置默认视图
        setDefaultView()
        
    }
    
    //获取验证码按钮事件
    @IBAction func getVerifyCodeAction(_ sender: Any) {
    }
    //确认按钮
    @IBAction func confirmAction(_ sender: Any) {
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
