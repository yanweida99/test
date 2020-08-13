//
//  BasicContentView.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/11.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import ESTabBarController_swift

class BasicContentView: ESTabBarItemContentView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = UIColor.init(white: 175.0 / 255.0, alpha: 1.0)
        highlightTextColor = UIColor.init(red: 254 / 255.0, green: 73 / 255.0, blue: 42 / 255.0, alpha: 1.0)
        iconColor = UIColor.init(white: 175.0 / 255.0, alpha: 1.0)
        highlightTextColor = UIColor.init(red: 254 / 255.0, green: 73 / 255.0, blue: 42 / 255.0, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
