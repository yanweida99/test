//
//  HomeVIPAPI.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/21.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import Foundation
import UIKit

// 请求分类
enum HomeVIPAPI {
    case homeVIPList
}

// 请求配置
extension HomeVIPAPI {
    // 服务器地址
    var baseURL: String {
        switch self {
        case .homeVIPList:
            return "https://mobile.ximalaya.com"
        }
    }
    
    // 各个请求的具体路径
    var path: String {
        switch self {
        case .homeVIPList:
            return "/product/v4/category/recommends/ts-1532592638951"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .homeVIPList:
            return ["appid":0,
            "categoryId":33,
            "contentType":"album",
            "inreview":false,
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
