//
//  PopUpSelectGenderContent.swift
//  Oganban
//
//  Created by Kai Pham on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit
struct Gender {
    var title: String?
    var keyParam: String?
}

protocol PopUpSelectGenderContentDelegate: class {
    func genderSelected(gender: Gender?)
}


class PopUpSelectGenderContent: BaseViewXib  {
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var vPicker: UIPickerView!
    
    weak var delegate: PopUpSelectGenderContentDelegate?
    var genderSelected: Gender?
    
    let listGenders = [
        Gender(title: "Chọn giới tính", keyParam: nil),
        Gender(title: "Nam", keyParam: "male"),
        Gender(title: "Nữ", keyParam: "female"),
        Gender(title: "Khác", keyParam: "other"),
    ]
    
    @IBAction func btnOkTapped() {
        delegate?.genderSelected(gender: genderSelected)
    }
    
    override func setUpViews() {
        super.setUpViews()
        vPicker.delegate = self
        vPicker.dataSource = self
    }
    
    func showSelectRow(currentGender: Gender?){
        if currentGender?.title == "Chọn giới tính" {
            self.vPicker.selectRow(0, inComponent: 0, animated: true)
        }
        else if currentGender?.title == "Nam" {
            self.vPicker.selectRow(1, inComponent: 0, animated: true)
        }
        else if currentGender?.title == "Nữ" {
            self.vPicker.selectRow(2, inComponent: 0, animated: true)
        }
        else {
            self.vPicker.selectRow(3, inComponent: 0, animated: true)
        }
    }
}

extension PopUpSelectGenderContent: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.listGenders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.listGenders[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderSelected = self.listGenders[row]
    }
}
