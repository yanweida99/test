//
//  HomeBroadcastAPI.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/20.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import Foundation
import Moya

let HomeBroadcastAPIProvider = MoyaProvider<HomeBroadcastAPI>()

// 请求分类
public enum HomeBroadcastAPI {
    case homeBroadcastList
    case categoryBroadcastList(path: String)
    case moreCategoryBroadcastList(categoryId: Int)
}

// 请求配置
extension HomeBroadcastAPI: TargetType {
    // 服务器地址
    public var baseURL: URL {
        return URL(string: "https://live.ximalaya.com")!
    }
    
    // 各个请求的具体路径
    public var path: String {
        switch self {
        case .homeBroadcastList:
            return "/live-web/v5/homepage"
        case .categoryBroadcastList(let path):
            return path
        case .moreCategoryBroadcastList:
            return "/live-web/v2/radio/category"
        }
    }
    
    // 请求类型
    public var method: Moya.Method {
        return .get
    }
    
    // 请求任务事件
    public var task: Task {
        switch self {
        case .homeBroadcastList:
            return .requestPlain
        case .categoryBroadcastList:
            let parameters = [
                "device": "iPhone",
                "pageNum": 1,
                "pageSize": 30,
                "provinceCode": "310000"
                ] as [String: Any]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .moreCategoryBroadcastList(let categoryId):
            var parameters = [
                "device": "iPhone",
                "pageNum": 1,
                "pageSize": 30
                ] as [String: Any]
            parameters["categoryId"] = categoryId
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    // 是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    
    // 这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    // 请求头
    public var headers: [String : String]? {
        return nil
    }
    
}
