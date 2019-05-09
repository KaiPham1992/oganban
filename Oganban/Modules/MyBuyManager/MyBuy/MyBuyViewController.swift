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
    @IBOutlet weak var lbTextTotal: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var vDropDownStatus: UIView!
    @IBOutlet weak var vCheckLogin: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    
    var presenter: MyBuyPresenterProtocol?
    
    let dropDownStatus = DropDown()
    
    var isAllOrder: Bool = false
    var key = OrderStatusKey.new.rawValue
    
    var dataOrder: BaseOrderEntity? {
        didSet {
            tbMyBuy.reloadData()
            
            if let count = self.dataOrder?.dataOrder.count {
                if count == 0 {
                    tbMyBuy.isHidden = true
                    if !UserDefaultHelper.shared.userToken&.isEmpty {
                        showNoData()
                    }
                    
                    setStatusType()
                } else {
                    tbMyBuy.isHidden = false
                    hideNoData()
                    setupDropDownStatus()
                    setStatusType()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.getHistoryOrder(status: key, offset: 0, limit: 10)
    }
    
    
    func setupView() {
        self.setTitleNavigation(title: NavigationTitle.myBuy)
        configTableView()
        setupDropDownStatus()
        
        btnLogin.setBorderWithCornerRadius(borderWidth: 0, borderColor: .clear, cornerRadius: 20)
    }
    
    func getData() {
        presenter?.getHistoryOrder(status: key, offset: 0, limit: 10)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showTabbar()
        checkLogin()
        getData()
        if vCheckLogin.isHidden { // if login
            DataManager.shared.getNotificationCount { (count) in
                if let tabItems = self.tabBarController?.tabBar.items {
                    let tabItem = tabItems[3]
                    if count == 0 {
                        tabItem.badgeValue = nil
                    } else if count >= 100 {
                        tabItem.badgeValue = "+99"
                    } else {
                        tabItem.badgeValue = "\(count)"
                    }
                }
            }
        }
    }
    
    func checkLogin() {
        
        if UserDefaultHelper.shared.isLoggedIn {
            vCheckLogin.isHidden = true
            showNoData()
        } else {
            vCheckLogin.isHidden = false
            hideNoData()
        }
    }
    
    func configTableView() {
        tbMyBuy.dataSource = self
        tbMyBuy.delegate = self
        
        tbMyBuy.registerTableCell(MyBuyCell.self)
        
        tbMyBuy.contentInset.bottom = 10
        tbMyBuy.separatorStyle = .none
        tbMyBuy.tableFooterView = UIView()
    }
    
    func setStatusType() {
        guard let countOrder = dataOrder?.countOrder else { return }
            lbTotal.text = "\(countOrder)"
    }
    
    private func setupDropDownStatus() {
        dropDownStatus.anchorView = vDropDownStatus
        dropDownStatus.backgroundColor = AppColor.main
        DropDown.appearance().setupCornerRadius(10)
        dropDownStatus.textColor = .white
        dropDownStatus.textFont = AppFont.fontRegular11
        dropDownStatus.selectionBackgroundColor = AppColor.main
        dropDownStatus.selectedTextColor = .yellow
        dropDownStatus.dataSource = ["Chờ duyệt", "Đang giao", "Hoàn Tất", "Đã huỷ", "Tất cả"]
        dropDownStatus.cellNib = UINib(nibName: "RangeCell", bundle:  nil)
        dropDownStatus.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? RangeCell else { return }
            cell.optionLabel.textAlignment = .center
            cell.rightAnchorLabel.constant = 0
        }
        dropDownStatus.selectionAction = { [weak self](index, item) in
            guard let `self` = self else { return }
            self.lbStatusRecord.text = item
            
            switch item {
            case "Chờ duyệt":
                self.key = OrderStatusKey.new.rawValue
                self.presenter?.getHistoryOrder(status: self.key, offset: 0, limit: 10)
                
                self.lbTextTotal.text = "Tổng đơn hàng đang chờ duyệt: "
                
            case "Đang giao":
                self.key = OrderStatusKey.waitDelivery.rawValue
                self.presenter?.getHistoryOrder(status: self.key, offset: 0, limit: 10)
                
                self.lbTextTotal.text = "Tổng đơn hàng đang giao: "
                
            case "Hoàn Tất":
                self.key = OrderStatusKey.done.rawValue
                self.presenter?.getHistoryOrder(status: self.key, offset: 0, limit: 10)
                
                self.lbTextTotal.text = "Tổng đơn hàng đã hoàn tất: "
                
            case "Đã huỷ":
                self.key = OrderStatusKey.cancel.rawValue
                self.presenter?.getHistoryOrder(status: self.key, offset: 0, limit: 10)
                
                self.lbTextTotal.text = "Tổng đơn hàng đã huỷ: "
            case "Tất cả":
                self.key = OrderStatusKey.all.rawValue
                self.presenter?.getHistoryOrder(status: self.key, offset: 0, limit: 10)
                self.lbTextTotal.text = "Tổng tất cả các đơn hàng: "
                self.isAllOrder = true
            default:
                break
            }
        }
    }
    
    @IBAction func btnChangeStatusRecord() {
        dropDownStatus.show()
    }
    
    @IBAction func btnLoginTapped() {
        presenter?.gotoLogin()
    }
}

extension MyBuyViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = dataOrder?.dataOrder.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(MyBuyCell.self)
        cell.vMyBuyView.order = dataOrder?.dataOrder[indexPath.item]
        cell.vMyBuyView.isAllOrder = self.isAllOrder
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let orderId = self.dataOrder?.dataOrder[indexPath.item].id
        let vc = MyBuyDetailRouter.createModule(orderId: orderId&, isSaler: false)
        
        self.push(controller: vc)
    }
    
}

extension MyBuyViewController: MyBuyViewProtocol {
    func didGetHistoryOrder(data: BaseOrderEntity?) {
        self.dataOrder = data
    }
}
