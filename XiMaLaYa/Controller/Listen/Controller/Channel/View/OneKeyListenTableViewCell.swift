//
//  OneKeyListenTableViewCell.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/19.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class OneKeyListenTableViewCell: UITableViewCell {

    // 竖线
    var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = ButtonColor
        view.isHidden = true
        return view
    }()
    
    // 名字
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUpLayout() {
        self.addSubview(self.lineView)
        self.lineView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(4)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(30)
            make.left.equalTo(self.lineView.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    var channelClassInfo: ChannelClassInfoModel? {
        didSet {
            guard let model = channelClassInfo else { return }
            self.titleLabel.text = model.className
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
