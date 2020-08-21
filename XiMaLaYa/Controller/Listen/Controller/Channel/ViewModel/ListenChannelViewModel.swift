//
//  ListenChannelViewModel.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/19.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class ListenChannelViewModel: NSObject {
    var channelResults: [ChannelResultsModel]?
    typealias AddDataBlock = () -> Void
    var updateBlock: AddDataBlock?
}

extension ListenChannelViewModel {
    func refreshDataSource() {
        ListenProvider.request(.listenChannelList) { result in
            if case let .success(responce) = result {
                let data = try? responce.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<ChannelResultsModel>.deserializeModelArrayFrom(json: json["data"]["channelResults"].description) {
                    self.channelResults = mappedObject as? [ChannelResultsModel]
                    self.updateBlock?()
                }
            }
        }
    }
}

extension ListenChannelViewModel {
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.channelResults?.count ?? 0
    }
}
