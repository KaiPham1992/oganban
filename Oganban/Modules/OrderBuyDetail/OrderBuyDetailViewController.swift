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
    
    var recordId: String?
    
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
            print(quantity)
        }
    }
}

extension OrderBuyDetailViewController: OrderBuyDetailViewProtocol {
    func didGetDetail(record: RecordEntity?) {
        self.record = record
    }
    
    func didBooking(order: OrderEntity?) {
        //FIXME
    }
}

extension OrderBuyDetailViewController: OrderInfoUserCellDelegate {
    func btnPhoneTapped() {
        print("Alo ALo")
    }
}
