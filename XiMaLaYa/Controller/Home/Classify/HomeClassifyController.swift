//
//  HomeClassifyController.swift
//  XiMaLaYa
//
//  Created by rcadmin on 2020/8/24.
//  Copyright © 2020 rcadmin. All rights reserved.
//

import UIKit

class HomeClassifyController: UIViewController {
    
    private let CellIdentifier = "HomeClassifyCell"
    private let HomeClassifyFooterViewID = "HomeClassifyFooterView"
    private let HomeClassifyHeaderViewID = "HomeClassifyHeaderView"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.register(HomeClassifyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeClassifyHeaderViewID)
        collection.register(HomeClassifyFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HomeClassifyFooterViewID)
        
        collection.backgroundColor = kBackgroundColor
        return collection
    }()
    
    lazy var viewModel: HomeClassifyViewModel = {
        return HomeClassifyViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.left.right.top.height.equalToSuperview()
        }
        // 加载数据
        loadData()
    }
    
    func loadData(){
        // 加载数据
        viewModel.updateBlock = { [unowned self] in
            // 更新列表数据
            self.collectionView.reloadData()
        }
        viewModel.refreshDataSource()
    }
}

extension HomeClassifyController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections(collectionView:collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier: String = "\(indexPath.section)\(indexPath.row)"
        self.collectionView.register(HomeClassifyCell.self, forCellWithReuseIdentifier: identifier)
        let cell: HomeClassifyCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! HomeClassifyCell
        cell.backgroundColor = UIColor.white
        cell.layer.masksToBounds =  true
        cell.layer.cornerRadius = 4.0
        cell.layer.borderColor = UIColor.init(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1).cgColor
        cell.layer.borderWidth = 0.5
        cell.itemModel = viewModel.classifyModel?[indexPath.section].itemList![indexPath.row]
        cell.indexPath = indexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let categoryId: Int = viewModel.classifyModel?[indexPath.section].itemList![indexPath.row].itemDetail?.categoryId ?? 0
        let title = viewModel.classifyModel?[indexPath.section].itemList![indexPath.row].itemDetail?.title ?? ""
        let vc = ClassifySubMenuController(categoryId: categoryId)
        vc.title = title
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.insetForSectionAt(section: section)
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumInteritemSpacingForSectionAt(section: section)
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumLineSpacingForSectionAt(section: section)
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForHeaderInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForFooterInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView: HomeClassifyHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeClassifyHeaderViewID, for: indexPath) as! HomeClassifyHeaderView
            headerView.titleString = viewModel.classifyModel?[indexPath.section].groupName
            return headerView
        } else if kind == UICollectionView.elementKindSectionFooter {
            let footerView: HomeClassifyFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HomeClassifyFooterViewID, for: indexPath) as! HomeClassifyFooterView
            return footerView
        }
        return UICollectionReusableView()
    }
}
