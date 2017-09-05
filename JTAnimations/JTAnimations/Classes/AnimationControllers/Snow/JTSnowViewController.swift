//
//  JTSnowViewController.swift
//  JTAnimations
//
//  Created by BJT on 2017/9/3.
//  Copyright © 2017年 BJT. All rights reserved.
// 粒子雪花动画


import UIKit

class JTSnowViewController: JTBaseViewController {

    private var movedMask:CALayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        navView?.setNavBar(withTitle: title)
    
        setupEmitter()
    }
    
    private func setupEmitter(){
        
        let snowEmitter = CAEmitterLayer()
        // 粒子发射位置
        snowEmitter.emitterPosition =  CGPoint(x: kScreenSzie.width*0.5, y: kNavBarHeight)
        
        // 发射源的尺寸大小
        snowEmitter.emitterSize = (contentView?.bounds.size)!
        
        // 发射模式
        snowEmitter.emitterMode = kCAEmitterLayerSurface
        
        // 发射源的形状
        snowEmitter.emitterShape = kCAEmitterLayerLine
        
        // 创建雪花类型的粒子
        let snowflake = CAEmitterCell()
        
        // 粒子的名字
        snowflake.name = "snow"
        
        // 粒子参数的速度乘数因子
        snowflake.birthRate = 20.0
        snowflake.lifetime  = 120.0
    
        // 粒子速度
        snowflake.velocity  = 10.0
        
        // 粒子的速度范围
        snowflake.velocityRange = CGFloat(10)
        
        // 粒子y方向的加速度分量
        snowflake.yAcceleration = CGFloat(2)
        // 周围发射角度
        snowflake.emissionRange = CGFloat(M_PI_2)
        
        // 粒子旋转角度范围
        snowflake.spinRange = CGFloat(M_PI_4)
        snowflake.contents = UIImage(named: "snow")?.cgImage
        
        // 设置雪花形状的粒子的颜色
        snowflake.color  =  UIColor.white.cgColor
        
        snowflake.scaleRange = 0.6
        snowflake.scale      = 0.7
        
        snowEmitter.shadowOpacity = 1.0
        snowEmitter.shadowRadius  = 0.0
        snowEmitter.shadowOffset  = CGSize(width: 0, height: 0)
        
        // 粒子边缘的颜色
        snowEmitter.shadowColor  = UIColor.white.cgColor
        
        // 添加粒子
        snowEmitter.emitterCells = [snowflake]
        
        // 将粒子Layer添加进图层中
        contentView?.layer.addSublayer(snowEmitter)
        
        // 形成遮罩
        let image = UIImage(named: "alpha")
        movedMask = CALayer()
        movedMask?.frame =  CGRect(origin: CGPoint(), size: (image?.size)!)
        movedMask?.contents = image?.cgImage
        let x = view.center.x
        let y = view.bounds.height * 0.4
        movedMask?.position = CGPoint(x: x, y: y)
        
        snowEmitter.mask = movedMask;

        // 拖拽的View
        let dragView = UIView(frame: CGRect(origin: CGPoint(), size: (image?.size)!))
        dragView.center  = (movedMask?.position)!;
        contentView?.addSubview(dragView)
        
        // 给dragView添加拖拽手势
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(drag))
        dragView.addGestureRecognizer(recognizer)
    }
    
    @objc private func drag(recognizer:UIPanGestureRecognizer){
  
         // 拖拽
        let translation = recognizer.translation(in: contentView)
        let x = (recognizer.view?.center.x)! + translation.x
        let y = (recognizer.view?.center.y)! + translation.y
        recognizer.view?.center = CGPoint(x: x, y: y)
        
        //清除 累加 的距离
        recognizer.setTranslation(CGPoint(), in: contentView)
        
        // 关闭隐式动画
        CATransaction.setDisableActions(true)
        // 设置遮罩位置
        movedMask?.position = (recognizer.view?.center)!
    }
    
    
}
