//
//  RecommendModel.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/13.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import Foundation
import HandyJSON

// 推荐动态 Model

struct FindRPicUrls: HandyJSON {
    var originUrl: String?
    var thumbnailUrl: String?
}

struct FindRStreamList: HandyJSON {
    var avatar: String?
    var commentsCount: Int = 0
    var content: String?
    var id: Int = 0
    var issuedTs: Int = 0
    var liked: Bool = false
    var likesCount: Int = 0
    var nickname: String?
    var picUrls: [FindRPicUrls]?
    var recSrc: String?
    var recTrack: String?
    var score: Int = 0
    var subType: Bool = false
    var type: String?
    var uid : Int = 0
}

struct FindRecommendModel: HandyJSON {
    var emptyTip: String?
    var endScore: Int = 0
    var hasMore: Bool = false
    var pullTip: String?
    var startScore: Int = 0
    var streamList: [FindRStreamList]?
}
