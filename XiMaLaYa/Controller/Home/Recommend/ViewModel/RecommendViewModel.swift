//
//  RecommendViewModel.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/24.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class RecommendViewModel: NSObject {
    // MARK - 数据模型
    var fmhomeRecommendModel: HomeRecommendModel?
    var homeRecommendList: [RecommendModel]?
    var recommendList: [RecommendListModel]?
    var focus: FocusModel?
    var squareList: [SquareModel]?
    var topBuzzList: [TopBuzzModel]?
    var guessYouLikeList: [GuessYouLikeModel]?
    var paidCategoryList: [PaidCategoryModel]?
    var playlist: PlaylistModel?
    var oneKeyListenList: [OneKeyListenModel]?
    var liveList: [LiveModel]?
    
    
    // Mark: -数据源更新
    var updateDataBlock: AddDataBlock?
}

extension RecommendViewModel {
    func refreshDataSource() {
        // 首页推荐接口请求
        let api = HomeRecommendAPI.recommendList
        AF.request(api.url, method: .get, parameters: api.parameters, headers: nil).validate().responseJSON { response in
            if case let Result.success(jsonData) = response.result {
                //解析数据
                let json = JSON(jsonData)
                if let mappedObject = JSONDeserializer<HomeRecommendModel>.deserializeFrom(json: json.description) { // 从字符串转换为对象实例
                    self.fmhomeRecommendModel = mappedObject
                    self.homeRecommendList = mappedObject.list
                    if let recommendList = JSONDeserializer<RecommendListModel>.deserializeModelArrayFrom(json: json["list"].description) {
                        self.recommendList = recommendList as? [RecommendListModel]
                    }
                    
                    if let focus = JSONDeserializer<FocusModel>.deserializeFrom(json: json["list"][0]["list"][0].description) {
                        self.focus = focus
                    }
                    if let square = JSONDeserializer<SquareModel>.deserializeModelArrayFrom(json: json["list"][1]["list"].description) {
                        self.squareList = square as? [SquareModel]
                    }
                    if let topBuzz = JSONDeserializer<TopBuzzModel>.deserializeModelArrayFrom(json: json["list"][2]["list"].description) {
                        self.topBuzzList = topBuzz as? [TopBuzzModel]
                    }
                    
                    if let oneKeyListen = JSONDeserializer<OneKeyListenModel>.deserializeModelArrayFrom(json: json["list"][9]["list"].description) {
                        self.oneKeyListenList = oneKeyListen as? [OneKeyListenModel]
                    }
                    
                    if let live = JSONDeserializer<LiveModel>.deserializeModelArrayFrom(json: json["list"][14]["list"].description) {
                        self.liveList = live as? [LiveModel]
                    }
                }
                self.updateDataBlock?()
            }
        }
    }
}
// collectionview数据
extension RecommendViewModel {
    func numberOfSections(collectionView:UICollectionView) ->Int {
        return (self.homeRecommendList?.count) ?? 0
    }
    // 每个分区显示item数量
    func numberOfItemsIn(section: NSInteger) -> NSInteger {
        return 1
    }
    //每个分区的内边距
    func insetForSectionAt(section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //最小 item 间距
    func minimumInteritemSpacingForSectionAt(section: Int) ->CGFloat {
        return 0
    }
    
    //最小行间距
    func minimumLineSpacingForSectionAt(section: Int) ->CGFloat {
        return 0
    }
    
    // item 尺寸
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        let HeaderAndFooterHeight: Int = 90
        let itemNums = (self.homeRecommendList?[indexPath.section].list?.count)!/3
        let count = self.homeRecommendList?[indexPath.section].list?.count
        let moduleType = self.homeRecommendList?[indexPath.section].moduleType
        if moduleType == "focus" {
            return CGSize.init(width: kScreenWidth, height: 360)//test
        } else if moduleType == "square" || moduleType == "topBuzz" {
            return CGSize.zero
        } else if moduleType == "guessYouLike" || moduleType == "paidCategory" || moduleType == "categoriesForLong" || moduleType == "cityCategory" || moduleType == "live"{
            return CGSize.init(width: kScreenWidth, height: CGFloat(HeaderAndFooterHeight + 180 * itemNums))
        } else if moduleType == "categoriesForShort" || moduleType == "playlist" || moduleType == "categoriesForExplore"{
            return CGSize.init(width: kScreenWidth, height: CGFloat(HeaderAndFooterHeight+120*count!))
        } else if moduleType == "ad" {
            return CGSize.init(width: kScreenWidth, height: 240)
        } else if moduleType == "oneKeyListen" {
            return CGSize.init(width: kScreenWidth, height: 180)
        } else {
            return .zero
        }
    }
    
    // 分区头视图size
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        let moduleType = self.homeRecommendList?[section].moduleType
        if moduleType == "focus" || moduleType == "square" || moduleType == "topBuzz" || moduleType == "ad" || section == 18 {
            return CGSize.zero
        } else {
            return CGSize.init(width: kScreenHeight, height:40)
        }
    }
    
    // 分区尾视图size
    func referenceSizeForFooterInSection(section: Int) -> CGSize {
        let moduleType = self.homeRecommendList?[section].moduleType
        if moduleType == "focus" || moduleType == "square" {
            return CGSize.zero
        } else {
            return CGSize.init(width: kScreenWidth, height: 10.0)
        }
    }
}
