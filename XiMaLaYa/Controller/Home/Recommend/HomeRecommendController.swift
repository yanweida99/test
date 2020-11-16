//
//  HomeRecommendController.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/24.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class HomeRecommendController: UIViewController {
    // 穿插的广告数据
    private var recommnedAdvertList: [RecommnedAdvertModel]?
    
    // cell 注册
    private let RecommendHeaderViewID     = "RecommendHeaderView"
    private let RecommendFooterViewID     = "RecommendFooterView"
    
    // 注册不同的cell
    private let RecommendHeaderCellID     = "RecommendHeaderCell"
    // 猜你喜欢
    private let RecommendGuessLikeCellID  = "RecommendGuessLikeCell"
    // 热门有声书
    private let HotAudiobookCellID        = "HotAudiobookCell"
    // 广告
    private let AdvertCellID              = "AdvertCell"
    // 懒人电台
    private let OneKeyListenCellID        = "OneKeyListenCell"
    // 为你推荐
    private let RecommendForYouCellID     = "RecommendForYouCell"
    // 推荐直播
    private let HomeRecommendLiveCellID   = "HomeRecommendLiveCell"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        // - 注册头视图和尾视图
        collection.register(RecommendHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RecommendHeaderViewID)
        collection.register(RecommendFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RecommendFooterViewID)
        
        // - 注册不同分区cell
        // 默认
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collection.register(RecommendHeaderCell.self, forCellWithReuseIdentifier: RecommendHeaderCellID)
        // 猜你喜欢
        collection.register(RecommendGuessLikeCell.self, forCellWithReuseIdentifier: RecommendGuessLikeCellID)
        // 热门有声书
        collection.register(HotAudiobookCell.self, forCellWithReuseIdentifier: HotAudiobookCellID)
        // 广告
        collection.register(AdvertCell.self, forCellWithReuseIdentifier: AdvertCellID)
        // 懒人电台
        collection.register(OneKeyListenCell.self, forCellWithReuseIdentifier: OneKeyListenCellID)
        // 为你推荐
        collection.register(RecommendForYouCell.self, forCellWithReuseIdentifier: RecommendForYouCellID)
        // 推荐直播
        collection.register(HomeRecommendLiveCell.self, forCellWithReuseIdentifier: HomeRecommendLiveCellID)
        collection.uHead = URefreshHeader{ [weak self] in self?.setupLoadData() }
        return collection
    }()
    lazy var viewModel: RecommendViewModel = {
        return RecommendViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // 添加滑动视图
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        self.collectionView.uHead.beginRefreshing()
        setupLoadData()
        setupLoadRecommendAdData()
    }
    
    func setupLoadData(){
        // 加载数据
        viewModel.updateDataBlock = { [unowned self] in
            self.collectionView.uHead.endRefreshing()
            // 更新列表数据
            self.collectionView.reloadData()
        }
        viewModel.refreshDataSource()
    }
    func setupLoadRecommendAdData() {
        // 首页穿插广告接口请求
        let api = HomeRecommendAPI.recommendAdList
        AF.request(api.url, method: .get, parameters: api.parameters, headers: nil).validate().responseJSON { response in
            if case let Result.success(jsonData) = response.result {
                //解析数据
                let json = JSON(jsonData)
                if let advertList = JSONDeserializer<RecommnedAdvertModel>.deserializeModelArrayFrom(json: json["data"].description) { // 从字符串转换为对象实例
                    self.recommnedAdvertList = advertList as? [RecommnedAdvertModel]
                    self.collectionView.reloadData()
                }
            }
        }
        
    }
}

