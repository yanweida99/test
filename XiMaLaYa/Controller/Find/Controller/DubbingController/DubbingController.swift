//
//  DubbingController.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/14.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class DubbingController: UIViewController, LTTableViewProtocal {
    
    private var findDubbingList: [FindDudModel]?
    
    private let DubbingTableViewCellID = "DubbingTableViewCell"
    
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - kNavBarHeight - kTabBarHeight), self, self, nil)
        tableView.register(DubbingTableViewCell.self, forCellReuseIdentifier: DubbingTableViewCellID)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return tableView
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
        setupLoadData()
    }
    
    func setupLoadData() {
        // 1、获取json文件路径
        let path = Bundle.main.path(forResource: "FindDubbing", ofType: "json")
        // 2、获取json文件里面的内容，NSData格式
        let jsonData = NSData(contentsOfFile: path!)
        // 3、解析json内容
        let json = JSON(jsonData!)
        if let mappedObject = JSONDeserializer<FMFindDudModel>.deserializeFrom(json: json.description) {
            self.findDubbingList = mappedObject.data
            self.tableView.reloadData()
        }
        
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

extension DubbingController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.findDubbingList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DubbingTableViewCell = tableView.dequeueReusableCell(withIdentifier: DubbingTableViewCellID, for: indexPath) as! DubbingTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.findDudModel = self.findDubbingList?[indexPath.row]
        return cell
    }
}
