
//
//  HomeLiveViewModel.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/21.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HomeLiveViewModel: NSObject {
    // 外部传值请求接口
    var categoryType: Int = 0
    convenience init(categoryType: Int = 0) {
        self.init()
        self.categoryType = categoryType
    }
    
    var homeLiveData: HomeLiveDataModel?
    var lives: [LivesModel]?
    var categoryVoList: [CategoryVoList]?
    var homeLiveBannerList: [HomeLiveBannerList]?
    var multidimensionalRankVos: [MultidimensionalRankVosModel]?
    
    // 数据源更新
    typealias AddDataBlock = () -> Void
    var updateBlock: AddDataBlock?
}

// 请求数据
extension HomeLiveViewModel {
    func refreshDataSource() {
        loadLiveData()
    }
    
    func loadLiveData() {
        let group = DispatchGroup()
        group.enter()
        // 首页直播接口请求
        HomeLiveAPIProvider.request(.liveList) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                // 从字符串转换为对象实例
                if let mappedObject = JSONDeserializer<HomeLiveModel>.deserializeFrom(json: json.description) {
                    self.lives = mappedObject.data?.lives
                    self.categoryVoList = mappedObject.data?.categoryVoList
                    //  self.collectionView.reloadData()
                    // 更新tableView数据
                    //  self.updataBlock?()
                    group.leave()
                }
            }
        }
        
        group.enter()
        // 首页直播滚动图接口请求
        HomeLiveAPIProvider.request(.liveBannerList) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<HomeLiveBanerModel>.deserializeFrom(json: json.description) { // 从字符串转换为对象实例
                    self.homeLiveBannerList = mappedObject.data
                    // let index: IndexPath = IndexPath.init(row: 0, section: 1)
                    // self.collectionView.reloadItems(at: [index])
                    // 更新tableView数据
                    // self.updataBlock?()
                    group.leave()
                }
            }
        }

        group.enter()
        // 首页直播排行榜接口请求
        HomeLiveAPIProvider.request(.liveRankList) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                // 从字符串转换为对象实例
                if let mappedObject = JSONDeserializer<HomeLiveRankModel>.deserializeFrom(json: json.description) {
                    self.multidimensionalRankVos = mappedObject.data?.multidimensionalRankVos
                    //  let index: IndexPath = IndexPath.init(row: 0, section: 2)
                    //  self.collectionView.reloadItems(at: [index])
                    // 更新tableView数据
                    //  self.updataBlock?()
                    group.leave()
                }
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.updateBlock?()
        }
    }
}

// 点击分类刷新主页数据请求数据
extension HomeLiveViewModel {
    func refreshCategoryLiveData() {
        loadCategoryLiveData()
    }
    func loadCategoryLiveData() {
        HomeLiveAPIProvider.request(.categoryTypeList(categoryType:self.categoryType)) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<LivesModel>.deserializeModelArrayFrom(json: json["data"]["lives"].description) {
                    self.lives = mappedObject as? [LivesModel]
                }
                self.updateBlock?()
            }
        }
    }
}


// collectionview数据
extension HomeLiveViewModel {
    // 每个分区显示item数量
    func numberOfItemsIn(section: NSInteger) -> NSInteger {
        if section == HomeLiveSectionLive {
            return self.lives?.count ?? 0
        } else {
            return 1
        }
    }
    // 每个分区的内边距
    func insetForSectionAt(section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0);
    }
    
    // 最小 item 间距
    func minimumInteritemSpacingForSectionAt(section:Int) ->CGFloat {
        return 5
    }
    
    // 最小行间距
    func minimumLineSpacingForSectionAt(section:Int) ->CGFloat {
        return 10
    }
    
    // item 尺寸
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case HomeLiveSectionGrid:
            return CGSize.init(width:ScreenWidth - 30, height: 90)
        case HomeLiveSectionBanner:
            return CGSize.init(width:ScreenWidth - 30, height: 110)
        case HomeLiveSectionRank:
            return CGSize.init(width:ScreenWidth - 30, height: 70)
        default:
            return CGSize.init(width:(ScreenWidth - 40) / 2, height: 230)
        }
    }
    
    // 分区头视图size
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        if section == HomeLiveSectionLive {
            return CGSize.init(width: ScreenWidth, height: 40)
        } else {
            return .zero
        }
    }
}

