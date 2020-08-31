//
//  HomeLiveAPI.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/21.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import Foundation
import UIKit

// 请求分类
enum HomeLiveAPI {
    case liveClassifyList
    case liveBannerList
    case liveRankList
    case liveList
    case categoryLiveList(channelId: Int)
    case categoryTypeList(categoryType: Int)
}

extension HomeLiveAPI {
    var baseURL: String {
        switch self {
        case .liveBannerList:
            return "https://adse.ximalaya.com"
        case .categoryLiveList:
            return "https://mobwsa.ximalaya.com"
        default:
            return "https://mobile.ximalaya.com"
        }
    }
    
    var path: String {
        switch self {
        case .liveClassifyList:
            return "/lamia/v1/homepage/materials HTTP/1.1"
        case .liveRankList:
            return "/lamia/v2/live/rank_list"
        case .liveList:
            return "/lamia/v8/live/homepage"
        case .categoryLiveList:
            return "/lamia/v4/live/subchannel/homepage"
        case .categoryTypeList:
            return "/lamia/v9/live/homepage"
        default:
            return "/focusPicture/ts-1532427241140"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .categoryLiveList(let channelId):
            return ["appid":0,
                    "pageSize":40,
                    "network":"WIFI",
                    "operator":3,
                    "scale":3,
                    "pageId":1,
                    "device":"iPhone",
                    "version":"6.5.3",
                    "xt": Int32(Date().timeIntervalSince1970),
                    "channelId": channelId]
        case .categoryTypeList(let categoryType):
            return ["pageId":1,
                    "pageSize":20,
                    "sign":1,
                    "timeToPreventCaching": Int32(Date().timeIntervalSince1970),
                    "categoryType": categoryType]
        default:
            return ["appid":0,
                    "categoryId":-3,
                    "network":"WIFI",
                    "operator":3,
                    "scale":3,
                    "uid":0,
                    "device":"iPhone",
                    "version":"6.5.3",
                    "xt": Int32(Date().timeIntervalSince1970),
                    "deviceId": UIDevice.current.identifierForVendor!.uuidString]
        }
    }
    
    var url: String {
        return baseURL + path
    }
}
