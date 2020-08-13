//
//  DubbingModel.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/13.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import Foundation
import HandyJSON

// 趣配音 Model
struct FindDudModel: HandyJSON {
    var dubbingItem: FindDuddubbingItem?
    var feedItem: FindDudfeedItem?
}

struct FMFindDudModel: HandyJSON {
    var data: [FindDudModel]?
}

struct FindDuddubbingItem: HandyJSON {
    var commentCount: Int = 0
    var coverLarge: String?
    var coverMiddle: String?
    var coverPath: String?
    var coverSmall: String?
    var createAt: NSInteger = 0
    var duration: Int = 0
    var favorites: Int = 0
    var intro: String?
    var logoPic: String?
    var mediaType: String?
    var nickname: String?
    var playPathAacv164: String?
    var playPathAacv224: String?
    var relatedId: Int = 0
    var title: String?
    var topicId: Int = 0
    var topicTitle: String?
    var topicUrl: String?
    var trackId: Int = 0
    var uid: Int = 0
    var updatedAt: Int = 0
}

struct FindDudfeedItem: HandyJSON {
    var contentId: Int = 0
    var contentType: String?
    var recReason: String?
    var recSrc: String?
    var recTrack: String?
}







