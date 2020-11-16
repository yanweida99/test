
//
//  ClassifySubMenuController.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/24.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class ClassifySubMenuController: UIViewController {
    
    private var categoryId: Int = 0
    private var isVipPush:Bool = false
    
    convenience init(categoryId: Int = 0,isVipPush:Bool = false) {
        self.init()
        self.categoryId = categoryId
        self.isVipPush = isVipPush
    }
    
    private var Keywords: [ClassifySubMenuKeywords]?
    private lazy var nameArray = NSMutableArray()
    private lazy var keywordIdArray = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // 加载头部分类数据
        loadHeaderCategoryData()
    }
    // 加载头部分类数据
    func loadHeaderCategoryData(){
        // 分类二级界面顶部分类接口请求
        let api = HomeClassifySubMenuAPI.headerCategoryList(categoryId: self.categoryId)
        AF.request(api.url, method: .get, parameters: api.parameters, headers: nil).validate().responseJSON { response in
            if case let Result.success(jsonData) = response.result {
                //解析数据
                let json = JSON(jsonData)
                // 从字符串转换为对象实例
                if let mappedObject = JSONDeserializer<ClassifySubMenuKeywords>.deserializeModelArrayFrom(json: json["keywords"].description) {
                    self.Keywords = mappedObject as? [ClassifySubMenuKeywords]
                    for keyword in self.Keywords! {
                        self.nameArray.add(keyword.keywordName!)
                    }
                    if !self.isVipPush{
                        self.nameArray.insert("推荐", at: 0)
                    }
                    self.setupHeaderView()
                }
            }
        }
    }
    
    func setupHeaderView(){
        // 创建DNSPageStyle，设置样式
        let style = PageStyle()
        style.isTitleViewScrollEnabled = true
        style.isTitleScaleEnabled = true
        style.isShowBottomLine = true
        style.titleSelectedColor = UIColor.black
        style.titleColor = UIColor.gray
        style.bottomLineColor = kButtonColor
        style.bottomLineHeight = 2
        style.titleViewBackgroundColor = kBackgroundColor
        
        // 创建每一页对应的controller
        var viewControllers = [UIViewController]()
        for keyword in self.Keywords! {
            let controller = ClassifySubContentController(keywordId:keyword.keywordId, categoryId:keyword.categoryId)
            viewControllers.append(controller)
        }
        if !self.isVipPush{
            // 这里需要插入推荐的控制器，因为接口数据中并不含有推荐
            let categoryId = self.Keywords?.last?.categoryId
            viewControllers.insert(ClassifySubRecommendController(categoryId:categoryId!), at: 0)
        }
        
        for vc in viewControllers{
            self.addChild(vc)
        }
        let pageView = PageView(frame: CGRect(x: 0, y: kNavBarHeight, width: kScreenWidth, height: kScreenHeight - kNavBarHeight), style: style, titles: nameArray as! [String], childViewControllers: viewControllers)
        view.addSubview(pageView)
    }
}




