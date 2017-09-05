//
//  JTPopNumberViewController.swift
//  JTAnimations
//
//  Created by BJT on 2017/9/5.
//  Copyright © 2017年 BJT. All rights reserved.
//  参考自: https://github.com/YouXianMing
//
//  数值跳动动画
//

import UIKit

private let randomMax = 100
private let colorCoefficient = 1/Double(randomMax)

class JTPopNumberViewController: JTBaseViewController {

    private var label:UILabel!
    private var numberAnimation:POPBasicAnimation!
    private var timer:CADisplayLink!
    private var currentValue = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        navView?.setNavBar(withTitle: title)
        
        setup()
        
    }
    
    fileprivate func setup(){
        
        // Init label.
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.center = CGPoint(x:contentView!.middleX, y:contentView!.middleY-50)
        contentView?.addSubview(label)
        
        // Init numberAnimation.
        numberAnimation =  POPBasicAnimation()
        
        // Timer event.
        timer = CADisplayLink(target: self, selector: #selector(updateValue))
        timer.frameInterval = 60*3; // 180帧,即3秒调用一次
        timer.add(to: RunLoop.main, forMode: .defaultRunLoopMode)
        
    }
    
    @objc private func updateValue(){
        
        configNumberAnimation()
        startAnimation()
    }
    
    private func configNumberAnimation(){
        
        numberAnimation.fromValue  = NSNumber(value: currentValue)
        numberAnimation.toValue =  NSNumber(value: arc4random_uniform( UInt32(randomMax)+1 ))
        numberAnimation.duration = 2.0
    }
    
    private func startAnimation(){
        
         // 将计算出来的值通过writeBlock动态给控件设定
        numberAnimation.property = POPMutableAnimatableProperty.property(withName: "numberAnimation", initializer: { [weak self](prop:POPMutableAnimatableProperty?) in
            
            prop?.writeBlock = { (obj,values) in
                
                self?.currentValue =  Double(values![0])
                self?.POPNumberAnimation(WithCurrentValue: Double(values![0]))
            }
            
        }) as! POPAnimatableProperty
        // 添加动画
        pop_add(numberAnimation, forKey: "")
         
        
    }
    
    
    private func POPNumberAnimation(WithCurrentValue value:Double){
        
        // Init string.
        let numberString = String(format: "%0.1f", value)
        
        let suffixString    = "Perc"
        let totalString  = "\(numberString) \(suffixString)"
        
        // Create richString.
        let richString = NSMutableAttributedString(string: totalString)
         let attr = [NSForegroundColorAttributeName:UIColor.white,
                     NSFontAttributeName:UIFont(name: "HYQiHei-BEJF", size: 30)!]
        richString.addAttributes(attr, range:NSMakeRange(0, richString.length))
        
        let numstrRange = (totalString as NSString).range(of: numberString)
        
        let red = CGFloat(1-value*colorCoefficient)
        let green = CGFloat(100*colorCoefficient)
        let blue = CGFloat(1-value*colorCoefficient)
        richString.addAttributes([
            NSFontAttributeName:UIFont(name: "HYQiHei-BEJF", size: 60)!,
            NSForegroundColorAttributeName:UIColor(red: red, green: green, blue: blue, alpha: 0.8)
            ], range: numstrRange)
       
        
        let suffixStrRange = (totalString as NSString).range(of: suffixString)
        let alpha = CGFloat(value/80)
        richString.addAttributes([
            NSForegroundColorAttributeName:UIColor.yellow.withAlphaComponent(alpha)
            ], range: suffixStrRange)
        
        label.attributedText = richString;
        
    }
    

}