extension HomeRecommendController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections(collectionView:collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let moduleType = viewModel.homeRecommendList?[indexPath.section].moduleType
        
        if moduleType == "focus" || moduleType == "square" || moduleType == "topBuzz" {
            let cell:RecommendHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendHeaderCellID, for: indexPath) as! RecommendHeaderCell
            cell.focusModel = viewModel.focus
            cell.squareList = viewModel.squareList
            cell.topBuzzListData = viewModel.topBuzzList
            cell.delegate = self
            return cell
        } else if moduleType == "guessYouLike" || moduleType == "paidCategory" || moduleType == "categoriesForLong" || moduleType == "cityCategory"{
            // 横式排列布局cell
            let cell:RecommendGuessLikeCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendGuessLikeCellID, for: indexPath) as! RecommendGuessLikeCell
            cell.recommendListData = viewModel.homeRecommendList?[indexPath.section].list
            return cell
        } else if moduleType == "categoriesForShort" || moduleType == "playlist" || moduleType == "categoriesForExplore"{
            // 竖式排列布局cell
            let cell: HotAudiobookCell = collectionView.dequeueReusableCell(withReuseIdentifier: HotAudiobookCellID, for: indexPath) as! HotAudiobookCell
            cell.recommendListData = viewModel.homeRecommendList?[indexPath.section].list
            return cell
        } else if moduleType == "ad" {
            let cell:AdvertCell = collectionView.dequeueReusableCell(withReuseIdentifier: AdvertCellID, for: indexPath) as! AdvertCell
            if indexPath.section == 7 {
                cell.adModel = self.recommnedAdvertList?[0]
            } else if indexPath.section == 13 {
                cell.adModel = self.recommnedAdvertList?[1]
                // } else if indexPath.section == 17 {
                // cell.adModel = self.recommnedAdvertList?[2]
            }
            return cell
        } else if moduleType == "oneKeyListen" {
            let cell:OneKeyListenCell = collectionView.dequeueReusableCell(withReuseIdentifier: OneKeyListenCellID, for: indexPath) as! OneKeyListenCell
            cell.oneKeyListenList = viewModel.oneKeyListenList
            return cell
        } else if moduleType == "live" {
            let cell: HomeRecommendLiveCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRecommendLiveCellID, for: indexPath) as! HomeRecommendLiveCell
            cell.liveList = viewModel.liveList
            return cell
        } else {
            let cell:RecommendForYouCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendForYouCellID, for: indexPath) as! RecommendForYouCell
            return cell
            
        }
        //        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        //        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.insetForSectionAt(section: section)
    }
    
    // 最小item间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumInteritemSpacingForSectionAt(section: section)
    }
    
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumLineSpacingForSectionAt(section: section)
    }
    
    // item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForHeaderInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForFooterInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let moduleType = viewModel.homeRecommendList?[indexPath.section].moduleType
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView: RecommendHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RecommendHeaderViewID, for: indexPath) as! RecommendHeaderView
            headerView.homeRecommendList = viewModel.homeRecommendList?[indexPath.section]
            // 分区头右边更多按钮点击跳转
            headerView.headerMoreButtonClick = {[weak self]() in
                if moduleType == "guessYouLike"{
                    let vc = HomeGuessYouLikeMoreController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                } else if moduleType == "paidCategory" {
                    let vc = HomeVIPController()
                    vc.title = "精品"
                    self?.navigationController?.pushViewController(vc, animated: true)
                } else if moduleType == "live"{
                    let vc = HomeLiveController()
                    vc.title = "直播"
                    self?.navigationController?.pushViewController(vc, animated: true)
                } else {
                    guard let categoryId = self?.viewModel.homeRecommendList?[indexPath.section].target?.categoryId else {return}
                    if categoryId != 0 {
                        let vc = ClassifySubMenuController(categoryId:categoryId,isVipPush:false)
                        vc.title = self?.viewModel.homeRecommendList?[indexPath.section].title
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
            return headerView
        } else if kind == UICollectionView.elementKindSectionFooter {
            let footerView: RecommendFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RecommendFooterViewID, for: indexPath) as! RecommendFooterView
            return footerView
        }
        return UICollectionReusableView()
    }
}
// - 点击顶部分类按钮进入相对应界面
extension HomeRecommendController:RecommendHeaderCellDelegate {
    
    func recommendHeaderBannerClick(url: String) {
        
        let status2 = MessageView.viewFromNib(layout: .statusLine)
        status2.backgroundView.backgroundColor = kButtonColor
        status2.bodyLabel?.textColor = UIColor.white
        status2.configureContent(body: "暂时没有点击功能")
        var status2Config = SwiftMessages.defaultConfig
        status2Config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        status2Config.preferredStatusBarStyle = .lightContent
        SwiftMessages.show(config: status2Config, view: status2)
        
    }
    
    func recommendHeaderBtnClick(categoryId: String,title: String,url: String){
        if url == ""{
            if categoryId == "0"{
                let warning = MessageView.viewFromNib(layout: .cardView)
                warning.configureTheme(.warning)
                warning.configureDropShadow()
                
                let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
                warning.configureContent(title: "Warning", body: "暂时没有数据!!!", iconText: iconText)
                warning.button?.isHidden = true
                var warningConfig = SwiftMessages.defaultConfig
                warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
                SwiftMessages.show(config: warningConfig, view: warning)
            } else {
                let vc = ClassifySubMenuController(categoryId: Int(categoryId)!)
                vc.title = title
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            let vc = WebViewController(url:url)
            vc.title = title
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
