//
//  PlayDetailAPI.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/24.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import Foundation
import UIKit

enum PlayDetailAPI {
    case playDetailData(albumId: Int) // 播放页数据
    case playDetailLikeList(albumId: Int) // 播放页找相似
    case playDetailCircleList // 播放页圈子
}

extension PlayDetailAPI {
    // 服务器地址
    var baseURL: String {
        switch self {
        case .playDetailData:
            return "https://mobile.ximalaya.com"
        case .playDetailLikeList:
            return "https://ar.ximalaya.com"
        case .playDetailCircleList:
            return "https://m.ximalaya.com"
        }
    }
    
    var path: String {
        switch self {
        case .playDetailData:
            return "/mobile/v1/album/ts-1534832680180"
        case .playDetailLikeList:
            return "/rec-association/recommend/album/by_album"
        case .playDetailCircleList:
            return "/community/v1/communities/9"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .playDetailData(let albumId):
            return ["device":"iPhone",
                    "isAsc":false,
                    "isQueryInvitationBrand":false,
                    "pageSize":20,
                    "source":4,
                    "ac":"WIFI",
                    "albumId": albumId]
        case .playDetailLikeList(let albumId):
            return ["device":"iPhone",
                    "appid":0,
                    "network":"WIFI",
                    "operator":3,
                    "scale":3,
                    "uid":124057809,
                    "version":"6.5.3",
                    "xt": Int32(Date().timeIntervalSince1970),
                    "deviceId": UIDevice.current.identifierForVendor!.uuidString,
                    "albumId": albumId]
        case .playDetailCircleList:
            return ["orderBy":1,
                    "type":1]
        }
    }
    
    var url: String {
        return baseURL + path
    }
}
