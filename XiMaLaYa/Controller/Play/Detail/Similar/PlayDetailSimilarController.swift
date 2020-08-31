//
//  PlayDetailSimilarController.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/24.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class PlayDetailSimilarController: UIViewController, LTTableViewProtocal {
    private var albumResults: [ClassifyVerticalModel]?
    private let PlayDetailSimilarCellID = "PlayDetailSimilarCell"
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), self, self, nil)
        tableView.register(PlayDetailSimilarCell.self, forCellReuseIdentifier: PlayDetailSimilarCellID)
        tableView.uHead = URefreshHeader{ [weak self] in self?.setupLoadData() }
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
        // 刚进页面进行刷新
        self.tableView.uHead.beginRefreshing()
        setupLoadData()
    }
    func setupLoadData(){
        let api = PlayDetailAPI.playDetailLikeList(albumId:12825974)
        AF.request(api.url, method: .get, parameters: api.parameters, headers: nil).validate().responseJSON { response in
            if case let Result.success(jsonData) = response.result {
                let json = JSON(jsonData)
                if let mappedObject = JSONDeserializer<ClassifyVerticalModel>.deserializeModelArrayFrom(json: json["albums"].description) {
                    self.albumResults = mappedObject as? [ClassifyVerticalModel]
                    self.tableView.uHead.endRefreshing()
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension PlayDetailSimilarController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PlayDetailSimilarCell = tableView.dequeueReusableCell(withIdentifier: PlayDetailSimilarCellID, for: indexPath) as! PlayDetailSimilarCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.classifyVerticalModel = self.albumResults?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumId = self.albumResults?[indexPath.row].albumId ?? 0
        let vc = PlayDetailController(albumId: albumId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

