//
//  HomeClassifyCell.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/24.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class HomeClassifyCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.width.height.equalTo(25)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalTo(self.imageView.snp.right).offset(5)
            make.top.bottom.equalTo(self.imageView)
            make.width.equalToSuperview().offset(-self.imageView.frame.width)
        }
    }
    
    var itemModel: ItemList? {
        didSet {
            guard let model = itemModel else { return }
            if model.itemType == 1 {// 如果是第一个item,是有图片显示的，并且字体偏小
                self.titleLabel.text = model.itemDetail?.keywordName
            } else {
                self.titleLabel.text = model.itemDetail?.title
                self.imageView.kf.setImage(with: URL(string: model.coverPath!))
            }
        }
    }
    
    // 带icon带item字体较小
    var indexPath: IndexPath? {
        didSet {
            guard let indexPath = indexPath else { return }
            if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2  {
                if indexPath.row == 0 {
                    self.titleLabel.font = UIFont.systemFont(ofSize: 13)
                } else {
                    self.imageView.snp.updateConstraints { (make) in
                        make.left.equalToSuperview()
                        make.width.equalTo(0)
                    }
                    self.titleLabel.snp.updateConstraints { (make) in
                        make.left.equalTo(self.imageView.snp.right)
                        make.width.equalToSuperview()
                    }
                    self.titleLabel.textAlignment = NSTextAlignment.center
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
