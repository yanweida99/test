//
//  AttentionPictureCollectionViewCell.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/13.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class AttentionPictureCollectionViewCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()
    
    func setupLayout() {
        self.addSubview(self.imageView)
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = 5
        self.imageView.contentMode = UIView.ContentMode.scaleAspectFill
        self.imageView.clipsToBounds = true
        self.imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var picModel: FindAPicInfos? {
        didSet {
            guard let model = picModel else { return }
            self.imageView.kf.setImage(with: URL(string: model.originUrl!))
        }
    }
}
