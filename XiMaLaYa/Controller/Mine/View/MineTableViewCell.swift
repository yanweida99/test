//
//  MineTableViewCell.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/11.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class MineTableViewCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        setUpLayout()
    }
    
    // 布局
    func setUpLayout(){
        let margin: CGFloat = kScreenWidth / 8
        let titleArray = ["我要录音", "我要直播", "我的作品", "主播工作台"]
        let imageArray = ["microphone", "live", "video", "workbench"]
        for index in 0..<4 {
            let button = UIButton.init(frame: CGRect(x: margin * CGFloat(index) * 2 + margin / 2, y: 10, width: margin, height: margin))
            button.setImage(UIImage(named: imageArray[index]), for: UIControl.State.normal)
            self.addSubview(button)
            
            let titleLabel = UILabel()
            titleLabel.textAlignment = .center
            titleLabel.text = titleArray[index]
            titleLabel.font = UIFont.systemFont(ofSize: 15)
            if index == 0 {
                titleLabel.textColor = UIColor.init(r: 213, g: 54, b: 13)
                let waveView = RadarLayerView(frame: CGRect(x: margin * CGFloat(index) * 2 + margin / 2, y: 10, width: margin, height: margin))
                waveView.center = button.center
                self.addSubview(waveView)
                waveView.starAnimation() // 开始动画
            } else {
                titleLabel.textColor = UIColor.gray
            }
            self.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                make.centerX.equalTo(button)
                make.width.equalTo(margin + 30)
                make.top.equalTo(margin + 10 + 5)
            }
            button.tag = index
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
