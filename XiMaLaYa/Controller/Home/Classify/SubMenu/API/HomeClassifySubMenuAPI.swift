//
//  HomeClassifySubMenuAPI.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/24.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import Foundation
import UIKit

// 请求分类
enum HomeClassifySubMenuAPI {
    // 顶部分类传参categoryID
    case headerCategoryList(categoryId: Int)
    // 推荐传参categoryID
    case classifyRecommendList(categoryId: Int)
    // 其他分类传参categoryId
    case classifyOtherContentList(keywordId: Int, categoryId: Int)
}

extension HomeClassifySubMenuAPI {
    var baseURL: String {
        return "https://mobile.ximalaya.com"
    }
    
    var path: String {
        switch self {
        case .headerCategoryList:
            return "/discovery-category/keyword/all/1534468874767"
        case .classifyRecommendList:
            return "/discovery-category/v2/category/recommend/ts-1534469064622"
        case .classifyOtherContentList:
            return "/mobile/discovery/v2/category/metadata/albums/ts-1534469378814"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .headerCategoryList(let categoryId):
            return ["device": "iPhone",
                    "gender": 9,
                    "categoryId": categoryId]
            
        case .classifyRecommendList(let categoryId):
            return ["appid": 0,
                    "device": "iPhone",
                    "gender": 9,
                    "inreview": false,
                    "network": "WIFI",
                    "operator": 3,
                    "scale": 3,
                    "uid": 124057809,
                    "version": "6.5.3",
                    "xt": Int32(Date().timeIntervalSince1970),
                    "deviceId": UIDevice.current.identifierForVendor!.uuidString,
                    "categoryId": categoryId]
            
        case .classifyOtherContentList(let keywordId, let categoryId):
            return ["calcDimension": "hot",
                    "device": "iPhone",
                    "pageId": 1,
                    "pageSize": 20,
                    "status": 0,
                    "version": "6.5.3",
                    "keywordId": keywordId,
                    "categoryId": categoryId]
        }
    }
    
    var url: String {
        return baseURL + path
    }
}
