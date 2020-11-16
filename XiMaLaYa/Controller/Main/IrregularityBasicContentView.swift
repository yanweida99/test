//
//  IrregularityBasicContentView.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/11.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit
import ESTabBarController_swift


class IrregularityBasicContentView: ESTabBarItemContentView {
    
    public var duration = 0.3

    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = UIColor.init(white: 175.0 / 255.0, alpha: 1.0)
        highlightTextColor = UIColor.init(red: 254 / 255.0, green: 73 / 255.0, blue: 42 / 255.0, alpha: 1.0)
        iconColor = UIColor.init(white: 175.0 / 255.0, alpha: 1.0)
        highlightIconColor = UIColor.init(red: 254 / 255.0, green: 73 / 255.0, blue: 42 / 255.0, alpha: 1.0)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    override func reselectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    func bounceAnimation() {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        impliesAnimation.duration = duration * 2
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        imageView.layer.add(impliesAnimation, forKey: nil)
    }
}

class IrregularityContentView: ESTabBarItemContentView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView.backgroundColor = UIColor.init(red: 250 / 255.0, green: 48 / 255.0, blue: 32 / 255.0, alpha: 1.0)
        self.imageView.layer.borderWidth = 2.0
        self.imageView.layer.borderColor = UIColor.init(white: 235 / 255.0, alpha: 1.0).cgColor
        self.imageView.layer.cornerRadius = 25
        self.insets = UIEdgeInsets.init(top: -23, left: 0, bottom: 0, right: 0)
        let transform = CGAffineTransform.identity
        self.imageView.transform = transform
        self.superview?.bringSubviewToFront(self)
        
        textColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        highlightTextColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        iconColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        highlightIconColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        backdropColor = .clear
        highlightBackdropColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func updateLayout() {
        super.updateLayout()
        self.imageView.sizeToFit()
        self.imageView.center = CGPoint.init(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
    }
}
