//
//  JTHomeItem.swift
//  JTAnimations
//
//  Created by BJT on 2017/9/3.
//  Copyright © 2017年 BJT. All rights reserved.
//  home 页面, 各个动画控制器的信息 item

import UIKit

class JTHomeItem: NSObject {

    /// 标题
    var title:String?
    
    /// 动画控制器类型
    var vcClass:AnyClass?
    
    /// 富文本标题
    var attrsTitle:NSAttributedString?
    
    convenience init(title:String,vcClass:AnyClass){
        
        self.init()
        
        self.title = title
        self.vcClass = vcClass
    }
    
    
}
