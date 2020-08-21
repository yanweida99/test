//
//  HomeVIPController.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/21.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit
import SwiftMessages

let HomeVIPSectionBanner    = 0 // 滚动图片
let HomeVIPSectionGrid      = 1 // 分类
let HomeVIPSectionHot       = 2 // 热
let HomeVIPSectionEnjoy     = 3 // 尊享
let HomeVIPSectionVIP       = 4 // VIP

class HomeVIPController: UIViewController {
    // 上页面传过来请求接口必须的参数
    convenience init(isRecommendPush: Bool = false) {
        self.init()
        self.tableView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
    }
    
    private let HomeVIPCellID           = "HomeVIPCell"
    private let HomeVIPHeaderViewID     = "HomeVIPHeaderView"
    private let HomeVIPFooterViewID     = "HomeVIPFooterView"
    private let HomeVIPBannerCellID     = "HomeVIPBannerCell"
    private let HomeVIPCategoriesCellID = "HomeVIPCategoriesCell"
    private let HomeVIPHotCellID        = "HomeVIPHotCell"
    private let HomeVIPEnjoyCellID      = "HomeVIPEnjoyCell"

    private var currentTopSectionCount: Int64 = 0
    
    lazy var headView: UIView = {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 30))
        view.backgroundColor = UIColor.purple
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x:0, y:0, width: ScreenWidth, height:ScreenHeight - NavBarHeight - 44 - TabBarHeight), style: UITableView.Style.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        // 注册头尾视图
        tableView.register(HomeVipHeaderView.self, forHeaderFooterViewReuseIdentifier: HomeVipHeaderViewID)
        tableView.register(HomeVipFooterView.self, forHeaderFooterViewReuseIdentifier: HomeVipFooterViewID)
        // 注册分区cell
        tableView.register(HomeVIPCell.self, forCellReuseIdentifier: HomeVIPCellID)
        tableView.register(HomeVipBannerCell.self, forCellReuseIdentifier: HomeVipBannerCellID)
        tableView.register(HomeVipCategoriesCell.self, forCellReuseIdentifier: HomeVipCategoriesCellID)
        tableView.register(HomeVipHotCell.self, forCellReuseIdentifier: HomeVipHotCellID)
        tableView.register(HomeVipEnjoyCell.self, forCellReuseIdentifier: HomeVipEnjoyCellID)
        tableView.uHead = URefreshHeader{ [weak self] in self?.setupLoadData() }
        return tableView
    }()
    
    lazy var viewModel: HomeVIPViewModel = {
        return HomeVIPViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.addSubview(self.tableView)
        // 刚进页面进行刷新
        self.tableView.uHead.beginRefreshing()
        setupLoadData()
    }
    
    func setupLoadData() {
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            self.tableView.uHead.endRefreshing()
            // 更新列表数据
            self.tableView.reloadData()
        }
        viewModel.refreshDataSource()
    }
}

extension HomeVIPController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.categoryList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case HomeVipSectionBanner:
            let cell: HomeVipBannerCell = tableView.dequeueReusableCell(withIdentifier: HomeVipBannerCellID, for: indexPath) as! HomeVipBannerCell
            cell.vipBannerList = viewModel.focusImages
            cell.delegate = self
            return cell
        case HomeVipSectionGrid:
            let cell: HomeVipCategoriesCell = tableView.dequeueReusableCell(withIdentifier: HomeVipCategoriesCellID, for: indexPath) as! HomeVipCategoriesCell
            cell.categoryBtnModel = viewModel.categoryBtnList
            cell.delegate = self
            return cell
        case HomeVipSectionHot:
            let cell: HomeVipHotCell = tableView.dequeueReusableCell(withIdentifier: HomeVipHotCellID, for: indexPath) as! HomeVipHotCell
            cell.categoryContentsModel = viewModel.categoryList?[indexPath.section].list
            cell.delegate = self
            return cell
        case HomeVipSectionEnjoy:
            let cell: HomeVipEnjoyCell = tableView.dequeueReusableCell(withIdentifier: HomeVipEnjoyCellID, for: indexPath) as! HomeVipEnjoyCell
            cell.categoryContentsModel = viewModel.categoryList?[indexPath.section].list
            cell.delegate = self
            return cell
        default:
            let cell:HomeVIPCell = tableView.dequeueReusableCell(withIdentifier: HomeVIPCellID, for: indexPath) as! HomeVIPCell
            cell.categoryContentsModel = viewModel.categoryList?[indexPath.section].list?[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PlayDetailController(albumId: (viewModel.categoryList?[indexPath.section].list?[indexPath.row].albumId)!)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.heightForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: HomeVipHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeVipHeaderViewID) as! HomeVipHeaderView
        headerView.titStr = viewModel.categoryList?[section].title
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.heightForFooterInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = DownColor
        return view
    }
}
extension HomeVIPController: HomeVipBannerCellDelegate{
    func homeVipBannerCellClick(url: String) {
        let warning = MessageView.viewFromNib(layout: .cardView)
        warning.configureTheme(.warning)
        warning.configureDropShadow()
        
        let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
        warning.configureContent(title: "Warning", body: "暂时没有点击功能", iconText: iconText)
        warning.button?.isHidden = true
        var warningConfig = SwiftMessages.defaultConfig
        warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        SwiftMessages.show(config: warningConfig, view: warning)
    }
}

// - 点击顶部分类按钮 delegate
extension HomeVIPController: HomeVipCategoriesCellDelegate{
    func homeVipCategoriesCellItemClick(id: String, url: String,title:String) {
        if url == ""{
            let vc = ClassifySubMenuController(categoryId: Int(id)!,isVipPush:true)
            vc.title = title
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = WebViewController(url:url)
            vc.title = title
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
// - 点击Vip尊享课item delegate
extension HomeVIPController: HomeVipEnjoyCellDelegate{
    func homeVipEnjoyCellItemClick(model: CategoryContents) {
        let vc = PlayDetailController(albumId: model.albumId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
// - 点击热播item delegate
extension HomeVIPController: HomeVipHotCellDelegate{
    func homeVipHotCellItemClick(model: CategoryContents) {
        let vc = PlayDetailController(albumId: model.albumId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
