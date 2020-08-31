//
//  PlayAPI.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/24.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import Foundation
import UIKit

enum PlayAPI {
    case fmPlayData(albumId: Int, trackUid: Int, uid: Int)
}

extension PlayAPI {
    // 服务器地址
    var baseURL: String {
        return "https://mobile.ximalaya.com"
    }
    
    var path: String {
        switch self {
        case .fmPlayData(_, let trackUid, _):
            return "/mobile/track/v2/playpage/\(trackUid)"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fmPlayData(let albumId, _, let uid):
            return [
                "device":"iPhone",
                "operator":3,
                "scale":3,
                "appid":0,
                "ac":"WIFI",
                "network":"WIFI",
                "version":"6.5.3",
                "uid":124057809,
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString,
                "albumId": albumId,
                "trackUid": uid]
        }
    }
    
    var url: String {
        return baseURL + path
    }
}
