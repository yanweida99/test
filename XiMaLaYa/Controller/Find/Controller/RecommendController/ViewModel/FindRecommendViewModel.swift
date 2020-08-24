//
//  RecommendViewModel.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/14.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class FindRecommendViewModel: NSObject {
    var findRecommendModel: FindRecommendModel?
    var streamList: [FindRStreamList]?
    // 数据源更新
    typealias AddDataBlock = () -> Void
    var updateBlock: AddDataBlock?
}

// 请求数据
extension FindRecommendViewModel {
    func refreshDataSource() {
        // 1、获取JSON文件路径
        let path = Bundle.main.path(forResource: "FindRecommend", ofType: "json")
        // 2、获取JSON文件里面的内容，格式为NSData
        let jsonData = NSData(contentsOfFile: path!)
        // 3、解析JSON内容
        let json = JSON(jsonData!)
        if let mappedObject = JSONDeserializer<FindRecommendModel>.deserializeFrom(json: json["data"].description) {
            self.findRecommendModel = mappedObject
            self.streamList = mappedObject.streamList
            self.updateBlock?()
        }
    }
}

extension FindRecommendViewModel {
    // 每个分区显示item数量
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.streamList?.count ?? 0
    }
    // 高度
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        let picNum = self.streamList?[indexPath.row].picUrls?.count ?? 0
        var num: CGFloat = 0
        if picNum > 0 && picNum <= 3 {
            num = 1
        } else if picNum > 3 && picNum <= 6 {
            num = 2
        } else if picNum > 6 {
            num = 3
        }
        let onePictureHeight = CGFloat((ScreenWidth - 30) / 3)
        let pictureHeight = num * onePictureHeight
        let textHeight: CGFloat = height(for: self.streamList?[indexPath.row])
        return 60 + 50 + pictureHeight + textHeight
    }
    
    func height(for commentModel: FindRStreamList?) -> CGFloat {
        var height: CGFloat = 44
        guard let model = commentModel else { return height }
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.text = model.content
        height += label.sizeThatFits(CGSize(width: ScreenWidth - 30, height: CGFloat.infinity)).height + 10
        return height
    }
}
