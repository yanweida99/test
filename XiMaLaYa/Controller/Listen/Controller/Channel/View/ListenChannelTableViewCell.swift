//
//  ListenChannelTableViewCell.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/19.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit
import JXMarqueeView

class ListenChannelTableViewCell: UITableViewCell {
    private let marqueeView = JXMarqueeView()
    
    // 背景大图
    private var pictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    // 标题
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    // 滚动文字
    private var scrollLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    // 播放按钮
    private var playButton: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "whitePlay"), for: UIControl.State.normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUpLayout(){
        self.addSubview(self.pictureView)
        self.pictureView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        self.pictureView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(20)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        // 文字跑马灯效果
        marqueeView.contentView = self.scrollLabel
        marqueeView.contentMargin = 10
        marqueeView.marqueeType = .reverse
        self.pictureView.addSubview(marqueeView)
        marqueeView.snp.makeConstraints { make in
            make.left.equalTo(self.titleLabel)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.height.equalTo(25)
            make.left.equalTo(self.titleLabel)
            make.right.equalToSuperview().offset(-70)
        }
        
        self.pictureView.addSubview(self.playButton)
        self.playButton.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview().offset(-15)
            make.width.height.equalTo(45)
        }
    }
    
    // 一键听主页数据模型
    var channelResults: ChannelResultsModel? {
        didSet {
            guard let model = channelResults else { return }
            self.pictureView.kf.setImage(with: URL(string: model.bigCover!))
            self.titleLabel.text = model.channelName
            self.scrollLabel.text = model.slogan
        }
    }
    
    // 更多频道数据模型
    var channelInfoModel: ChannelInfosModel? {
        didSet {
            guard let model = channelInfoModel else { return }
            self.pictureView.kf.setImage(with: URL(string: model.bigCover!))
            self.titleLabel.text = model.channelName
            self.scrollLabel.text = model.slogan
            self.titleLabel.font = UIFont.systemFont(ofSize: 22)
            self.scrollLabel.font = UIFont.systemFont(ofSize: 16)
        }
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
