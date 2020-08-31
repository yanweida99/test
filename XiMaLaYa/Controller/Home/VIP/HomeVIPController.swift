//
//  HomeVIPController.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/21.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

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
        let tableView = UITableView.init(frame: CGRect(x:0, y:0, width: ScreenWidth, height: ScreenHeight - NavBarHeight - 44 - TabBarHeight), style: UITableView.Style.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        // 注册头尾视图
        tableView.register(HomeVIPHeaderView.self, forHeaderFooterViewReuseIdentifier: HomeVIPHeaderViewID)
        tableView.register(HomeVIPFooterView.self, forHeaderFooterViewReuseIdentifier: HomeVIPFooterViewID)
        // 注册分区cell
        tableView.register(HomeVIPCell.self, forCellReuseIdentifier: HomeVIPCellID)
        tableView.register(HomeVIPBannerCell.self, forCellReuseIdentifier: HomeVIPBannerCellID)
        tableView.register(HomeVIPCategoriesCell.self, forCellReuseIdentifier: HomeVIPCategoriesCellID)
        tableView.register(HomeVIPHotCell.self, forCellReuseIdentifier: HomeVIPHotCellID)
        tableView.register(HomeVIPEnjoyCell.self, forCellReuseIdentifier: HomeVIPEnjoyCellID)
        tableView.uHead = URefreshHeader { [weak self] in
            self?.loadData()
        }
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
        loadData()
    }
    
    func loadData() {
        // 加载数据
        viewModel.updateBlock = { [unowned self] in
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
        case HomeVIPSectionBanner:
            let cell: HomeVIPBannerCell = tableView.dequeueReusableCell(withIdentifier: HomeVIPBannerCellID, for: indexPath) as! HomeVIPBannerCell
            cell.vipBannerList = viewModel.focusImages
            cell.delegate = self
            return cell
        case HomeVIPSectionGrid:
            let cell: HomeVIPCategoriesCell = tableView.dequeueReusableCell(withIdentifier: HomeVIPCategoriesCellID, for: indexPath) as! HomeVIPCategoriesCell
            cell.categoryBtnModel = viewModel.categoryButtonList
            cell.delegate = self
            return cell
        case HomeVIPSectionHot:
            let cell: HomeVIPHotCell = tableView.dequeueReusableCell(withIdentifier: HomeVIPHotCellID, for: indexPath) as! HomeVIPHotCell
            cell.categoryContentsModel = viewModel.categoryList?[indexPath.section].list
            cell.delegate = self
            return cell
        case HomeVIPSectionEnjoy:
            let cell: HomeVIPEnjoyCell = tableView.dequeueReusableCell(withIdentifier: HomeVIPEnjoyCellID, for: indexPath) as! HomeVIPEnjoyCell
            cell.categoryContentsModel = viewModel.categoryList?[indexPath.section].list
            cell.delegate = self
            return cell
        default:
            let cell: HomeVIPCell = tableView.dequeueReusableCell(withIdentifier: HomeVIPCellID, for: indexPath) as! HomeVIPCell
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
        let headerView: HomeVIPHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeVIPHeaderViewID) as! HomeVIPHeaderView
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
extension HomeVIPController: HomeVIPBannerCellDelegate{
    func homeVIPBannerCellClick(url: String) {
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
extension HomeVIPController: HomeVIPCategoriesCellDelegate{
    func homeVIPCategoriesCellItemClick(id: String, url: String,title: String) {
        if url == ""{
            let vc = ClassifySubMenuController(categoryId: Int(id)!,isVipPush:true)
            vc.title = title
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = WebViewController(url:url)
            vc.title = title
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
// - 点击Vip尊享课item delegate
extension HomeVIPController: HomeVIPEnjoyCellDelegate{
    func homeVIPEnjoyCellItemClick(model: CategoryContents) {
        let vc = PlayDetailController(albumId: model.albumId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
// - 点击热播item delegate
extension HomeVIPController: HomeVIPHotCellDelegate{
    func homeVIPHotCellItemClick(model: CategoryContents) {
        let vc = PlayDetailController(albumId: model.albumId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
