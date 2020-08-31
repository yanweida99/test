//
//  ListenRecommendController.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/19.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class ListenRecommendController: UIViewController, LTTableViewProtocal {
    private let ListenTRecommendableViewCellID = "ListenTRecommendableViewCell"
    
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - TabBarHeight - NavBarHeight), self, self, nil)
        tableView.register(ListenTRecommendableViewCell.self, forCellReuseIdentifier: ListenTRecommendableViewCellID)
        tableView.backgroundColor = UIColor.init(r: 240, g: 241, b: 244)
        return tableView
    }()

    lazy var viewModel: ListenRecommendViewModel = {
        return ListenRecommendViewModel()
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

extension ListenRecommendController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListenTRecommendableViewCell = tableView.dequeueReusableCell(withIdentifier: ListenTRecommendableViewCellID, for: indexPath) as! ListenTRecommendableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.albums = viewModel.albums?[indexPath.row]
        return cell
    }
}
