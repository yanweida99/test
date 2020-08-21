//
//  ListenAPI.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/18.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import Foundation
import Moya

let ListenProvider = MoyaProvider<ListenAPI>()

// 请求分类
public enum ListenAPI {
    case listenSubscribeList
    case listenChannelList
    case listenMoreChannelList
}

// 请求配置
extension ListenAPI: TargetType {
    public var path: String {
        switch self {
        case .listenSubscribeList:
            return "/subscribe/v2/subscribe/comprehensive/rank"
        case .listenChannelList:
            return "/radio-station/v1/subscribe-channel/list"
        default:
            return "/subscribe/v3/subscribe/recommend"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        var parmeters = ["pageId": 1] as [String: Any]
        switch self {
        case .listenSubscribeList:
            parmeters = ["pageSize":30,
                         "pageId":1,
                         "device":"iPhone",
                         "sign":2,
                         "size":30,
                         "tsuid":124057809,
                         "xt": Int32(Date().timeIntervalSince1970)] as [String: Any]
        case .listenChannelList:
            break
        default:
            parmeters = ["pageSize": 30,
                         "pageId": 1,
                         "device": "iPhone"] as [String: Any]
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    // 服务器地址
    public var baseURL: URL {
        return URL(string: "https://mobile.ximalaya.com")!
    }
    
    
}
