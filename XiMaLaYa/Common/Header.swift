//
//  LBFMHeader.swift
//  LBFM-Swift
//
//  Created by liubo on 2019/2/1.
//  Copyright © 2019 刘博. All rights reserved.
//

import UIKit
import SnapKit
@_exported import Alamofire
@_exported import HandyJSON
@_exported import SwiftyJSON
@_exported import DNSPageView
@_exported import SwiftMessages
@_exported import LTScrollView

let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

let kButtonColor = UIColor(red: 242 / 255.0, green: 77 / 255.0, blue: 51 / 255.0, alpha: 1)
let kBackgroundColor = UIColor.init(red: 240 / 255.0, green: 241 / 255.0, blue: 244 / 255.0, alpha: 1)


// iphone X
let isIphoneX = kScreenHeight == 812 ? true : false
// NavBarHeight
let kNavBarHeight: CGFloat = isIphoneX ? 88 : 64
// TabBarHeight
let kTabBarHeight: CGFloat = isIphoneX ? 49 + 34 : 49
let kNavBarBottom = WRNavigationBar.navBarBottom()

typealias AddDataBlock = () ->Void
