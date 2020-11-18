//
//  HomeController.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/11.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupPageStyle()
    }
    
    func setupPageStyle() {
        // 创建DNSPageStyle，设置样式
        self.view.backgroundColor = UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        let style = PageStyle()
        style.titleFont = UIFont.systemFont(ofSize: 16)
        style.isTitleViewScrollEnabled = false
        style.isTitleScaleEnabled = true
        style.titleSelectedColor = UIColor.red
        style.titleColor = UIColor.gray
        
        let titles = ["推荐", "分类", "VIP", "直播", "广播"]
        let viewControllers: [UIViewController] = [HomeRecommendController(),
                                                   HomeClassifyController(),
                                                   HomeVIPController(),
                                                   HomeLiveController(),
                                                   HomeBroadcastController()]
        for vc in viewControllers {
            self.addChild(vc)
        }
        let pageView = PageView(frame: CGRect(x: 0, y: kNavBarHeight, width: kScreenWidth, height: kScreenHeight - kNavBarHeight - 44), style: style, titles: titles, childViewControllers: viewControllers)
        pageView.contentView.backgroundColor = UIColor.red
        view.addSubview(pageView)
    }
    // 导航栏左边按钮
    private lazy var leftBarButton: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "message"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(leftBarButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    // 导航栏右边按钮
    private lazy var rightBarButton: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "search"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(rightBarButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    // - 导航栏左边消息点击事件
    @objc func leftBarButtonClick() {
    }
    
    // - 导航栏右边消息点击事件
    @objc func rightBarButtonClick() {
    }
}
