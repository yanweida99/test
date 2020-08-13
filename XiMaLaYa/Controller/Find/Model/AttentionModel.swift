//
//  AttentionModel.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/13.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import Foundation
import HandyJSON

// 关注动态 Model
struct AttentionAuthorInfo: HandyJSON {
    var anchorGrade: Int = 0
    var avatarUrl: String?
    var isV: Bool = false
    var isVip: Bool = false
    var nickname: String?
    var uid: NSInteger = 0
    var userGrade: Int = 0
    var verifyType: Int = 0
}

struct FindAPicInfos: HandyJSON {
    var id: NSInteger = 0
    var originUrl: String?
    var rectangleUrl: String?
    var squareUrl: String?
}

struct FindAContentInfo: HandyJSON {
    var picInfos: [FindAPicInfos]?
    var text: String?
}

struct FindAStatInfo: HandyJSON {
    var commentCount: Int = 0
    var praiseCount: Int = 0
    var repostCount: Int = 0
}

struct EventInfosModel: HandyJSON {
    var authorInfo: AttentionAuthorInfo?
    var contentInfo: FindAContentInfo?
    var eventTime: NSInteger = 0
    var id: NSInteger = 0
    var isFromRepost: Bool = false
    var isPraise: Bool = false
    var statInfo: FindAStatInfo?
    var timeline: NSInteger = 0
    var type: Int = 0
}
