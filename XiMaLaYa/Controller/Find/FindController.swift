//
//  FindController.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/13.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class FindController: UIViewController {
    
    private lazy var categoryView: CategoryView = {
        let view = CategoryView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 190))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private lazy var viewControllers: [UIViewController] = {
        let findAttentionVC = AttentionController()
        let findRecommendVC = FindRecommendController()
        let findDubbingVC = DubbingController()
        return [findAttentionVC, findRecommendVC, findDubbingVC]
    }()
    
    private lazy var titles: [String] = {
        return ["关注动态", "推荐动态", "趣配音"]
    }()
    
    private lazy var layout: LTLayout = {
        let layout = LTLayout()
        layout.isAverage = true
        layout.sliderWidth = 80
        layout.titleViewBgColor = UIColor.white
        layout.titleColor = UIColor(r: 178, g: 178, b: 178)
        layout.titleSelectColor = UIColor(r: 16, g: 16, b: 16)
        layout.bottomLineColor = UIColor.red
        layout.sliderHeight = 56
        /* 更多属性设置请参考 LTLayout 中 public 属性说明*/
        return layout
    }()
    
    private lazy var advancedManager: LTAdvancedManager = {
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let advancedManager = LTAdvancedManager(frame: CGRect(x: 0, y: kNavBarHeight, width: kScreenWidth, height: kScreenHeight - kNavBarHeight), viewControllers: viewControllers, titles: titles, currentViewController: self, layout: layout, headerViewHandle: { [weak self] in
            guard let strongSelf = self else { return UIView() }
            let headerView = strongSelf.categoryView
            return headerView
        })
        advancedManager.delegate = self
        return advancedManager
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(advancedManager)
        advancedManagerConfigure()
        
        // 导航栏左右item
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
    }
    
    // 导航栏左边消息点击事件
    @objc func leftBarButtonClick() {
        
    }
    
    // 导航栏右边设置点击事件
    @objc func rightBarButtonClick() {
        
    }
}

extension FindController: LTAdvancedScrollViewDelegate {
    private func advancedManagerConfigure() {
        // 选中事件
        advancedManager.advancedDidSelectIndexHandle = {
            print("选中了 -> \(self.titles[$0])")
        }
    }
    
    func glt_scrollViewOffsetY(_ offsetY: CGFloat) {
        
    }
}

