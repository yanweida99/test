//
//  ListenChannelViewModel.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/19.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class ListenChannelViewModel: NSObject {
    var channelResults: [ChannelResultsModel]?
    var updateBlock: AddDataBlock?
}

extension ListenChannelViewModel {
    func refreshDataSource() {
        let api = ListenAPI.listenChannelList
        AF.request(api.url, method: .get, parameters: api.parameters, headers: nil).validate().responseJSON { response in
            if case let Result.success(jsonData) = response.result {
                let json = JSON(jsonData)
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
