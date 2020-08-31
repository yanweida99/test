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
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        setupPageStyle()
    }
    
    func setupPageStyle() {
        // 创建DNSPageStyle，设置样式
        let style = PageStyle()
        style.titleFont = UIFont.systemFont(ofSize: 16)
        style.isTitleViewScrollEnabled = false
        style.isTitleScaleEnabled = true
        style.titleSelectedColor = UIColor.red
        style.titleColor = UIColor.gray
        // 标题下划线
        // style.isShowBottomLine = true
        // style.bottomLineColor = ButtonColor
        // style.bottomLineHeight = 2
        
        let titles = ["推荐", "分类", "VIP", "直播", "广播"]
        let viewControllers: [UIViewController] = [HomeRecommendController(),
                                                   HomeClassifyController(),
                                                   HomeVIPController(),
                                                   HomeLiveController(),
                                                   HomeBroadcastController()]
        for vc in viewControllers {
            self.addChild(vc)
        }
        let pageView = PageView(frame: CGRect(x: 0, y: NavBarHeight, width: ScreenWidth, height: ScreenHeight - NavBarHeight - 44), style: style, titles: titles, childViewControllers: viewControllers)
        pageView.contentView.backgroundColor = UIColor.red
        view.addSubview(pageView)
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
