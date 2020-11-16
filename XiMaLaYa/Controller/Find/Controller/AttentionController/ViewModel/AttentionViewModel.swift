//
//  AttentionViewModel.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/13.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class AttentionViewModel: NSObject {
    var eventInfos: [EventInfosModel]?
    // 数据源更新
    var updateBlock: AddDataBlock?
}

// 请求数据
extension AttentionViewModel {
    func refreshDataSource() {
        // 1、获取JSON文件路径
        let path = Bundle.main.path(forResource: "FindAttention", ofType: "json")
        // 2、获取JSON文件里面的内容，格式为NSData
        let jsonData = NSData(contentsOfFile: path!)
        // 3、解析JSON内容
        let json = JSON(jsonData!)
        if let mappedObject = JSONDeserializer<EventInfosModel>.deserializeModelArrayFrom(json: json["data"]["eventInfos"].description) {
            self.eventInfos = mappedObject as? [EventInfosModel]
            self.updateBlock?()
        }
    }
}

extension AttentionViewModel {
    // 每个分区显示item数量
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.eventInfos?.count ?? 0
    }
    // 高度
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        let picNum = self.eventInfos?[indexPath.row].contentInfo?.picInfos?.count ?? 0
        var num: CGFloat = 0
        if picNum > 0 && picNum <= 3 {
            num = 1
        } else if picNum > 3 && picNum <= 6 {
            num = 2
        } else if picNum > 6 {
            num = 3
        }
        let onePictureHeight = CGFloat((kScreenWidth - 30) / 3)
        let pictureHeight = num * onePictureHeight
        let textHeight: CGFloat = height(for: self.eventInfos?[indexPath.row].contentInfo)
        return 60 + 50 + pictureHeight + textHeight
    }
    
    func height(for commentModel: FindAContentInfo?) -> CGFloat {
        var height: CGFloat = 44
        guard let model = commentModel else { return height }
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.text = model.text
        height += label.sizeThatFits(CGSize(width: kScreenWidth - 30, height: CGFloat.infinity)).height + 10
        return height
    }
}
