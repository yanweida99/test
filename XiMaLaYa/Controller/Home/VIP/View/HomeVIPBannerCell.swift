//
//  HomeVIPBannerCell.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/21.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit
import FSPagerView

// 添加cell点击代理方法
protocol HomeVIPBannerCellDelegate: NSObjectProtocol {
    func homeVIPBannerCellClick(url: String)
}

class HomeVIPBannerCell: UITableViewCell {
    weak var delegate: HomeVIPBannerCellDelegate?
    
    var vipBanner: [FocusImagesData]?
    
    // - 懒加载滚动图片浏览器
    private lazy var pagerView: FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.automaticSlidingInterval =  3
        pagerView.isInfinite = true
        pagerView.interitemSpacing = 15
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "HomeVipBannerCell")
        return pagerView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.pagerView)
        self.pagerView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalToSuperview()
        }
        self.pagerView.itemSize = CGSize.init(width: ScreenWidth-60, height: 140)
        
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var vipBannerList: [FocusImagesData]? {
        didSet {
            guard let model = vipBannerList else { return }
            self.vipBanner = model
            self.pagerView.reloadData()
        }
    }
}

extension HomeVIPBannerCell: FSPagerViewDelegate, FSPagerViewDataSource {
    // - FSPagerView Delegate
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.vipBanner?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "HomeVipBannerCell", at: index)
        cell.imageView?.kf.setImage(with: URL(string:(self.vipBanner?[index].cover)!))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let url: String = self.vipBanner?[index].link ?? ""
        delegate?.homeVIPBannerCellClick(url: url)
    }
}
