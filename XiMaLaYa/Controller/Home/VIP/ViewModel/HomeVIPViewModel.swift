//
//  HomeVIPViewModel.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/21.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HomeVIPViewModel: NSObject {
    
    var homeVIPData: HomeVipModel?
    var focusImages: [FocusImagesData]?
    var categoryList: [CategoryList]?
    var categoryButtonList: [CategoryButtonModel]?
    // 数据源更新
    typealias AddDataBlock = () -> Void
    var updateBlock: AddDataBlock?
    
    // 每个分区显示item数量
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        switch section {
        case HomeVIPSectionVIP:
            return self.categoryList?[section].list?.count ?? 0
        default:
            return 1
        }
    }
    // 高度
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case HomeVIPSectionBanner:
            return 150
        case HomeVIPSectionGrid:
            return 80
        case HomeVIPSectionHot:
            return 190
        case HomeVIPSectionEnjoy:
            return 230
        default:
            return 120
        }
    }
    
    // header高度
    func heightForHeaderInSection(section:Int) ->CGFloat {
        if section == HomeVIPSectionBanner || section == HomeVIPSectionGrid {
            return 0.0
        }else {
            return 50
        }
    }
    
    // footer 高度
    func heightForFooterInSection(section:Int) ->CGFloat {
        if section == HomeVIPSectionBanner {
            return 0.0
        }else {
            return 10
        }
    }
}

// Mark:-请求数据
extension HomeVIPViewModel {
    func refreshDataSource() {
        // 首页vip接口请求
        HomeVIPAPIProvider.request(.homeVIPList) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<HomeVipModel>.deserializeFrom(json: json.description) {
                    self.homeVIPData = mappedObject
                    self.focusImages = mappedObject.focusImages?.data
                    self.categoryList = mappedObject.categoryContents?.list
                }
                if let categorybtn = JSONDeserializer<CategoryButtonModel>.deserializeModelArrayFrom(json:json["categoryContents"]["list"][0]["list"].description){
                    self.categoryButtonList = categorybtn as? [CategoryButtonModel]
                }
                self.updateBlock?()
            }
        }
    }
}



