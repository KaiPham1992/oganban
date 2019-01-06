//
//  MyBuyViewController.swift
//  Oganban
//
//  Created Coby on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import DropDown

class MyBuyViewController: BaseViewController {

    @IBOutlet weak var tbMyBuy: UITableView!
    @IBOutlet weak var vRecordBuy: UIView!
    @IBOutlet weak var lbStatusRecord: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var vDropDownStatus: UIView!
    
	var presenter: MyBuyPresenterProtocol?

    let dropDownStatus = DropDown()
    
    var dataOrder: BaseOrderEntity? {
        didSet {
            tbMyBuy.reloadData()
        }
    }
    
	override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        self.setTitleNavigation(title: NavigationTitle.myBuy)
        configTableView()
        setupDropDownStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showTabbar()
    }
    
    func configTableView() {
        tbMyBuy.dataSource = self
        tbMyBuy.delegate = self
        
        tbMyBuy.registerTableCell(MyBuyCell.self)
        
        tbMyBuy.contentInset.bottom = 10
    }
    
    private func setupDropDownStatus() {
        dropDownStatus.anchorView = vDropDownStatus
        dropDownStatus.backgroundColor = AppColor.main
        DropDown.appearance().setupCornerRadius(10)
        dropDownStatus.textColor = .white
        dropDownStatus.textFont = AppFont.fontRegular11
        dropDownStatus.separatorColor = .gray
        dropDownStatus.selectionBackgroundColor = AppColor.main
        dropDownStatus.selectedTextColor = .yellow
        dropDownStatus.downScaleTransform = CGAffineTransform(rotationAngle: (-.pi))
        dropDownStatus.dataSource = ["Chờ duyệt", "Đang giao", "Hoàn Tất", "Đã huỷ", "Tất cả"]
        dropDownStatus.selectionAction = { [weak self](index, item) in
            guard let `self` = self else { return }
            self.lbStatusRecord.text = item
            switch item {
            case "Chờ duyệt":
                self.lbTotal.text = "Tổng đơn hàng đang chờ duyệt: 1"
            case "Đang giao":
                self.lbTotal.text = "Tổng đơn hàng đang giao: 1"
            case "Hoàn Tất":
                self.lbTotal.text = "Tổng đơn hàng đã hoàn tất: 1"
            case "Đã huỷ":
                self.lbTotal.text = "Tổng đơn hàng đã huỷ: 1"
            case "Tất cả":
                self.lbTotal.text = "Tổng tất cả đơn hàng: 1"
            default:
                break
            }
        }
    }
    
    @IBAction func btnChangeStatusRecord() {
        dropDownStatus.show()
    }
}

extension MyBuyViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(MyBuyCell.self)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
}

extension MyBuyViewController: MyBuyViewProtocol {
    func didGetHistoryOrder(data: BaseOrderEntity?) {
        self.dataOrder = data
    }
}
