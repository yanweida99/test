//
//  NavigationController.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/11.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavBarAppearence()
    }
    
    func setupNavBarAppearence() {
        // 设置导航栏默认的背景颜色
        WRNavigationBar.defaultNavBarBarTintColor = UIColor.init(red: 245 / 255.0, green: 245 / 255.0, blue: 245 / 255.0, alpha: 1)
        
        // 设置导航栏所有按钮的
        WRNavigationBar.defaultNavBarTintColor = ButtonColor
        WRNavigationBar.defaultNavBarTitleColor = UIColor.black
        
        // 统一设置导航栏格式
//        WRNavigationBar.defaultStatusBarStyle = .lightContent
        
        // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
        WRNavigationBar.defaultShadowImageHidden = true
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
