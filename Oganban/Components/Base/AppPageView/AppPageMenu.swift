//
//  AppPageMenu.swift
//  String96
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Vinova. All rights reserved.
//


import UIKit

protocol AppPageMenuDelegate: class {
    func itemMenuSelected(index: Int)
}

class AppPageMenu: UIView {
    let cvMenu: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        
        return cv
    }()
    
    let vHorizotal: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let vLineTop: UIView = {
        let view = UIView()
        return view
    }()
    
    let vlineBottom: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.gray_158_158_158
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    let cellId = "MenuSlideTopViewCell"
    
    var listItem = [AnyObject]() {
        didSet {
            cvMenu.reloadData()
            self.vHorizotal.backgroundColor = menuColorHorizontal
        }
    }
    
    //---
    var menuColorSelected: UIColor = UIColor.black
    var menuColorNormal: UIColor = UIColor.gray
    var lineColor: UIColor = UIColor.gray
    var menuFont: UIFont = UIFont.boldSystemFont(ofSize: 13)
    
    //--- horizontal
    var menuColorHorizontal: UIColor = UIColor.purple
    var heightHorizontal: CGFloat = 2
    
    weak var delegate: AppPageMenuDelegate?
    var isFullView: Bool = false
    
    func setUpView() {
        addSubview(cvMenu)
        addSubview(vLineTop)
        addSubview(vlineBottom)
        cvMenu.fillSuperview()
        cvMenu.addSubview(vHorizotal)
        
        vLineTop.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
        vlineBottom.anchor(left: cvMenu.leftAnchor, bottom: cvMenu.bottomAnchor, right: cvMenu.rightAnchor, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
        //---
        configureCollection()
    }
    
    func setUpViewMenu(menuColorBackground: UIColor, menuFont: UIFont, menuColorNormal: UIColor, menuColorSelected: UIColor, menuColorHorizontal: UIColor, heightHorizontal: CGFloat, listItem: [KCategory], isFull: Bool = false, isHaveLineTop: Bool = false) {
        backgroundColor = menuColorBackground
        self.menuFont = menuFont
        self.menuColorSelected = menuColorSelected
        self.menuColorNormal = menuColorNormal
        self.heightHorizontal = heightHorizontal
        self.menuColorHorizontal = menuColorHorizontal
        self.isFullView = isFull
        self.vLineTop.isHidden = !isHaveLineTop
        
        self.listItem = listItem
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}

// MARK: handle Collection view
extension AppPageMenu: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func configureCollection() {
        cvMenu.register(KPageMenuViewCell.self, forCellWithReuseIdentifier: cellId)
        cvMenu.delegate = self
        cvMenu.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! KPageMenuViewCell
        cell.setData(item: listItem[indexPath.item], font: menuFont, normalColor: menuColorNormal, selectedColor: menuColorSelected)
        
        return cell
    }
    
    func estimateWidthWhenFull(collectionView: UICollectionView, indexPath: IndexPath) -> CGFloat {
        var widthAll: CGFloat = 0
        for item in listItem {
            guard let itemStr = item as? KCategory else {return 0}
            widthAll +=  estimateWidth(customFont: self.menuFont, str: itemStr.title) + 20
        }
        
        let space = (collectionView.frame.width - widthAll) / CGFloat(listItem.count)
        guard let _itemCurrent = listItem[indexPath.item] as? KCategory else {return 0}
        let currentWidth = estimateWidth(customFont: self.menuFont, str: _itemCurrent.title) + 20 + space
        
        return currentWidth
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if isFullView {
            let wid = estimateWidthWhenFull(collectionView: collectionView, indexPath: indexPath) //collectionView.frame.width /  CGFloat(listItem.count)
            if indexPath.item == 0 && vHorizotal.frame.width == 0 {
                vHorizotal.frame = CGRect(x: 0, y: cvMenu.frame.height - heightHorizontal, width: wid, height: heightHorizontal)
            }
            
            return CGSize(width: wid, height: collectionView.frame.height)
        } else {
            if let itemStr = listItem[indexPath.item] as? KCategory {
                let wid = estimateWidth(customFont: self.menuFont, str: itemStr.title) + 20
                if indexPath.item == 0 && vHorizotal.frame.width == 0 {
                    vHorizotal.frame = CGRect(x: 0, y: cvMenu.frame.height - heightHorizontal, width: wid, height: heightHorizontal)
                }
                return CGSize(width: wid, height: collectionView.frame.height)
            }
        }
        
        return CGSize(width: 0, height: 0)
    }
    
    func estimateWidth(customFont: UIFont, str: String) -> CGFloat {
        let size = CGSize(width: 1000, height: customFont.lineHeight)
        let option = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        let estimateFrame = NSString(string: str).boundingRect(with: size, options: option, attributes: [NSAttributedString.Key.font: customFont], context: nil)
        
        return estimateFrame.width
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollToIndex(index: indexPath.item)
        delegate?.itemMenuSelected(index: indexPath.item)
    }
    
    // use when rotate device
    func setHorizontal(index: Int, isFullCell: Bool = true) {
        let widthCell = cvMenu.frame.width / CGFloat(listItem.count)
        let x = CGFloat(index) * widthCell
        if !isFullCell {
            self.vHorizotal.frame = CGRect(x: x, y: vHorizotal.frame.minY, width: vHorizotal.frame.width, height: vHorizotal.frame.height)
        } else {
            self.vHorizotal.frame = CGRect(x: x, y: vHorizotal.frame.minY, width: widthCell, height: vHorizotal.frame.height)
        }
        
    }
    
    func scrollToIndex(index: Int) {
        
        //get cell selected
        let indexPath = IndexPath(item: index, section: 0)
        guard let cellScroll = cvMenu.cellForItem(at: indexPath) as? KPageMenuViewCell else { return }
        
        UIView.animate(withDuration: 0.3) {
            //-- scroll view horizontal
            self.vHorizotal.frame = CGRect(x: self.vHorizotal.frame.minX, y: self.vHorizotal.frame.minY, width: cellScroll.frame.width, height: self.vHorizotal.frame.height)
            self.vHorizotal.center.x = cellScroll.center.x
            
            //-- scroll collction view
            self.cvMenu.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            //-- set color nomal for all item in screen
            //-- indexPathsForVisibleItems get indexPath all item in screen
            let listIndexPathVisible = self.cvMenu.indexPathsForVisibleItems
            for indexPath in listIndexPathVisible {
                if let cell = self.cvMenu.cellForItem(at: indexPath) as? KPageMenuViewCell {
                    cell.lbTitle.textColor = self.menuColorNormal
                }
            }
            
            //-- set color selected for current cell
            cellScroll.lbTitle.textColor = self.menuColorSelected
            
            //--
            guard let listCategory = self.listItem as? [KCategory] else { return }
            for i in 0...listCategory.count - 1 {
                listCategory[i].isSelected = false
            }
            listCategory[index].isSelected = true
        }
    }
}

// MARK: KPageMenuViewCell
class KPageMenuViewCell: UICollectionViewCell {
    let lbTitle: UILabel = {
        let lb = UILabel()
        lb.text = "Title Category"
        lb.textColor = UIColor.white
        lb.font =  UIFont.boldSystemFont(ofSize: 15)
        
        lb.textAlignment = .center
        
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    func setData(item: AnyObject?, font: UIFont, normalColor: UIColor, selectedColor: UIColor) {
        if let cate = item as? KCategory {
            lbTitle.text = cate.title
            lbTitle.font = font
            lbTitle.textColor = cate.isSelected == true ? selectedColor : normalColor
        }
    }
    
    func setUpView() {
        addSubview(lbTitle)
        lbTitle.centerSuperview()
    }
}

class KCategory {
    var title: String = ""
    var isSelected: Bool = false
    
    init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
}

