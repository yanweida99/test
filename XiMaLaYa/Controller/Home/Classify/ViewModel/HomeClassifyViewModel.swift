//
//  HomeClassifyViewModel.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/24.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HomeClassifyViewModel: NSObject {
    var classifyModel: [ClassifyModel]?
    // 数据源更新
    typealias AddDataBlock = () -> Void
    var updateBlock: AddDataBlock?
}

extension HomeClassifyViewModel {
    func refreshDataSource() {
        // 首页分类接口请求
        HomeClassifyProvider.request(.classifyList) { result in
            if case let .success(responce) = result {
                // 解析数据
                let data = try? responce.mapJSON()
                let json = JSON(data!)
                // 从字符串转换为对象实例
                if let mappedObject = JSONDeserializer<HomeClassifyModel>.deserializeFrom(json: json.description) {
                    self.classifyModel = mappedObject.list
                }
                self.updateBlock?()
            }
        }
    }
}

// - collectionview数据
extension HomeClassifyViewModel {
    func numberOfSections(collectionView:UICollectionView) ->Int {
        return self.classifyModel?.count ?? 0
    }
    // 每个分区显示item数量
    func numberOfItemsIn(section: NSInteger) -> NSInteger {
        return self.classifyModel?[section].itemList?.count ?? 0
    }
    // 每个分区的内边距
    func insetForSectionAt(section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 2.5, bottom: 0, right: 2.5)
    }
    
    // 最小 item 间距
    func minimumInteritemSpacingForSectionAt(section:Int) ->CGFloat {
        return 0
    }
    
    // 最小行间距
    func minimumLineSpacingForSectionAt(section:Int) ->CGFloat {
        return 2
    }
    
    // item 尺寸
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 {
            return CGSize.init(width:(ScreenWidth - 10) / 4,height:40)
        }else {
            return CGSize.init(width:(ScreenWidth - 7.5) / 3,height:40)
        }
    }
    
    // 分区头视图size
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        if section == 0 || section == 1 || section == 2 {
            return .zero
        }else {
            return CGSize.init(width: ScreenHeight, height:30)
        }
    }
    
    // 分区尾视图size
    func referenceSizeForFooterInSection(section: Int) -> CGSize {
        return CGSize.init(width: ScreenWidth, height: 8.0)
    }
}

