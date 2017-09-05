//
//  JTNavView.swift
//  JTAnimations
//
//  Created by BJT on 2017/9/3.
//  Copyright © 2017年 BJT. All rights reserved.
//

import UIKit

class JTNavView: UIView {

    fileprivate var backBtn:UIButton?
    fileprivate var titleLabel:UILabel?
    
    convenience init(withTarget target:Any, Action action:Selector){
        
        self.init(frame:CGRect(x: 0, y: 0, width: kScreenSzie.width, height: kNavBarHeight))
        
        let btn = UIButton();
        btn.setImage(UIImage(named: "backIconVer2"), for: .normal)
        btn.addTarget(target, action: action, for: .touchUpInside)
        backBtn = btn
        
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Heiti SC", size: 20)
        titleLabel.textColor = UIColor(red: 46/255.0, green: 201/255.0, blue: 220/255.0, alpha: 0.9)
        self.titleLabel = titleLabel
        
        addSubview(titleLabel)
        addSubview(btn)
        isUserInteractionEnabled = true
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let btnWH = 40
        backBtn?.frame.size.width = CGFloat(btnWH)
        backBtn?.frame.size.height = CGFloat(btnWH)
        backBtn?.frame.origin.x = 10;
        backBtn?.frame.origin.y = (frame.size.height - CGFloat(btnWH)) * 0.5;
        
        titleLabel?.center.x = center.x;
        titleLabel?.center.y = center.y;
        
    }
    
    
}
// MARK: - 提供给外界的方法
extension JTNavView{
    
    func setNavBar(withTitle title:String?,andColor titleColor:UIColor?=nil){
    
        titleLabel?.text = title
        if titleColor != nil {
            
            titleLabel?.textColor = titleColor
        }
        titleLabel?.sizeToFit()
        
    }
    
    
    func insertSubviewBelowBackBtn(view:UIView){
        
        insertSubview(view, belowSubview: backBtn!)
        
    }
    
    
}

