//
//  ListenRecommendViewModel.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/19.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class ListenRecommendViewModel: NSObject {
    var albums: [albumsModel]?
    typealias AddDataBlock = () -> Void
    var updateBlock: AddDataBlock?
}

extension ListenRecommendViewModel {
    func refreshDataSource() {
        let path = Bundle.main.path(forResource: "ListenRecommend", ofType: "json")
        let jsonData = NSData(contentsOfFile: path!)
        let json = JSON(jsonData!)
        if let mappedObject = JSONDeserializer<albumsModel>.deserializeModelArrayFrom(json: json["data"]["albums"].description) {
            self.albums = mappedObject as? [albumsModel]
            self.updateBlock?()
        }
    }
}

extension ListenRecommendViewModel {
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.albums?.count ?? 0
    }
}
