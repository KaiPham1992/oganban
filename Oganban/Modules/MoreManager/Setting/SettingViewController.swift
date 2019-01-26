//
//  SettingViewController.swift
//  Oganban
//
//  Created DINH VAN TIEN on 1/6/19.
//  Copyright © 2019 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import DropDown
var isSetting = false
class SettingViewController: BaseViewController {

	var presenter: SettingPresenterProtocol?
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var lbRadius: UILabel!
    @IBOutlet weak var vDropdowRadius: UIView!
    
    let radiusDropdown = DropDown()
    var dataSource: [PositionRangeEntity] = []
    var distance: PositionRangeEntity? {
        didSet {
            self.lbRadius.text = distance?.title
        }
    }

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getPositionRange()
        setUpScaleDropdown()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.distance = UserDefaultHelper.shared.radius
        self.isEnabledSaveButton(isEnabled: false)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
        setTitleNavigation(title: "Cài đặt")
    }
    
    private func setUpScaleDropdown() {
        
        radiusDropdown.anchorView = vDropdowRadius
        radiusDropdown.backgroundColor = AppColor.main
        DropDown.appearance().setupCornerRadius(10)
        radiusDropdown.width = 150
        radiusDropdown.textColor = .white
        radiusDropdown.textFont = AppFont.fontRegular11
        radiusDropdown.selectionBackgroundColor = AppColor.main
        radiusDropdown.selectedTextColor = .yellow
        radiusDropdown.downScaleTransform = CGAffineTransform(rotationAngle: (-.pi))
        radiusDropdown.cellNib = UINib(nibName: "RangeCell", bundle:  nil)
        radiusDropdown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? RangeCell else { return }
            cell.optionLabel.textAlignment = .left
            cell.leftAnchorLabel.constant = 10
        }
    
        radiusDropdown.selectionAction = { [weak self](index, item) in
            guard let `self` = self else { return }
//            if  self.dataSource[index].title& == "Không giới hạn" {
//                self.paramFilter.radius = ""
//            } else {
//                self.paramFilter.radius = self.dataSource[index].title&
//            }
            
            if let oldRadius = (UserDefaultHelper.shared.radius)?.title, let newRadius = self.dataSource[index].title, oldRadius != newRadius {
                self.isEnabledSaveButton()
            } else {
                self.isEnabledSaveButton(isEnabled: false)
            }
            self.distance = self.dataSource[index]
            
//            self.presenter?.filterRecord(param: self.paramFilter)
        }
    }
    
    @IBAction func btnShowDropdownTapped() {
        radiusDropdown.show()
    }
    
    @IBAction func btnSaveTapped() {
        UserDefaultHelper.shared.radius = self.distance
        isSetting = true
        self.pop()
    }
    
    func isEnabledSaveButton(isEnabled: Bool = true) {
        self.btnSave.isEnabled = isEnabled
        if isEnabled {
            self.btnSave.backgroundColor = AppColor.green005800
        } else {
            self.btnSave.backgroundColor = AppColor.greyC8C8C8
        }
    }
}

extension SettingViewController: SettingViewProtocol {
    func didGetPositionRange(list: [PositionRangeEntity]) {
        self.dataSource = list
        if let last = PositionRangeEntity(JSON: ["_id": "8", "_value": "Không giới hạn"]) {
            self.dataSource.append(last)
        }
        radiusDropdown.dataSource = dataSource.map({$0.title&})
        
        // Set selected current item to set color for this
        for (index, item) in dataSource.enumerated() {
            if let currentItem = (UserDefaultHelper.shared.radius)?.title, let _item = item.title, currentItem == _item {
                radiusDropdown.selectRow(index, scrollPosition: .bottom)
                break
            }
        }
        
    }
}
