//
//  ListenChannelController.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/19.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class ChannelController: UIViewController, LTTableViewProtocal {

    // footerView
    private lazy var footerView: ListenFooterView = {
        let view = ListenFooterView.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 100))
        view.listenFooterViewTitle = "➕添加频道"
        view.delegate = self
        return view
    }()
    
    private let ListenChannelTableViewCellID = "ListenChannelTableViewCell"
    
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 5, width: ScreenWidth, height: ScreenHeight - 64), self, self, nil)
        tableView.register(ListenChannelTableViewCell.self, forCellReuseIdentifier: ListenChannelTableViewCellID)
        tableView.backgroundColor = UIColor.init(r: 240, g: 241, b: 244)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableFooterView = self.footerView
        return tableView
    }()
    
    lazy var viewModel: ListenChannelViewModel = {
        return ListenChannelViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(tableView)
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        loadData()
    }
    
    func loadData() {
        viewModel.updateBlock = { [unowned self] in
            self.tableView.reloadData()
        }
        viewModel.refreshDataSource()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChannelController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListenChannelTableViewCell = tableView.dequeueReusableCell(withIdentifier: ListenChannelTableViewCellID, for: indexPath) as! ListenChannelTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.backgroundColor = UIColor.init(r: 240, g: 241, b: 244)
        cell.channelResults = viewModel.channelResults?[indexPath.row]
        return cell
    }
}

extension ChannelController: ListenFooterViewDelegate {
    func listenFooterAddButtonClick() {
        let vc = ChannelController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
