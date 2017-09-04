//
//  JTAppServiceTool.swift
//  JTAnimations
//
//  Created by BJT on 2017/9/3.
//  Copyright © 2017年 BJT. All rights reserved.
// app 工具类

import UIKit

class JTAppServiceTool {

   /// 类方法, 获取启动图片
   ///
   /// - returns: 启动图片
   class func launchImage() -> UIImage {
        
        var lauchImage      : UIImage!
        var viewOrientation : String!
        let viewSize        = kScreenSzie
        let orientation     = UIApplication.shared.statusBarOrientation
        
        if orientation == .landscapeLeft || orientation == .landscapeRight {
            
            viewOrientation = "Landscape"
            
        } else {
            
            viewOrientation = "Portrait"
        }
        
        let imagesInfoArray = Bundle.main.infoDictionary!["UILaunchImages"]
        for dict : Dictionary <String, String> in imagesInfoArray as! Array {
            
            let imageSize = CGSizeFromString(dict["UILaunchImageSize"]!)
            if imageSize.equalTo(viewSize) && viewOrientation == dict["UILaunchImageOrientation"]! as String {
                
                lauchImage = UIImage(named: dict["UILaunchImageName"]!)
            }
        }
        
        return lauchImage
    }
    
}
