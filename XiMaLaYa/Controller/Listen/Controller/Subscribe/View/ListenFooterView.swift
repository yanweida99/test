//
//  ListenFooterView.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/19.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

protocol ListenFooterViewDelegate: NSObjectProtocol {
    func listenFooterAddButtonClick()
}

class ListenFooterView: UIView {
    weak var delegate: ListenFooterViewDelegate?
    
    private var addButton: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(addButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayout() {
        self.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(40)
            make.width.equalTo(120)
            make.centerX.equalToSuperview()
        }
        addButton.layer.masksToBounds = true
        addButton.layer.cornerRadius = 20
    }
    
    var listenFooterViewTitle: String? {
        didSet {
            addButton.setTitle(listenFooterViewTitle, for: UIControl.State.normal)
        }
    }
    
    @objc func addButtonClick() {
        delegate?.listenFooterAddButtonClick()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
