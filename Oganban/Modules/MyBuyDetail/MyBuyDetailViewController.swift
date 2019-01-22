//
//  MyBuyDetailViewController.swift
//  Oganban
//
//  Created Kai Pham on 1/6/19.
//  Copyright © 2019 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

enum MyBuyType: Int {
    case infoProduct = 0
    case infoSaler
}

class MyBuyDetailViewController: BaseViewController {

	var presenter: MyBuyDetailPresenterProtocol?
    var listHeader : [String] = []
    
    var order: OrderDetailEntity? {
        didSet {
            guard let _order = order else { return }
            tbDetail.reloadData()

            // BUYER
            if !isSaler {
                vControlSaler.isHidden = true
                vDoneNotArrived.isHidden = _order.getStatus() != .waitDelivery

                if _order.getStatus() == .done || _order.getStatus() == .cancel || _order.getStatus() == .orderNotYetArrived {
                    vContainerRating.isHidden = false
                } else {
                    vContainerRating.isHidden = true
                }

                if let salerRating = _order.ratingSellerOrder, let salerRatingInt =  Int(salerRating) {
                    vRating.number = salerRatingInt
                    vRating.setStar(number: salerRatingInt)
                    vRating.vStackView.isUserInteractionEnabled = false
                    btnBuyerSend.isHidden = true

                }

                // SALER
            } else {
                vControlSaler.isHidden = false
                // accep
                vAcceptCancel.isHidden = _order.getStatus() != .new

                // rating
                if _order.getStatus() == .done || _order.getStatus() == .cancel || _order.getStatus() == .orderNotYetArrived {
                    vContainerRatingSaler.isHidden = false
                } else {
                    vContainerRatingSaler.isHidden = true
                }

                // receive money
                if _order.paymentType == "cash" && _order.getStatus() == .waitDelivery {
                    vReceivedMoney.isHidden = false
                } else {
                    vReceivedMoney.isHidden = true
                }


                if let buyerRating = _order.ratingBuyerOrder, let buyerRatingInt =  Int(buyerRating) {
                    vRatingSaler.number = buyerRatingInt
                    vRatingSaler.setStar(number: buyerRatingInt)
                    btnSaleSend.isHidden = true
                    vRatingSaler.vStackView.isUserInteractionEnabled = false
                }

            }
            
        }
    }
    
    var orderId: String = ""
    var isSaler = true

     @IBOutlet weak var tbDetail: UITableView!
    
    // buyer
    @IBOutlet weak var vDoneNotArrived: UIView!
    @IBOutlet weak var vRating: AppRatingView!
    @IBOutlet weak var vContainerRating: UIView!
    @IBOutlet weak var btnBuyerSend: UIButton!
    
    // saller
    @IBOutlet weak var vControlSaler: UIView!
    @IBOutlet weak var vAcceptCancel: UIView!
    @IBOutlet weak var vRatingSaler: AppRatingView!
    @IBOutlet weak var vContainerRatingSaler: UIView!
    @IBOutlet weak var vReceivedMoney: UIView!
    @IBOutlet weak var btnSaleSend: UIButton!
    
	override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.getDetailOrder(id: orderId)
        configureTable()
        
        if !isSaler {
            listHeader = ["Chi tiết", "Thông tin người bán"]
        } else {
            listHeader = ["Chi tiết", "Thông tin khách hàng"]
        }
        
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
        setTitleNavigation(title: "Chi tiết đơn hàng")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabbar()
    }
}

extension MyBuyDetailViewController: MyBuyDetailViewProtocol {
    func didGetOrder(order: OrderDetailEntity?) {
        self.order = order
    }
    
    func didPostRating(data: BaseResponse?) {
        PopUpHelper.shared.showMessageHaveAds(message: "Đánh giá đơn hàng thành công !")
        self.pop()
    }
}


