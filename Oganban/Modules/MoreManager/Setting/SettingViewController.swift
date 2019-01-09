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
        radiusDropdown.separatorColor = .gray
        radiusDropdown.selectionBackgroundColor = AppColor.main
        radiusDropdown.selectedTextColor = .yellow
        radiusDropdown.downScaleTransform = CGAffineTransform(rotationAngle: (-.pi))
        radiusDropdown.selectionAction = { [weak self](index, item) in
            guard let `self` = self else { return }
//            if  self.dataSource[index].title& == "Không giới hạn" {
//                self.paramFilter.radius = ""
//            } else {
//                self.paramFilter.radius = self.dataSource[index].title&
//            }
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
}

extension SettingViewController: SettingViewProtocol {
    func didGetPositionRange(list: [PositionRangeEntity]) {
        self.dataSource = list
        if let last = PositionRangeEntity(JSON: ["_id": "8", "_value": "Không giới hạn"]) {
            self.dataSource.append(last)
        }
        radiusDropdown.dataSource = dataSource.map({$0.title&})
    }
}
