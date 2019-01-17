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
    @IBOutlet weak var tbDetail: UITableView!
    
    var record: RecordEntity? {
        didSet {
            tbDetail.reloadData()
        }
    }
    
    
    
    var price: Double = 0
    var quantity: Int = 0
    var recordId: String?
    var paymentType: String = ""
    var listHeader = ["Chi tiết", "Giới thiệu","Thông tin người bán", "Địa chỉ đăng bán  ", "Bình Luận"]
    var sectionSentSubComment: Int?
    var listComment = [CommentEntity]() {
        didSet {
            tbDetail.reloadData()
        }
    }
    
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
        ShareNativeHelper.shared.showShareLinkInstall(controller: self)
    }
    
    @IBAction func btnOrderBuy() {
        if UserDefaultHelper.shared.isLoggedIn {
            PopUpHelper.shared.showUpdateQuantityBuy { (quantity) in
                guard let qtyStr = quantity, let qty = Int(qtyStr) else { return }
                guard let _recordID = self.recordId, let totalCoin = UserDefaultHelper.shared.coin, let totalQty = self.record?.quantity else { return }
                
                if self.price == 0.0 {
                    PopUpHelper.shared.showMessageHaveAds(message: "Vui lòng chọn phương thức thanh toán")
                    return
                } else if qty == 0 {
                    PopUpHelper.shared.showMessageHaveAds(message: "Số lượng mua phải lớn hơn 0")
                    return
                } else if qty > totalQty {
                    PopUpHelper.shared.showMessageHaveAds(message: "Số lượng mua vượt quá số lượng sản phẩm")
                    return
                }
                
                if self.paymentType == "coin" {
                    if totalCoin < self.price {
                        PopUpHelper.shared.showMessageHaveAds(message: "Số Ơcoin tích luỹ của bạn không đủ để đổi sản phẩm. Vui lòng kiểm tra lại")
                        return
                    }
                }
                
                self.presenter?.bookingOrder(recordID: _recordID, price: self.price, quantity: qty, paymentType: self.paymentType, isService: false)
            }
        } else {
            self.presenter?.gotoLogin()
        }
    }
    
}

extension OrderBuyDetailViewController: OrderBuyDetailViewProtocol {
    func didGetComment(commentResponseEntity: CommentResponseEntity?) {
        guard let _listComment = commentResponseEntity?.listComment else { return }
        
        self.listComment = _listComment
    }
    
    func didSendComment(comment: CommentEntity?) {
        guard let _comment = comment else { return }
        
        insertComment(comment: _comment)
    }
    
    func didSendSubComment(comment: SubCommentEntity?) {
        guard let _comment = comment else { return }
        guard let section = sectionSentSubComment else { return }
        insertSubComment(section: section, subComment: _comment)
    }
    
    func didGetDetail(record: RecordEntity?) {
        self.record = record
        self.presenter?.getCommentList(recordId: self.recordId&, offset: 0)
    }
    
    func didBooking(order: OrderEntity?) {
        PopUpHelper.shared.showMessageHaveAds(message: " Bạn đã đặt mua sản phẩm. Vui lòng chờ phê duyệt của người bán")
        self.pop()
    }
    
    func didAddFavorite(data: BaseResponse?) {
        
    }
}

extension OrderBuyDetailViewController: OrderInfoUserCellDelegate {
    func btnPhoneTapped() {
        if let phone = record?.phone, let url = URL(string: "tel://\(phone)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

extension OrderBuyDetailViewController: OrderBuyDetailImageCellDelegate {
    func selectedMoney(money: Double) {
        self.price = money
        self.paymentType = "cash"
    }
    
    func selectedCoin(coin: Double) {
        self.price = coin
        self.paymentType = "coin"
    }
}

extension OrderBuyDetailViewController: HeaderOrderBuyDetailDelegate {
    func addFavorite(isFavorite: Int) {
        guard let _accountID = record?.accountId else { return }
        presenter?.AddFavorite(isFavorite: isFavorite, accountID: Int(_accountID)!)
    }
    
    func checkLogin() {
        self.presenter?.gotoLogin()
    }
}
