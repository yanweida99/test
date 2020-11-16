//
//  RecommendGuessLikeCell.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/24.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class RecommendGuessLikeCell: UICollectionViewCell {
    private var recommendList: [RecommendListModel]?
    
    private let GuessYouLikeCellID = "GuessYouLikeCell"
    private lazy var changeBtn:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setTitle("换一批", for: UIControl.State.normal)
        button.setTitleColor(kButtonColor, for: UIControl.State.normal)
        button.backgroundColor = UIColor.init(red: 254/255.0, green: 232/255.0, blue: 227/255.0, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(updataBtnClick(button:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(GuessYouLikeCell.self, forCellWithReuseIdentifier: GuessYouLikeCellID)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    func setUpLayout(){
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview()//test
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        }
        
        self.addSubview(self.changeBtn)
        self.changeBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var recommendListData: [RecommendListModel]? {
        didSet{
            guard let model = recommendListData else { return }
            self.recommendList = model
            self.collectionView.reloadData()
        }
    }
    // 更换一批按钮刷新cell
    @objc func updataBtnClick(button:UIButton){
        // 首页推荐接口请求
        let api = HomeRecommendAPI.changeGuessYouLikeList
        AF.request(api.url, method: .get, parameters: api.parameters, headers: nil).validate().responseJSON { response in
            if case let Result.success(jsonData) = response.result {
                //解析数据
                let json = JSON(jsonData)
                if let mappedObject = JSONDeserializer<RecommendListModel>.deserializeModelArrayFrom(json: json["list"].description) {
                    self.recommendList = mappedObject as? [RecommendListModel]
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
}

extension RecommendGuessLikeCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recommendList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:GuessYouLikeCell = collectionView.dequeueReusableCell(withReuseIdentifier: GuessYouLikeCellID, for: indexPath) as! GuessYouLikeCell
        cell.recommendData = self.recommendList?[indexPath.row]
        return cell
    }

    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0);
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:(kScreenWidth - 55) / 3,height:180)
    }
}

