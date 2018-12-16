//
//  AppTextFieldDropDown.swift
//  RedStar
//
//  Created by Ngoc Duong on 11/24/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit
import DropDown

protocol AppTextFieldDropDownDelegate: class {
//    func btnDropDownTapped()
    func didChangedValue(sender: AppTextFieldDropDown, item: Any)
}

class AppTextFieldDropDown: AppTextField {
    let imgDropDown: UIImageView = {
        let img = UIImageView()
        img.image = AppImage.imgDropDown
        
        return img
    }()
    
    lazy var btnAction: UIButton = {
        let btn = UIButton()
        btn.addTarget(self , action: #selector(btnActionTapped), for: .touchUpInside)
        return btn
    }()
    
    let dropDown = DropDown()
    
    weak var delegateDropDown: AppTextFieldDropDownDelegate?
    
    var listItem = [Any]() {
        didSet {
            setUpDropDown()
            if let _province = listItem as? [ProvinceEntity] {
                dropDown.dataSource = _province.map {$0.name&}
            }
            
            if let _province = listItem as? [DistrictEntity] {
                dropDown.dataSource = _province.map {$0.name&}
            }
        }
    }
    
    var selectedItem: Any?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }
    
    @objc func btnActionTapped() {
        dropDown.show()
    }
    
    
    func resetData() {
        self.text = ""
        self.selectedItem = nil
    }
    
    override func setUpViews() {
        super.setUpViews()
        addSubview(imgDropDown)
        addSubview(btnAction)
        imgDropDown.anchor(right: self.rightAnchor, rightConstant: 0, widthConstant: 15, heightConstant: 15)
        imgDropDown.centerYToSuperview()
        
        btnAction.fillSuperview()
    }
    
    func setUpDropDown() {
        dropDown.anchorView = self
        dropDown.backgroundColor = AppColor.white
        dropDown.width = self.frame.width
        
        dropDown.cellNib = UINib(nibName: "ProvinceCell", bundle:  nil)
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
//            guard let cell = cell as? ProvinceCell else { return }
            
            return
        }
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.text = item
            self.selectedItem = self.listItem[index]
            self.delegateDropDown?.didChangedValue(sender: self, item: self.selectedItem)
        }
    }
}
