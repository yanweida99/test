//
//  ClassifySubModuleType17Cell.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/24.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class ClassifySubModuleType17Cell: UICollectionViewCell {
    
    private var imageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
        }
    }
    var classifyVerticalModel: ClassifyVerticalModel? {
        didSet {
            guard let model = classifyVerticalModel else {return}
            self.imageView.kf.setImage(with: URL(string: model.coverPath!))
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

