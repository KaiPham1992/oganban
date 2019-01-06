//
//  MyExchangeViewController.swift
//  Oganban
//
//  Created Coby on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import DropDown

enum StatusType: String {
    case new = "new"
    case wait_delivery = "wait_delivery"
    case done = "done"
    case cancel = "cancel"
    case all = "all"
}

protocol MyExchangeViewControllerDelegate: class {
    func gotoLogin()
}

class MyExchangeViewController: BaseViewController {
    
    @IBOutlet weak var tbMyExchange: UITableView!
    @IBOutlet weak var vRecordExchange: UIView!
    @IBOutlet weak var lbStatusExchange: UILabel!
    @IBOutlet weak var lbTextTotal: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var vDropDownStatus: UIView!
    @IBOutlet weak var vCheckLogin: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    
    var presenter: MyExchangePresenterProtocol?
    weak var delegate: MyExchangeViewControllerDelegate?
    
    let dropDownStatus = DropDown()
    var parrentNavigation: UINavigationController?
    
    var isAllOrder: Bool = false
    
    var listData: BaseOrderEntity? {
        didSet {
            tbMyExchange.reloadData()
            
            if let count = self.listData?.dataOrder.count {
                if count == 0 {
                    tbMyExchange.isHidden = true
                    showNoData()
                    setStatusType()
                } else {
                    tbMyExchange.isHidden = false
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
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkLogin()
    }
    
    func setupView() {
        
        configTableView()
        setupDropDownStatus()
        
        btnLogin.setBorderWithCornerRadius(borderWidth: 0, borderColor: .clear, cornerRadius: 20)
        
    }
    
    func checkLogin() {
        if UserDefaultHelper.shared.isLoggedIn {
            vCheckLogin.isHidden = true
//            getData()
        } else {
            vCheckLogin.isHidden = false
        }
    }
    
    func getData() {
        self.presenter?.getTransactionSeller(status: StatusType.new.rawValue, limit: 10, offset: 0)
        
    }
    
    func setStatusType() {
        guard let countOrder = listData?.countOrder else { return }
        lbTotal.text = "\(countOrder)"
    }
    
    func configTableView() {
        tbMyExchange.dataSource = self
        tbMyExchange.delegate = self
        
        tbMyExchange.registerTableCell(MyBuyCell.self)
        
        tbMyExchange.contentInset.bottom = 10
        tbMyExchange.separatorStyle = .none
        tbMyExchange.tableFooterView = UIView()
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
            self.lbStatusExchange.text = item
            
            switch item {
            case "Chờ duyệt":
                self.presenter?.getTransactionSeller(status: StatusType.new.rawValue, limit: 10, offset: 0)
                self.lbTextTotal.text = "Tổng đơn hàng đang chờ duyệt: "
            case "Đang giao":
                self.presenter?.getTransactionSeller(status: StatusType.wait_delivery.rawValue, limit: 10, offset: 0)
                self.lbTextTotal.text = "Tổng đơn hàng đang giao: "
            case "Hoàn Tất":
                self.presenter?.getTransactionSeller(status: StatusType.done.rawValue, limit: 10, offset: 0)
                self.lbTextTotal.text = "Tổng đơn hàng đã hoàn tất: "
            case "Đã huỷ":
                self.presenter?.getTransactionSeller(status: StatusType.cancel.rawValue, limit: 10, offset: 0)
                self.lbTextTotal.text = "Tổng đơn hàng đã huỷ: "
            case "Tất cả":
                self.presenter?.getTransactionSeller(status: StatusType.all.rawValue, limit: 10, offset: 0)
                self.lbTextTotal.text = "Tổng tất cả đơn hàng: "
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
        delegate?.gotoLogin()
    }
}

extension MyExchangeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = listData?.dataOrder.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(MyBuyCell.self)
        cell.vMyBuyView.order = listData?.dataOrder[indexPath.item]
        cell.vMyBuyView.isAllOrder = isAllOrder
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let order = listData?.dataOrder[indexPath.item] else { return }
//        let vc = OrderDetailRouter.createModule(recordId: record?.id)
//        if listData?.dataOrder[indexPath.item].status == StatusType.new.rawValue {
//            vc.isNew = true
//        } else if listData?.dataOrder[indexPath.item].status == StatusType.wait_delivery.rawValue {
//            vc.isWait = true
//        } else if listData?.dataOrder[indexPath.item].status == StatusType.done.rawValue {
//            vc.isDone = true
//        } else if listData?.dataOrder[indexPath.item].status == StatusType.cancel.rawValue {
//            vc.isCancel = true
//        }
//        parrentNavigation?.pushViewController(vc, animated: true)
        
        let vc = MyBuyDetailRouter.createModule(orderId: order.id&, isSaler: true)
        self.parrentNavigation?.pushViewController(vc, animated: true)
        
    }
}

extension MyExchangeViewController: MyExchangeViewProtocol {
    
    func didGetTransactionSeller(data: BaseOrderEntity?) {
        self.listData = data
    }
    
}
