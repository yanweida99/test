//
//  FindController.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/13.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit
import LTScrollView

class FindController: UIViewController {

    private lazy var categoryView: CategoryView = {
        let view = CategoryView.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 190))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private lazy var viewControllers: [UIViewController] = {
        let findAttentionVC = AttentionController()
        // 控制器
        // 控制器
        return [findAttentionVC]
    }()
    
    private lazy var titles: [String] = {
        return ["关注动态"]//, "推荐动态", "趣配音"
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
//        if #available(iOS 13.0, *) {
//            let statusBarHeight = self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
//        } else {
//            let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
//        }
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        let advancedManager = LTAdvancedManager(frame: CGRect(x: 0, y: NavBarHeight, width: ScreenWidth, height: ScreenHeight - NavBarHeight), viewControllers: viewControllers, titles: titles, currentViewController: self, layout: layout, headerViewHandle: { [weak self] in
            guard let strongSelf = self else { return UIView() }
            let headerView = strongSelf.categoryView
            return headerView
        })
        // 设置代理 监听滚动
        advancedManager.delegate = self
        // 设置悬停位置
        //        advancedManager.hoverY = navigationBarHeight
        // 点击切换滚动过程动画
        //        advancedManager.isClickScrollAnimation = true
        // 代码设置滚动到第几个位置
        //        advancedManager.scrollToIndex(index: viewControllers.count - 1)
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

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
//        if #available(iOS 11.0, *) {
//            self.tableView.contentInsetAdjustmentBehavior = .never
//        } else {
            self.automaticallyAdjustsScrollViewInsets = false
//        }
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FindController: LTAdvancedScrollViewDelegate {
    // 具体使用请参考以下
    private func advancedManagerConfigure() {
        // 选中事件
        advancedManager.advancedDidSelectIndexHandle = {
            print("选中了 -> \($0)")
        }
    }
    
    func glt_scrollViewOffsetY(_ offsetY: CGFloat) {
        
    }
}

