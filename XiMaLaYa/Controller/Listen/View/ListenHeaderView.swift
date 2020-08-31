//
//  ListenHeaderView.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/19.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class ListenHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUpLayout() {
        let downView = UIView()
        downView.backgroundColor = DownColor
        self.addSubview(downView)
        downView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(10)
        }
        let margin: CGFloat = self.frame.width / 8
        let titleArray = ["下载", "历史", "购物车", "喜欢"]
        let imageArray = ["下载", "历史", "购物车", "喜欢"]
        let numberArray = ["暂无", "8", "暂无", "25"]
        for index in 0..<4 {
            let button = UIButton.init(frame: CGRect(x: margin * CGFloat(index) * 2 + margin / 2, y: 10, width: margin, height: margin))
            button.setImage(UIImage(named: imageArray[index]), for: UIControl.State.normal)
            self.addSubview(button)
            
            let titleLabel = UILabel()
            titleLabel.textAlignment = .center
            titleLabel.text = titleArray[index]
            titleLabel.font = UIFont.systemFont(ofSize: 15)
            titleLabel.textColor = UIColor.gray
            self.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                make.centerX.equalTo(button)
                make.width.equalTo(margin + 20)
                make.top.equalTo(margin + 10)
            }
            
            let numberLabel = UILabel()
            numberLabel.textAlignment = .center
            numberLabel.text = numberArray[index]
            numberLabel.font = UIFont.systemFont(ofSize: 14)
            numberLabel.textColor = UIColor.gray
            self.addSubview(numberLabel)
            numberLabel.snp.makeConstraints { make in
                make.centerX.equalTo(button)
                make.width.equalTo(margin + 20)
                make.top.equalTo(margin + 10 + 25)
            }
            button.tag = index
            button.addTarget(self, action: #selector(gridButtonClick(sender:)), for: UIControl.Event.touchUpInside)
        }
    }
    
    @objc func gridButtonClick(sender: UIButton) {
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
