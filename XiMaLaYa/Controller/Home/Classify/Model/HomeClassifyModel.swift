//
//  HomeClassifyModel.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/24.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import Foundation
import HandyJSON

struct HomeClassifyModel: HandyJSON {
    var list:[ClassifyModel]?
    var msg: String?
    var code: String?
    var ret: Int = 0
}

struct ClassifyModel: HandyJSON {
    var groupName: String?
    var displayStyleType: Int = 0
    var itemList:[ItemList]?
}

struct ItemList: HandyJSON {
    var itemType: Int = 0
    var coverPath: String?
    var isDisplayCornerMark: Bool = false
    var itemDetail: ItemDetail?
}

struct ItemDetail: HandyJSON {
    var categoryId: Int = 0
    var name: String?
    var title: String?
    var categoryType: Int = 0
    var moduleType: Int = 0
    var filterSupported: Bool = false
    var keywordId: Int = 0
    var keywordName: String?
}

