//
//  ListenSubscribeViewModel.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/19.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class ListenSubscribeViewModel: NSObject {
    var albumResults: [AlbumResultsModel]?
    var updateBlock: AddDataBlock?
}

// 请求数据
extension ListenSubscribeViewModel {
    func refreshDataSource() {
        let path = Bundle.main.path(forResource: "ListenSubscribe", ofType: "json")
        let jsonData = NSData(contentsOfFile: path!)
        let json = JSON(jsonData!)
        if let mappedObject = JSONDeserializer<AlbumResultsModel>.deserializeModelArrayFrom(json: json["data"]["albumResults"].description) {
            self.albumResults = mappedObject as? [AlbumResultsModel]
            self.updateBlock?()
        }
    }
}


extension ListenSubscribeViewModel {
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.albumResults?.count ?? 0
    }
}
