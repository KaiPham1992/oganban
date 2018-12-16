//
//  LeftAlignCollectionView.swift
//  RedStar
//
//  Created by Ngoc Duong on 11/23/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit
protocol LeftAlignCollectionViewDelegate: class {
    func didChangedContentSize(sender: LeftAlignCollectionView, contentSize: CGSize)
}

class LeftAlignCollectionView: BaseView {
    var cvMain: UICollectionView = {
        let layout = LeftAlignCollectionFlowlayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        
        return cv
    }()
    
    var listItem = [Any]() {
        didSet {
            cvMain.reloadData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.delegate?.didChangedContentSize(sender: self, contentSize: self.cvMain.contentSize)
            }
        }
    }
    
    func resetSelected() {
        if let _item = listItem as? [ProjectTypeEntity] {
            _item.forEach { _projecType in
                _projecType.isSelected = false
            }
        }
        
        if let _item = listItem as? [LevelEntity] {
            _item.forEach { _level in
                _level.isSelected = false
            }
        }
        
        cvMain.reloadData()
    }
    
    weak var delegate: LeftAlignCollectionViewDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            self.delegate?.didChangedContentSize(sender: self, contentSize: self.cvMain.contentSize)
//        }
    }
    
    func listItemSelected() -> [Any] {
        if let projectTypes = listItem as? [ProjectTypeEntity] {
            return projectTypes.filter({ _projectType -> Bool in
                return _projectType.isSelected == true
            })
        }
        
        if let projectTypes = listItem as? [LevelEntity] {
            return projectTypes.filter({ _level -> Bool in
                return _level.isSelected == true
            })
        }
        
        return []
    }
    
    override func setUpViews() {
        super.setUpViews()
        addSubview(cvMain)
        cvMain.fillSuperview()
        configureCollection()
    }
}

extension LeftAlignCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    //delegate
    func configureCollection() {
        cvMain.registerCollectionCell(LeftAlignCollectionCell.self, fromNib: true)
        cvMain.delegate = self
        cvMain.dataSource = self
    }
    
    // data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return listItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvMain.dequeueCollectionCell(LeftAlignCollectionCell.self, indexPath: indexPath)
        cell.item = self.listItem[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let projectEntity = listItem[indexPath.item] as? ProjectTypeEntity {
            let estimateWidth = Utils.estimateWidth(38, customFont: AppFont.fontRegular15, str: projectEntity.name&) + 20
            return CGSize(width: estimateWidth, height: 30)
        }
        
        if let level = listItem[indexPath.item] as? LevelEntity {
            let estimateWidth = Utils.estimateWidth(38, customFont: AppFont.fontRegular15, str: level.name&) + 20
            return CGSize(width: estimateWidth, height: 30)
        }

        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let projectType = self.listItem[indexPath.item] as? ProjectTypeEntity {
            projectType.isSelected = !projectType.isSelected
            if let cell = collectionView.cellForItem(at: indexPath) as? LeftAlignCollectionCell {
                cell.item = projectType
            }
        }
        
        if let level = self.listItem[indexPath.item] as? LevelEntity {
            level.isSelected = !level.isSelected
            if let cell = collectionView.cellForItem(at: indexPath) as? LeftAlignCollectionCell {
                cell.item = level
            }
        }
    }
    
}
