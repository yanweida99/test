//
//  HomeGuessYouLikeMoreController.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/24.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class HomeGuessYouLikeMoreController: UIViewController {
    var guessYouLikeList: [GuessYouLikeModel]?
    
    let LBHotAudiobookCellID = "LBHotAudiobookCellID"
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(LBHotAudiobookCell.self, forCellWithReuseIdentifier: LBHotAudiobookCellID)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "猜你喜欢"
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        setupLoadData()
    }
    func setupLoadData(){
        // 首页推荐接口请求
        let api = HomeRecommendAPI.guessYouLikeMoreList
        AF.request(api.url, method: .get, parameters: api.parameters, headers: nil).validate().responseJSON { response in
            if case let Result.success(jsonData) = response.result {
                //解析数据
                let json = JSON(jsonData)
                if let guessYouLikeModel = JSONDeserializer<GuessYouLikeModel>.deserializeModelArrayFrom(json: json["list"].description) {
                    self.guessYouLikeList = guessYouLikeModel as? [GuessYouLikeModel]
                    self.collectionView.reloadData()
                }
            }
        }
    }
}


extension HomeGuessYouLikeMoreController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.guessYouLikeList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:LBHotAudiobookCell = collectionView.dequeueReusableCell(withReuseIdentifier: LBHotAudiobookCellID, for: indexPath) as! LBHotAudiobookCell
        cell.guessYouLikeModel = self.guessYouLikeList?[indexPath.row]
        return cell
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
    }
    
    // 最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    // item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: kScreenWidth - 30,height:120)
    }
}
