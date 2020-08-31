//
//  PlayDetailProgramHeaderView.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/24.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class PlayDetailProgramHeaderView: UIView {
    private lazy var playBtn:UIButton = {
        // 收听全部
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setTitle("收听全部", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setImage(UIImage(named: "play"), for: UIControl.State.normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        button.backgroundColor = ButtonColor
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    func setUpLayout(){
        self.addSubview(self.playBtn)
        self.playBtn.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.width.equalTo(80)
            make.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
