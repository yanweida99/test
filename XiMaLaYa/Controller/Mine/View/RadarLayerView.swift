//
//  RadarLayerView.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/11.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

// 麦克风雷达动画效果
class RadarLayerView: UIView {
    var pulseLayer: CAShapeLayer!  //定义图层
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let width = self.bounds.size.width
        
        // 动画图层
        pulseLayer = CAShapeLayer()
        pulseLayer.bounds = CGRect(x: 0, y: 0, width: width, height: width)
        pulseLayer.position = CGPoint(x: width / 2, y: width / 2)
        pulseLayer.backgroundColor = UIColor.clear.cgColor
        // 用BezierPath画一个圆形
        pulseLayer.path = UIBezierPath(ovalIn: pulseLayer.bounds).cgPath
        // 脉冲效果的颜色
        pulseLayer.fillColor = UIColor.init(r: 213, g: 54, b: 13).cgColor
        pulseLayer.opacity = 0.0
        
        // 关键代码
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.bounds = CGRect(x: 0, y: 0, width: width, height: width)
        replicatorLayer.position = CGPoint(x: width / 2, y: width / 2)
        replicatorLayer.instanceCount = 3 // 复制图层个数
        replicatorLayer.instanceDelay = 1 // 频率
        replicatorLayer.addSublayer(pulseLayer)
        self.layer.addSublayer(replicatorLayer)
        self.layer.insertSublayer(replicatorLayer, at: 0)
    }
    
    func starAnimation() {
        // 透明
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        // 起始值
        opacityAnimation.fromValue = 1.0
        // 结束值
        opacityAnimation.toValue = 0
        
        // 扩散动画
        let scaleAnimation = CABasicAnimation(keyPath: "transform")
        let t = CATransform3DIdentity
        scaleAnimation.fromValue = NSValue(caTransform3D: CATransform3DScale(t, 0.0, 0.0, 0.0))
        scaleAnimation.toValue = NSValue(caTransform3D: CATransform3DScale(t, 1.0, 1.0, 0.0))
        
        // 给CAShapeLayer添加组合动画
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [opacityAnimation, scaleAnimation]
        // 持续时间
        groupAnimation.duration = 3
        // 循环效果
        groupAnimation.autoreverses = false
        groupAnimation.repeatCount = HUGE
        groupAnimation.isRemovedOnCompletion = false
        pulseLayer.add(groupAnimation, forKey: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
}
