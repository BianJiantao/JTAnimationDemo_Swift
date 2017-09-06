//
//  JTPwdStrengthIndicatorView.swift
//  JTAnimations
//
//  Created by BJT on 2017/9/5.
//  Copyright © 2017年 BJT. All rights reserved.
// 密码强度指示view

import UIKit

/** 密码强度的状态 */
enum PwdStrengthIndicatorViewStatus:Int {
    
    case none = 0, weak,fair,strong
}

class JTPwdStrengthIndicatorView: UIView {

    fileprivate var indicatorView:UIView!
    var strengthStatus:PwdStrengthIndicatorViewStatus = .none{
        didSet{
            animateIndicatorViewToStatus(status: strengthStatus)
        }
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        backgroundColor = UIColor(white: 0, alpha: 0.05)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 2
        addIndicatorView()
    
    }
    
    private func animateIndicatorViewToStatus(status:PwdStrengthIndicatorViewStatus)
    {
        // 嵌套函数,只在内部使用
        func colorForStatus(status:PwdStrengthIndicatorViewStatus)->UIColor{
            
                switch (status) {
                
                    case .none:
                        return UIColor.white
                    case .weak:
                        return UIColor(red: 231/255.0, green: 76/255.0, blue: 60/255.0, alpha: 1) // 红色
                    case .fair:
                        return UIColor(red: 241/255.0, green: 196/255.0, blue: 15/255.0, alpha: 1) // 黄色
                    case .strong:
                        return UIColor(red: 46/255.0, green: 204/255.0, blue: 113/255.0, alpha: 1) // 绿色
                
                }
        }
        
        
        for constraint in constraints.enumerated(){
            
            if constraint.element.firstAttribute == .width {
                removeConstraint(constraint.element)
                break
            }
        }
        
        addConstraint(NSLayoutConstraint(item: indicatorView,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .width,
                                         multiplier:  multiplierForStatus(status: strengthStatus),
                                         constant: 0.0))
        
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: [],
                       animations: { 
                            self.layoutIfNeeded()
                            self.indicatorView.backgroundColor = colorForStatus(status: self.strengthStatus)
                        },
                       completion:nil)
        
    }

    
    private func multiplierForStatus(status:PwdStrengthIndicatorViewStatus)->CGFloat{
        
        switch (status) {
            
        case .none:
            return 0.0;
        case .weak:
            return 0.33;
        case .fair:
            return 0.66;
        case .strong:
            return 1.0;
            
        }
    }
    
    private func addIndicatorView(){
        
        indicatorView = UIView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false;
        indicatorView.layer.cornerRadius = layer.cornerRadius;
        addSubview(indicatorView)
        
        addConstraint(NSLayoutConstraint(item: indicatorView,
                                          attribute: .height,
                                          relatedBy: .equal,
                                          toItem: self,
                                          attribute: .height,
                                          multiplier: 1.0,
                                          constant: 0.0))
        
        addConstraint(NSLayoutConstraint(item: indicatorView,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .width,
                                         multiplier: multiplierForStatus(status: strengthStatus),
                                         constant: 0.0))
        
        addConstraint(NSLayoutConstraint(item: indicatorView,
                                         attribute: .left,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .left,
                                         multiplier: 1.0,
                                         constant: 0.0))
        
        addConstraint(NSLayoutConstraint(item: indicatorView,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .top,
                                         multiplier: 1.0,
                                         constant: 0.0))
       
    }

}
