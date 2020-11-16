//
//  RecommendLiveCell.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/24.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class ReplicatorLayer: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        createLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func createLayer(){
        let layer = CALayer.init()
        layer.frame = self.bounds
        layer.backgroundColor = UIColor.white.cgColor
        layer.anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
        layer.add(self.scaleYAnimation(), forKey: "scaleAnimation")
        
        let replicatorLayer = CAReplicatorLayer.init()
        replicatorLayer.frame = self.bounds
        
        //设置复制层里面包含子层的个数
        replicatorLayer.instanceCount = 4
        
        //设置子层相对于前一个层的偏移量
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(5, 0, 0)
        
        //设置子层相对于前一个层的延迟时间
        replicatorLayer.instanceDelay = 0.2
        
        //设置层的颜色，(前提是要设置层的背景颜色，如果没有设置背景颜色，默认是透明的，再设置这个属性不会有效果。
        replicatorLayer.instanceColor = kButtonColor.cgColor
        
        //需要把子层加入到复制层中，复制层按照前面设置的参数自动复制
        replicatorLayer.addSublayer(layer)
        
        //将复制层加入view的层里面进行显示
        self.layer.addSublayer(replicatorLayer)
    }
}

extension ReplicatorLayer {
    fileprivate func scaleYAnimation() -> CABasicAnimation{
        let anim = CABasicAnimation.init(keyPath: "transform.scale.y")
        anim.toValue = 0.1
        anim.duration = 0.4
        anim.autoreverses = true
        anim.repeatCount = MAXFLOAT
        anim.isRemovedOnCompletion = false
        return anim
    }
}

class LBRecommendLiveCell: UICollectionViewCell {
    // 图片
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    // 标题
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    // 子标题
    private var subLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        return label
    }()
    
    // categoryName
    private var category: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.orange
        return label
    }()
    
    // 播放器动画效果
    private var replicatorLayer: ReplicatorLayer = {
        let layer = ReplicatorLayer.init(frame: CGRect(x: 0, y: 0, width: 2, height: 15))
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    func setUpUI(){
        self.addSubview(self.imageView)
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = 8
        self.imageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        self.imageView.addSubview(self.category)
        self.category.layer.masksToBounds = true
        self.category.layer.cornerRadius = 4
        self.category.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(30)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.subLabel)
        self.subLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
        }
        
        self.imageView.addSubview(self.replicatorLayer)
        self.replicatorLayer.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(20)
            make.height.equalTo(10)
        }
    }
    
    var recommendliveData:LiveModel? {
        didSet{
            guard let model = recommendliveData else { return }
            if model.coverMiddle != nil {
                self.imageView.kf.setImage(with: URL(string: model.coverMiddle!))
            }
            self.titleLabel.text = model.nickname
            self.subLabel.text = model.name
            self.category.text = model.categoryName
        }
    }
    
    var liveData:LiveModel? {
        didSet{
            guard let model = liveData else { return }
            if model.coverMiddle != nil {
                self.imageView.kf.setImage(with: URL(string: model.coverMiddle!))
            }
            self.titleLabel.text = model.nickname
            self.subLabel.text = model.name
            self.category.text = model.categoryName
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
