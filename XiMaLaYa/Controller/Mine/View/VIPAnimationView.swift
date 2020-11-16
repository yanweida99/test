//
//  VIPAnimationView.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/11.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class VIPAnimationView: UIView {
    // 图片
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "vip")
        return imageView
    }()
    
    // 标题
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "VIP会员"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    // 介绍
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "免费领取7天会员"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    // 箭头
    private lazy var arrowsLabel: UILabel = {
        let label = UILabel()
        label.text = ">"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(r: 212, g: 212, b: 212)
        setUpLayout()
    }
    
    func setUpLayout(){
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(5)
            make.width.height.equalTo(30)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalTo(self.imageView.snp.right).offset(5)
            make.width.equalTo(100)
            make.height.equalTo(20)
            make.centerY.equalTo(self.imageView)
        }
        
        self.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.top.equalTo(self.imageView.snp.bottom).offset(5)
            make.width.equalTo(180)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.arrowsLabel)
        self.arrowsLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.width.height.equalTo(20)
            make.top.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
