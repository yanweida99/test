//
//  HomeCategoryAPI.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/27.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import Foundation

// 请求分类
enum HomeCategoryAPI {
    case classifyList
}

extension HomeCategoryAPI {
    var baseURL: String {
        switch self {
        case.classifyList:
            return "https://mobile.ximalaya.com"
        }
    }
    
    var path: String {
        switch self {
        case .classifyList:
            return "/mobile/discovery/v5/categories/1532410996452?channel=ios-b1&code=43_310000_3100&device=iPhone&gender=9&version=6.5.3%20HTTP/1.1"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
    
    var url: String {
        return baseURL + path
    }
}
