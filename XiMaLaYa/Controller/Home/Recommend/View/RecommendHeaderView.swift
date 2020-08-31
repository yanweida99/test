//
//  RecommendHeaderView.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/24.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

// 创建闭包 - OC中的block
typealias HeaderMoreButtonClick = () ->Void

class RecommendHeaderView: UICollectionReusableView {
    var headerMoreButtonClick: HeaderMoreButtonClick?
    
    // 标题
    private var titleLabel:UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        return titleLabel
    }()
    // 副标题
    private var subLabel:UILabel = {
        let subLabel = UILabel.init()
        subLabel.font = UIFont.systemFont(ofSize: 15)
        subLabel.textColor = UIColor.lightGray
        subLabel.textAlignment = .right
        return subLabel
    }()
    // 更多
    private var moreButton:UIButton = {
        let moreButton = UIButton.init(type: .custom)
        moreButton.setTitle("更多 >", for: .normal)
        moreButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        moreButton.addTarget(self, action: #selector(moreButtonClick(moreButton:)), for: .touchUpInside)
        return moreButton
    }()
    
    @objc func moreButtonClick(moreButton:UIButton) {
        // 闭包回调
        guard let headerMoreButtonnClick = headerMoreButtonClick else { return }
        headerMoreButtonnClick()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeaderView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // 布局
    func setupHeaderView() {
        
        self.addSubview(self.titleLabel)
        self.titleLabel.text = "猜你喜欢"
        self.titleLabel.snp.makeConstraints { make in
            make.left.top.equalTo(15)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        self.addSubview(self.subLabel)
        //        self.subLabel.text = "副标题"
        subLabel.textColor = UIColor.red
        self.subLabel.snp.makeConstraints { make in
            make.left.equalTo(self.titleLabel.snp.right)
            make.height.top.equalTo(self.titleLabel)
            make.right.equalToSuperview().offset(-100)
        }
        self.addSubview(self.moreButton)
        //        self.moreButton.setTitle("您好", for: .normal)
        self.moreButton.snp.makeConstraints { make in
            make.right.equalTo(15)
            make.top.equalTo(15)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
    }
    var homeRecommendList:RecommendModel? {
        didSet{
            guard let model = homeRecommendList else { return }
            if model.title != nil {
                self.titleLabel.text = model.title
            } else {
                self.titleLabel.text = "猜你喜欢"
            }
        }
    }
}
