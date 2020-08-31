//
//  RecommendController.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/14.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class FindRecommendController: UIViewController, LTTableViewProtocal {

    private let RecommendTableViewCellID = "RecommendTableViewCell"
    
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - NavBarHeight - TabBarHeight), self, self, nil)
        tableView.register(RecommendTableViewCell.self, forCellReuseIdentifier: RecommendTableViewCellID)
        return tableView
    }()
    
    lazy var viewModel: FindRecommendViewModel = {
        return FindRecommendViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        loadData()
    }
    
    // 加载数据
    func loadData() {
        viewModel.updateBlock = { [unowned self] in
            self.tableView.reloadData() // 更新列表数据
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

extension FindRecommendController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RecommendTableViewCell = tableView.dequeueReusableCell(withIdentifier: RecommendTableViewCellID, for: indexPath) as! RecommendTableViewCell
        cell.streamModel = viewModel.streamList?[indexPath.row]
        return cell
    }
}
