//
//  HomeBroadcastAPI.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/20.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import Foundation

// 请求分类
enum HomeBroadcastAPI {
        case homeBroadcastList
        case categoryBroadcastList(path: String)
        case moreCategoryBroadcastList(categoryId: Int)
}

extension HomeBroadcastAPI {
    var baseURL: String {
        return "https://live.ximalaya.com"
    }
    
    var path: String {
            switch self {
            case .homeBroadcastList:
                return "/live-web/v5/homepage"
            case .categoryBroadcastList(let path):
                return path
            case .moreCategoryBroadcastList:
                return "/live-web/v2/radio/category"
            }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .categoryBroadcastList:
            return ["device": "iPhone",
                    "pageNum": 1,
                    "pageSize": 30,
                    "provinceCode": "310000"
            ]
        case .moreCategoryBroadcastList(let categoryId):
            return ["device": "iPhone",
                    "pageNum": 1,
                    "pageSize": 30,
                    "categoryId": categoryId]
        default:
            return nil
        }
        
    }
    
    var url: String {
        return baseURL + path
    }
}
