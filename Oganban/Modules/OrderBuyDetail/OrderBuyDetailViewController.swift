//
//  OrderDetailViewController.swift
//  Oganban
//
//  Created Kai Pham on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit


class OrderBuyDetailViewController: BaseViewController {

	var presenter: OrderBuyDetailPresenterProtocol?
    
    @IBOutlet weak var vPostCommentView: PostCommentView!
    @IBOutlet weak var bottomConstant: NSLayoutConstraint!
    @IBOutlet weak var heightConstant: NSLayoutConstraint!
    
    
    var record: RecordEntity? {
        didSet {
            tbDetail.reloadData()
        }
    }
    
    var price: Double = 0
    var quantity: Int = 0
    var recordId: String?
    var paymentType: String = ""
    var listHeader = ["Chi tiết", "Giới thiệu","Thông tin người bán", "Địa chỉ đăng  ", "Bình Luận"]
    
    var listComment = [CommentEntity]()
    
    @IBOutlet weak var tbDetail: UITableView!
    
    var tapGesture: UITapGestureRecognizer!

	override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardNotification()
        vPostCommentView.delegate = self
        configureTable()
        
        presenter?.getDetail(id: recordId&)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        setTitleNavigation(title: "Chi tiết sản phẩm")
        addBackToNavigation()
        addButtonToNavigation(image: AppImage.imgShare, style: .right, action: #selector(btnShareTapped))
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    
    @objc func btnShareTapped() {
        ShareNativeHelper.shared.showShare(controller: self, items: ["share content"])
    }
    
    @IBAction func btnOrderBuy() {
        PopUpHelper.shared.showUpdateQuantityBuy { (quantity) in
            guard let qtyStr = quantity, let qty = Int(qtyStr) else { return }
            if self.price != 0 || qty != 0 {
                guard let _recordID = self.recordId else { return }
                self.presenter?.bookingOrder(recordID: _recordID, price: self.price, quantity: qty, paymentType: self.paymentType, isService: false)
            }
        }
    }
}

extension OrderBuyDetailViewController: OrderBuyDetailViewProtocol {
    func didGetDetail(record: RecordEntity?) {
        self.record = record
    }
    
    func didBooking(order: OrderEntity?) {
        
    }
}

extension OrderBuyDetailViewController: OrderInfoUserCellDelegate {
    func btnPhoneTapped() {
        print("Alo ALo")
    }
}

extension OrderBuyDetailViewController: OrderBuyDetailImageCellDelegate {
    func selectedMoney(money: Double) {
        self.price = money
        self.paymentType = "cash"
        print(money)
    }
    
    func selectedCoin(coin: Double) {
        self.price = coin
        self.paymentType = "coin"
    }
    
    
}
