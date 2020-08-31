//
//  ListenAPI.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/18.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import Foundation

enum ListenAPI {
    case listenSubscribeList
    case listenChannelList
    case listenMoreChannelList
}

extension ListenAPI {
    var baseURL: String {
        return "https://mobile.ximalaya.com"
    }
    
    var path: String {
        switch self {
        case .listenSubscribeList:
            return "/subscribe/v2/subscribe/comprehensive/rank"
        case .listenChannelList:
            return "/radio-station/v1/subscribe-channel/list"
        default:
            return "/subscribe/v3/subscribe/recommend"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .listenSubscribeList:
            return ["pageSize":30,
                    "pageId":1,
                    "device":"iPhone",
                    "sign":2,
                    "size":30,
                    "tsuid":124057809,
                    "xt": Int32(Date().timeIntervalSince1970)]
        default:
            return ["pageSize": 30,
                    "pageId": 1,
                    "device": "iPhone"]
        }
    }
    
    var url: String {
        return baseURL + path
    }
}
