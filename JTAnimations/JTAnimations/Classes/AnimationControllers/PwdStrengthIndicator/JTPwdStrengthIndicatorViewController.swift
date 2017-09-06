//
//  JTPwdStrengthIndicatorViewController.swift
//  JTAnimations
//
//  Created by BJT on 2017/9/5.
//  Copyright © 2017年 BJT. All rights reserved.
//  参考自原作者:
//  André Schneider, [@_schneiderandre](http://twitter.com/_schneiderandre)
//
//  密码强度指示器

import UIKit

class JTPwdStrengthIndicatorViewController: JTBaseViewController {

    fileprivate var pwdStrengthIndicatorView:JTPwdStrengthIndicatorView!
    fileprivate var passwordTextField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navView?.setNavBar(withTitle: title)
        view.backgroundColor =  UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        
        addPasswordTextField()
        addPasswordStrengthView()
    }
    deinit {
        print("deinit-JTPwdStrengthIndicatorViewController")
    }
    
    private func addPasswordTextField(){
        
        let leftPaddingView =  UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        
        passwordTextField = UITextField()
        passwordTextField.leftView = leftPaddingView
        passwordTextField.leftViewMode = .always
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.backgroundColor = UIColor(white: 1, alpha: 0.8)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.cornerRadius = 2.0
        passwordTextField.placeholder = "请输入密码"
        passwordTextField.becomeFirstResponder()
        
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
       contentView?.addSubview(passwordTextField)
        
        contentView?.addConstraints(
            NSLayoutConstraint.constraints(
                                withVisualFormat: "H:|-[passwordTextField]-|",
                                options: [],
                                metrics: nil,
                                views: ["passwordTextField":passwordTextField]
            )
        )
        
        contentView?.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-(200)-[passwordTextField(==36)]",
                options: [],
                metrics: nil,
                views: ["passwordTextField":passwordTextField]
            )
        )
        
    }
    private func addPasswordStrengthView(){
        
        pwdStrengthIndicatorView = JTPwdStrengthIndicatorView()
        contentView?.addSubview(pwdStrengthIndicatorView)
        pwdStrengthIndicatorView.backgroundColor = UIColor(white: 1, alpha: 0.8)
        
        contentView?.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-[pwdStrengthIndicatorView]-|",
                options: [],
                metrics: nil,
                views: ["pwdStrengthIndicatorView":pwdStrengthIndicatorView]
            )
        )
        
        contentView?.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:[passwordTextField]-[pwdStrengthIndicatorView(==10)]",
                options: [],
                metrics: nil,
                views: ["passwordTextField":passwordTextField,
                        "pwdStrengthIndicatorView" : pwdStrengthIndicatorView]
            )
        )
    }
    
}


extension JTPwdStrengthIndicatorViewController{
    
    /// 根据输入密码长度,改变密码强度指示view 的强度状态
    ///
    /// - parameter textField: passwordTextField
    @objc fileprivate func textFieldDidChange(textField:UITextField){
        
        let length = textField.text!.characters.count
        if (length < 1) {
            pwdStrengthIndicatorView.strengthStatus = .none
            return;
        }
        
        if (length < 4) {
            pwdStrengthIndicatorView.strengthStatus = .weak;
            return;
        }
        
        if (length < 8) {
            pwdStrengthIndicatorView.strengthStatus = .fair;
            return;
        }
        
        pwdStrengthIndicatorView.strengthStatus = .strong;
        
    }
    

    
}

