//
//  JTBaseViewController.swift
//  JTAnimations
//
//  Created by BJT on 2017/9/3.
//  Copyright © 2017年 BJT. All rights reserved.
// 基类控制器

import UIKit

class JTBaseViewController: UIViewController {

    /// 导航条,
    var navView:JTNavView?
    
    /// 内容视图
    var contentView:UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        // 设置子控件
        setupViews()
    }
    

}

extension JTBaseViewController{
 
    
    func setupViews(){

        let navViewTemp = JTNavView(withTarget: self, Action:#selector(back))
        navViewTemp.backgroundColor = UIColor.clear
        view.addSubview(navViewTemp)
        navView = navViewTemp
        
        
        let x = CGFloat(0)
        let y = kNavBarHeight
        let w = kScreenSzie.width
        let h = kScreenSzie.height - (navView?.frame.size.height)!
        let contentViewTemp = UIView(frame: CGRect(x: x, y: y, width: w, height: h))
        contentViewTemp.backgroundColor = UIColor.clear
        view.addSubview(contentViewTemp)
        contentView = contentViewTemp
        
    }
    
    
     /// MARK: pop 返回上级控制器
     @objc func back(){
        
       _ = navigationController?.popViewController(animated: true)
    }
    
    
}
