//
//  PlayDetailIntroduceController.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/24.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class PlayDetailIntroduceController: UIViewController, LTTableViewProtocal {
    private var playDetailAlbum:PlayDetailAlbumModel?
    private var playDetailUser:PlayDetailUserModel?
    
    private let PlayContentIntroduceCellID = "PlayContentIntroduceCell"
    private let PlayAnchorIntroduceCellID  = "PlayAnchorIntroduceCell"
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), self, self, nil)
        tableView.register(PlayContentIntroduceCell.self, forCellReuseIdentifier: PlayContentIntroduceCellID)
        tableView.register(PlayAnchorIntroduceCell.self, forCellReuseIdentifier: PlayAnchorIntroduceCellID)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    // 内容简介model
    var playDetailAlbumModel:PlayDetailAlbumModel? {
        didSet{
            guard let model = playDetailAlbumModel else {return}
            self.playDetailAlbum = model
            // 防止刷新分区的时候界面闪烁
            UIView.performWithoutAnimation {
                self.tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: UITableView.RowAnimation.none)
            }
        }
    }
    // 主播简介model
    var playDetailUserModel:PlayDetailUserModel? {
        didSet{
            guard let model = playDetailUserModel else {return}
            self.playDetailUser = model
            // 防止刷新分区的时候界面闪烁
            UIView.performWithoutAnimation {
                self.tableView.reloadSections(NSIndexSet(index: 1) as IndexSet, with: UITableView.RowAnimation.none)
            }        }
        
    }
}

extension PlayDetailIntroduceController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell:PlayContentIntroduceCell = tableView.dequeueReusableCell(withIdentifier: PlayContentIntroduceCellID, for: indexPath) as! PlayContentIntroduceCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.playDetailAlbumModel = self.playDetailAlbum
            return cell
        } else {
            let cell:PlayAnchorIntroduceCell = tableView.dequeueReusableCell(withIdentifier: PlayAnchorIntroduceCellID, for: indexPath) as! PlayAnchorIntroduceCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.playDetailUserModel = self.playDetailUser
            return cell
        }
    }
}


