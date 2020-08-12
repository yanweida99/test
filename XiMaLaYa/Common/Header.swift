//
//  LBFMHeader.swift
//  LBFM-Swift
//
//  Created by liubo on 2019/2/1.
//  Copyright © 2019 刘博. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher
import SnapKit
import SwiftyJSON
import HandyJSON
import SwiftMessages


let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height

let ButtonColor = UIColor(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
let DownColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)


// iphone X
let isIphoneX = ScreenHeight == 812 ? true : false
// LBFMNavBarHeight
let NavBarHeight : CGFloat = isIphoneX ? 88 : 64
// LBFMTabBarHeight
let TabBarHeight : CGFloat = isIphoneX ? 49 + 34 : 49

