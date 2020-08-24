//
//  PlayDetailProgramController.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/24.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit
import LTScrollView

class PlayDetailProgramController: UIViewController, LTTableViewProtocal {
    private var playDetailTracks:PlayDetailTracksModel?
    
    private let PlayDetailProgramCellID = "PlayDetailProgramCell"
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y:0, width:ScreenWidth, height: ScreenHeight), self, self, nil)
        tableView.register(PlayDetailProgramCell.self, forCellReuseIdentifier: PlayDetailProgramCellID)
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
    
    var playDetailTracksModel:PlayDetailTracksModel?{
        didSet{
            guard let model = playDetailTracksModel else {return}
            self.playDetailTracks = model
            self.tableView.reloadData()
        }
    }
}

extension PlayDetailProgramController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playDetailTracks?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PlayDetailProgramCell = tableView.dequeueReusableCell(withIdentifier: PlayDetailProgramCellID, for: indexPath) as! PlayDetailProgramCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.playDetailTracksList = self.playDetailTracks?.list?[indexPath.row]
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumId = self.playDetailTracks?.list?[indexPath.row].albumId ?? 0
        let trackUid = self.playDetailTracks?.list?[indexPath.row].trackId ?? 0
        let uid = self.playDetailTracks?.list?[indexPath.row].uid ?? 0
        let vc = NavigationController.init(rootViewController: PlayController(albumId:albumId, trackUid:trackUid, uid:uid))
        self.present(vc, animated: true, completion: nil)
    }
}


