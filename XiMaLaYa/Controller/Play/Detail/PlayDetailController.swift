//
//  PlayDetailController.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/24.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class PlayDetailController: UIViewController {
    // 外部传值请求接口如此那
    private var albumId: Int = 0
    
    convenience init(albumId: Int = 0) {
        self.init()
        self.albumId = albumId
    }
    
    private var playDetailAlbum:PlayDetailAlbumModel?
    private var playDetailUser:PlayDetailUserModel?
    private var playDetailTracks:PlayDetailTracksModel?
    // - headerView
    private lazy var headerView:PlayDetailHeaderView = {
        let view = PlayDetailHeaderView.init(frame: CGRect(x:0, y:0, width: ScreenWidth, height:240))
        view.backgroundColor = UIColor.white
        return view
    }()
    private let oneVc = PlayDetailIntroduceController()
    private let twoVc = PlayDetailProgramController()
    private let threeVc = PlayDetailSimilarController()
    private let fourVc = PlayDetailCircleController()
    private lazy var viewControllers: [UIViewController] = {
        return [oneVc, twoVc, threeVc,fourVc]
    }()
    
    private lazy var titles: [String] = {
        return ["简介", "节目", "找相似","圈子"]
    }()
    
    private lazy var layout: LTLayout = {
        let layout = LTLayout()
        layout.isAverage = true
        layout.sliderWidth = 80
        layout.titleViewBgColor = UIColor.white
        layout.titleColor = UIColor(r: 178, g: 178, b: 178)
        layout.titleSelectColor = UIColor(r: 16, g: 16, b: 16)
        layout.bottomLineColor = UIColor.red
        layout.sliderHeight = 56
        /* 更多属性设置请参考 LTLayout 中 public 属性说明 */
        return layout
    }()
    
    private lazy var advancedManager: LTAdvancedManager = {
        let statusBarH = UIApplication.shared.statusBarFrame.size.height
        let advancedManager = LTAdvancedManager(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight + NavBarHeight), viewControllers: viewControllers, titles: titles, currentViewController: self, layout: layout, headerViewHandle: {[weak self] in
            guard let strongSelf = self else { return UIView() }
            let headerView = strongSelf.headerView
            return headerView
        })
        /* 设置代理 监听滚动 */
        advancedManager.delegate = self
        /* 设置悬停位置 */
        advancedManager.hoverY = NavBarHeight
        /* 点击切换滚动过程动画 */
        //        advancedManager.isClickScrollAnimation = true
        /* 代码设置滚动到第几个位置 */
        //        advancedManager.scrollToIndex(index: viewControllers.count - 1)
        return advancedManager
    }()
    
    //Mark: - 导航栏右边按钮
    private lazy var rightBarButton1:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "icon_more_h_30x31_"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(rightBarButtonClick1), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    //Mark: - 导航栏右边按钮
    private lazy var rightBarButton2:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "icon_share_h_30x30_"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(rightBarButtonClick2), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navBarBackgroundAlpha = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBarBackgroundAlpha = 0
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(advancedManager)
        advancedManagerConfig()
        
        let rightBarButtonItem1:UIBarButtonItem = UIBarButtonItem.init(customView: rightBarButton1)
        let rightBarButtonItem2:UIBarButtonItem = UIBarButtonItem.init(customView: rightBarButton2)
        
        self.navigationItem.rightBarButtonItems = [rightBarButtonItem1, rightBarButtonItem2]
        
        setupLoadData()
    }
    
    func setupLoadData(){
        let api = PlayDetailAPI.playDetailData(albumId:self.albumId)
        AF.request(api.url, method: .get, parameters: api.parameters, headers: nil).validate().responseJSON { response in
            if case let Result.success(jsonData) = response.result {
                let json = JSON(jsonData)
                // 从字符串转换为对象实例
                if let playDetailAlbum = JSONDeserializer<PlayDetailAlbumModel>.deserializeFrom(json: json["data"]["album"].description) {
                    self.playDetailAlbum = playDetailAlbum
                }
                // 从字符串转换为对象实例
                if let playDetailUser = JSONDeserializer<PlayDetailUserModel>.deserializeFrom(json: json["data"]["user"].description) {
                    self.playDetailUser = playDetailUser
                }
                // 从字符串转换为对象实例
                if let playDetailTracks = JSONDeserializer<PlayDetailTracksModel>.deserializeFrom(json: json["data"]["tracks"].description) {
                    self.playDetailTracks = playDetailTracks
                }
                // 传值给headerView
                self.headerView.playDetailAlbumModel = self.playDetailAlbum
                // 传值给简介界面
                self.oneVc.playDetailAlbumModel = self.playDetailAlbum
                self.oneVc.playDetailUserModel = self.playDetailUser
                // 传值给节目界面
                self.twoVc.playDetailTracksModel = self.playDetailTracks
            }
        }
    }
    
    // - 导航栏左边消息点击事件
    @objc func rightBarButtonClick1() {
        
    }
    
    // - 导航栏左边消息点击事件
    @objc func rightBarButtonClick2() {
        
    }
    
    deinit {
        print("FMFindController < --> deinit")
    }
}

extension PlayDetailController: LTAdvancedScrollViewDelegate {
    // 具体使用请参考以下
    private func advancedManagerConfig() {
        // 选中事件
        advancedManager.advancedDidSelectIndexHandle = {
            print("选中了 -> \($0)")
        }
    }
    
    func glt_scrollViewOffsetY(_ offsetY: CGFloat) {
        if offsetY > 5 {
            let alpha = offsetY / CGFloat(kNavBarBottom)
            navBarBackgroundAlpha = alpha
            self.rightBarButton1.setImage(UIImage(named: "icon_more_n_30x31_"), for: UIControl.State.normal)
            self.rightBarButton2.setImage(UIImage(named: "icon_share_n_30x30_"), for: UIControl.State.normal)
        } else {
            navBarBackgroundAlpha = 0
            self.rightBarButton1.setImage(UIImage(named: "icon_more_h_30x31_"), for: UIControl.State.normal)
            self.rightBarButton2.setImage(UIImage(named: "icon_share_h_30x30_"), for: UIControl.State.normal)
        }
    }
}

