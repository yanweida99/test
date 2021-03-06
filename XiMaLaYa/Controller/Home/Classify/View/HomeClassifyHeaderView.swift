//
//  HomeClassifyHeaderView.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/24.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class HomeClassifyHeaderView: UICollectionReusableView {
    
    lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = kButtonColor
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = kBackgroundColor
        self.addSubview(self.view)
        self.view.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(6)
            make.bottom.equalTo(-6)
            make.width.equalTo(4)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalTo(self.view.snp.right).offset(10)
            make.right.equalTo(-10)
            make.top.bottom.equalToSuperview()
        }
    }
    
    var titleString: String? {
        didSet{
            guard let str = titleString else { return }
            self.titleLabel.text = str
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
