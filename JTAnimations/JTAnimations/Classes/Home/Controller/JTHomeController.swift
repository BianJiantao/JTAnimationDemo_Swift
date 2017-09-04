//
//  JTHomeController.swift
//  JTAnimations
//
//  Created by BJT on 2017/9/3.
//  Copyright © 2017年 BJT. All rights reserved.
//  home

import UIKit


class JTHomeController: JTBaseViewController {

    fileprivate var items:[JTHomeItem] = []
    var isLoadData:Bool = false
    var tableView:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        navView?.alpha = 0
        
        configData()
        setupTableView()
        setupTitle()
        
        /// 监听启动动画的完成通知
        NotificationCenter.default.addObserver(self, selector: #selector(setupAni), name:NSNotification.Name(rawValue: LaunchAnimationDidEndNotification), object: nil)
    }
    
    deinit {
        /// 移除监听
        NotificationCenter.default.removeObserver(self)
        
    }
    
    
    /// 设置辉光标题
    private func setupTitle(){
   
        let shimmeringView = FBShimmeringView(frame: (navView?.bounds)!)
        view.addSubview(shimmeringView)
        shimmeringView.isShimmering = true
        shimmeringView.shimmeringBeginFadeDuration = 0.3
        shimmeringView.shimmeringOpacity = 0.5
        shimmeringView.shimmeringAnimationOpacity = 1.0
        
        let titleLabel = UILabel(frame: shimmeringView.bounds)
        titleLabel.text = "Animations"
        titleLabel.font = UIFont(name: "Heiti SC", size: 20)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.cyan
        
        shimmeringView.contentView = titleLabel
        
        
    }
    
    private func configData(){
        
        let array = [
            JTHomeItem(title: "粒子动画-雪花", vcClass: JTSnowViewController.classForCoder()),
//            JTHomeItem(title: "粒子动画-雪花qq", vcClass: JTSnowViewController.classForCoder())
        ]
        
        let count = array.count
        var item:JTHomeItem
        for i in 0..<count {
            
            item = array[i]
            let title = String(format: "%02d.  %@", i+1,item.title!)
            let attrsText = NSMutableAttributedString(string: title)
            
            attrsText.addAttributes([NSFontAttributeName:UIFont(name: "Heiti SC", size: 16)!,NSForegroundColorAttributeName:UIColor(red: 46/255, green: 201/255, blue: 220/255, alpha: 1)],range: NSMakeRange(0, attrsText.length))
            
            attrsText.addAttributes([NSFontAttributeName:UIFont(name: "GillSans-Italic", size: 16)!,NSForegroundColorAttributeName:UIColor.green.withAlphaComponent(0.8)],range: NSMakeRange(0, 3))
            
            
            item.attrsTitle = attrsText
            
        }
        
        items.append(contentsOf: array)
    }
    
    private func setupTableView(){
        
        tableView = UITableView(frame: (contentView?.bounds)!, style: .plain)
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.rowHeight = 50
        tableView?.separatorStyle = .none
        tableView?.backgroundColor = UIColor.clear
        contentView?.addSubview(tableView!)
        
    }
    
    @objc func setupAni(){
        
        
        
    }
    
}

private let cellID = "cellID"
// MARK: - UITableViewDelegate,UITableViewDataSource
extension JTHomeController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)

        if cell == nil {
            
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
            cell?.detailTextLabel?.font = UIFont(name: "Avenir-Light", size: 10)
            cell?.detailTextLabel?.textColor = UIColor.white
            cell?.backgroundColor = UIColor.clear
            cell?.selectionStyle = .none
            
        }
        
        let item = items[indexPath.row]
        cell?.textLabel?.attributedText = item.attrsTitle
        cell?.detailTextLabel?.text = "\(item.vcClass!)"
        
                
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = items[indexPath.row]
        guard let vcClass = item.vcClass as? UIViewController.Type else{ // 获取跳转控制器的类型
            print("控制器类转换失败")
            return
        }
        
        let vc = vcClass.init()
        vc.title = item.title
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}


