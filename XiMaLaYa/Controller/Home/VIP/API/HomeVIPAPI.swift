//
//  HomeVIPAPI.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/21.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import Foundation
import Moya

let HomeVIPAPIProvider = MoyaProvider<HomeVIPAPI>()

// 请求分类
public enum HomeVIPAPI {
    case homeVIPList
}

// 请求配置
extension HomeVIPAPI: TargetType {
    // 服务器地址
    public var baseURL: URL {
        switch self {
        case .homeVIPList:
            return URL(string: "https://mobile.ximalaya.com")!
        }
    }
    
    // 各个请求的具体路径
    public var path: String {
        switch self {
        case .homeVIPList:
            return "/product/v4/category/recommends/ts-1532592638951"
        }
    }
    
    public var method: Moya.Method { return .get }
    public var task: Task {
        let parameters = [
            "appid":0,
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
            "deviceId": UIDevice.current.identifierForVendor!.uuidString
            ] as [String : Any]
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
    public var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    public var headers: [String : String]? { return nil }
    
}
