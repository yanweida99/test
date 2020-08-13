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
    typealias AddDataBlock = () -> Void
    var updateBlock: AddDataBlock?
}

// 请求数据
extension AttentionViewModel {
    func refreshDataSource() {
        
    }
}