// MARK: table
extension MyBuyDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTable() {
        tbDetail.delegate = self
        tbDetail.dataSource = self
        tbDetail.registerXibFile(MyBuyImageCell.self)
        tbDetail.registerXibFile(MyBuyInfoUserCell.self)
        
        tbDetail.separatorStyle = .none
        tbDetail.estimatedRowHeight = 150
        tbDetail.rowHeight = UITableView.automaticDimension
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listHeader.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case OrderDetailInfoType.infoProduct.rawValue:
            let cell = tbDetail.dequeue(MyBuyImageCell.self, for: indexPath)
            cell.setData(order: self.order, isSaler: self.isSaler)
            cell.delegate = self
            return cell
        default:
            let cell = tbDetail.dequeue(MyBuyInfoUserCell.self, for: indexPath)
            cell.setData(orderDetail: self.order, isSaler: self.isSaler)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        let header = HeaderOrderDetail()
        v.addSubview(header)
        header.fillSuperview()
        if section < self.listHeader.count {
            header.lbTitle.text = self.listHeader[section].uppercased()
            v.backgroundColor = AppColor.gray_65_65_65
        }
        
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // comment show header only one
        if section >= self.listHeader.count || section == 0 {
            return 0
        }
        return 47.5
    }
}


extension MyBuyDetailViewController: MyBuyImageCellDelegate {
    func btnCancelTapped() {
        if isSaler {
            btnSaleCancelBuy()
        } else {
            PopUpHelper.shared.showYesNoQuestionHaveAds(question: "Bạn chắc chắn muốn huỷ giao dịch", completionYes: {
                self.presenter?.changedStatusOrder(status: OrderStatusKey.buyerCancel, id: self.orderId)
            }) {
                print("No")
            }
        }
        
    }
    
    @IBAction func btnDoneTapped() {
        self.presenter?.changedStatusOrder(status: OrderStatusKey.done, id: self.orderId)
    }
    
    @IBAction func btnNotArrivedTapped() {
        self.presenter?.changedStatusOrder(status: OrderStatusKey.orderNotYetArrived, id: self.orderId)
    }
    
    @IBAction func btnRatingTapped() {
        // fix me
        if vRating.number <= 0 {
            PopUpHelper.shared.showMessageHaveAds(message: "Vui lòng chọn số sao muốn đánh giá !")
            return
        }
        guard let accountID = order?.accountIDSaler  else { return }
        presenter?.postRating(point: vRating.number, accountID: accountID, isBuyer: false, orderID: orderId)
    }
    
    @IBAction func btnRatingSalerTapped() {
        // fix me
        if vRatingSaler.number <= 0 {
            PopUpHelper.shared.showMessageHaveAds(message: "Vui lòng chọn số sao muốn đánh giá !")
            return
        }
        guard let accountID = order?.accountIDBuyer  else {return }
        presenter?.postRating(point: vRatingSaler.number, accountID: accountID, isBuyer: true, orderID: orderId)
    }
    
    
    @IBAction func btnSaleAcceptBuy() {
        PopUpHelper.shared.showMessageHaveAds(message: "Bạn đã đồng ý bán sản phẩm")
        self.presenter?.changedStatusOrderSaler(status: OrderStatusKey.waitDelivery, id: self.orderId)
    }
    
    @IBAction func btnSaleCancelBuy() {
        PopUpHelper.shared.showYesNoQuestionHaveAds(question: "Bạn có chắc chắn từ chối bán cho khách này không?", completionYes: {
            self.presenter?.changedStatusOrderSaler(status: OrderStatusKey.sellerCancel, id: self.orderId)
        }) {
            
        }
        
    }
    
    @IBAction func btnSaleReceivedMoney() {
        self.presenter?.changedStatusOrderSaler(status: OrderStatusKey.done, id: self.orderId)
    }
    
}

extension MyBuyDetailViewController: MyBuyInfoUserCellDelegate {
    func btnPhoneTapped() {
        if let url = URL(string: "tel://\(order?.showFullPhoneBuyer() ?? "")") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
