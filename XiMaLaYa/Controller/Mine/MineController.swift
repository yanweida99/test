//
//  MineController.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/11.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class MineController: UIViewController {
    private let mineTableViewCellID = "MineTableViewCell"
    
    private lazy var dataSource: Array = {
        return [
            [["icon": "coin", "title": "分享赚钱"], ["icon": "hourglass", "title": "免流量服务"]],
            [["icon": "scan", "title": "扫一扫"], ["icon": "moon", "title": "夜间模式"]],
            [["icon": "feedback", "title": "帮助与反馈"]]
        ]
    }()
    
    // 懒加载顶部头视图
    private lazy var profileView: ProfileView = {
        let view = ProfileView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 300))
        return view
    }()
    
    // 懒加载TableView
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), style: UITableView.Style.plain)
        tableView.contentInset = UIEdgeInsets(top: -CGFloat(kNavBarBottom), left: 0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = kBackgroundColor
        tableView.tableHeaderView = profileView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(MineTableViewCell.self, forCellReuseIdentifier: mineTableViewCellID)
        return tableView
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        profileView.stopAnimationViewAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileView.setAnimationViewAnimation()
    }
    
    // - 导航栏左边按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "message"), for: .normal)
        button.addTarget(self, action: #selector(leftBarButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    // - 导航栏右边按钮
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "setting"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(rightBarButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // 设置导航栏颜色
        self.navBarBarTintColor = UIColor.init(red: 247 / 255.0, green: 247 / 255.0, blue: 247 / 255.0, alpha: 1.0)
        // 设置初始导航栏透明度
        self.navBarBackgroundAlpha = 0
        self.navigationItem.title = "我的"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.tableView)
        
        // 导航栏左右item
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
    }
    
    // 导航栏左边消息点击事件
    @objc func leftBarButtonClick() {
        
    }
    
    // 导航栏右边设置点击事件
    @objc func rightBarButtonClick() {
        let setVC = MineSetController()
        self.navigationController?.pushViewController(setVC, animated: true)
    }
}

// 委托
extension MineController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 || section == 2 {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: MineTableViewCell = tableView.dequeueReusableCell(withIdentifier: mineTableViewCellID, for: indexPath) as! MineTableViewCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.selectionStyle = .none
            let sectionArray = dataSource[indexPath.section - 1]
            let dict: [String: String] = sectionArray[indexPath.row]
            cell.imageView?.image =  UIImage(named: dict["icon"] ?? "")
            cell.textLabel?.text = dict["title"]
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = kBackgroundColor
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = kBackgroundColor
        return headerView
    }
}
