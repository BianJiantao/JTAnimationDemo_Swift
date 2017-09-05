//
//  JTShimmerViewController.swift
//  JTAnimations
//
//  Created by BJT on 2017/9/5.
//  Copyright © 2017年 BJT. All rights reserved.
//  参考自: https://github.com/YouXianMing
//
//  facebook 辉光动画

import UIKit

class JTShimmerViewController: JTBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        
        setupTitle()
        setupContent()
    }
    
    
    private func setupTitle(){
    
        let shimmeringView = FBShimmeringView(frame: (navView?.bounds)!)
        navView?.insertSubviewBelowBackBtn(view: shimmeringView)
        
        shimmeringView.isShimmering = true
        shimmeringView.shimmeringBeginFadeDuration = 0.3
        shimmeringView.shimmeringOpacity = 0.5
        shimmeringView.shimmeringAnimationOpacity = 1.0
        
        let titleLabel = UILabel(frame: shimmeringView.bounds)
        titleLabel.text = title
        titleLabel.font = UIFont(name: "Heiti SC", size: 20)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.cyan
        
        shimmeringView.contentView = titleLabel
        
    }
    
    private func setupContent(){

            let shimmeringView = FBShimmeringView(frame: contentView!.bounds)
            shimmeringView.isShimmering = true
            shimmeringView.shimmeringBeginFadeDuration = 0.3
            shimmeringView.shimmeringOpacity = 0.5
            shimmeringView.shimmeringAnimationOpacity  = 1.0
            contentView?.addSubview(shimmeringView)
            shimmeringView.frame.origin.y -= 50
            
            
            let logoLabel =  UILabel(frame: shimmeringView.bounds)
            logoLabel.text = "Shimmer"
            logoLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 60.0)
            logoLabel.textColor = UIColor.white
            logoLabel.textAlignment = .center;
            logoLabel.backgroundColor = UIColor.clear
            shimmeringView.contentView = logoLabel;

            let lineWidth:CGFloat = 2; // 贝塞尔曲线宽度
            let radius:CGFloat = 130;  // 半径
            let shimmeringLayer = FBShimmeringLayer()
            let wH = (lineWidth + radius) * 2
            shimmeringLayer.frame  = CGRect(origin: CGPoint(), size: CGSize(width: wH, height: wH))
        
            let y = contentView!.bounds.height * 0.5 - 50
            shimmeringLayer.position = CGPoint(x:contentView!.center.x , y: y)
        
            shimmeringLayer.isShimmering = true
            shimmeringLayer.shimmeringBeginFadeDuration = 0.3
            shimmeringLayer.shimmeringOpacity = 0.4
            shimmeringLayer.shimmeringPauseDuration = 0.4
            shimmeringLayer.shimmeringAnimationOpacity  = 0.8
            contentView?.layer.addSublayer(shimmeringLayer)
            
            let circleShape = CAShapeLayer()
        
            circleShape.lineWidth   = lineWidth
            circleShape.strokeColor = UIColor.green.cgColor
            circleShape.fillColor   =  UIColor.clear.cgColor
            
            circleShape.frame = shimmeringLayer.bounds;
        
            let center = CGPoint(x: lineWidth+radius, y: lineWidth+radius)
            let path  = UIBezierPath(arcCenter: center,
                                     radius: radius + lineWidth*0.5,
                                     startAngle: 0,
                                     endAngle: CGFloat(M_PI) * 2,
                                     clockwise: false)
                
        
            circleShape.path = path.cgPath;
            shimmeringLayer.contentLayer = circleShape;
        

        
        
    }

}
