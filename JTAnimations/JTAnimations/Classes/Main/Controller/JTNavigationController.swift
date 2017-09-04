//
//  JTNavigationController.swift
//  JTAnimations
//
//  Created by BJT on 2017/9/3.
//  Copyright © 2017年 BJT. All rights reserved.
//

import UIKit

class JTNavigationController: UINavigationController {

    convenience init(rootViewController: JTHomeController,isHideNavBar:Bool) {
        
        self.init(rootViewController:rootViewController)
        navigationBar.isHidden = isHideNavBar // 隐藏导航条
        
    }
    
    
    override func viewDidLoad() {
        
        setupAni()
    }
    
}

// MARK: - 拿到启动图片, 设置启动动画
extension JTNavigationController{
    
    fileprivate func setupAni(){
        
        let launchImageView = UIImageView(frame: CGRect(origin: CGPoint(), size: kScreenSzie))
        launchImageView.image = JTAppServiceTool.launchImage()
    
        view.addSubview(launchImageView)
        view.bringSubview(toFront: launchImageView)
        UIView.animateKeyframes(withDuration: 1.5, delay: 0.5, options: [] , animations: {
            
            launchImageView.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            launchImageView.alpha = 0
            
            }) { (finished) in  // 动画结束,移除动画视图, 发出动画结束的通知
                
                launchImageView.removeFromSuperview()
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: LaunchAnimationDidEndNotification), object: nil)
        }
        
    }
    
}


