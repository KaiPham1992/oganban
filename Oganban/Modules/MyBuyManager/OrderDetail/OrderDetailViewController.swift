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

enum OrderDetailInfoType: Int {
    case infoProduct = 0
    case intro
    case infoSaler
    case address
    case comment
}

class OrderDetailViewController: BaseViewController {

	var presenter: OrderDetailPresenterProtocol?
    
    @IBOutlet weak var vPostCommentView: PostCommentView!
    @IBOutlet weak var bottomConstant: NSLayoutConstraint!
    @IBOutlet weak var heightConstant: NSLayoutConstraint!
    
    @IBOutlet weak var vSelect: UIView!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnDecline: UIButton!
    @IBOutlet weak var btnReceived: UIButton!
    
    var isMySellHide: Bool = false
    var isMySellExpired: Bool = false
    
    var isNew: Bool = false
    var isWait: Bool = false
    var isDone: Bool = false
    var isCancel: Bool = false
    
    var record: RecordEntity? {
        didSet {
            tbDetail.reloadData()
        }
    }
    
    var recordId: String?
    
    var listHeader = ["Chi tiết", "Giới thiệu","Thông tin người bán", "Địa chỉ gợi ý để giao dịch", "Bình Luận"]
    
    var listComment = [CommentEntity]()
    
    @IBOutlet weak var tbDetail: UITableView!
    
    var tapGesture: UITapGestureRecognizer!

	override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardNotification()
        vPostCommentView.delegate = self
        configureTable()
        
        presenter?.getDetail(id: recordId&)
//        vPostCommentView.isHidden = true
//        btnReceived.isHidden = true
        vSelect.isHidden = true
        setupView()
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        setTitleNavigation(title: "Chi tiết sản phẩm")
        addBackToNavigation()
        addButtonToNavigation(image: AppImage.imgShare, style: .right, action: #selector(btnShareTapped))
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setupView() {
        if isMySellHide || isMySellExpired {
            vPostCommentView.isHidden = true
        } else if isNew {
            vSelect.isHidden = false
            btnReceived.isHidden = true
            vPostCommentView.isHidden = true
        } else if isWait {
            vSelect.isHidden = false
            btnReceived.isHidden = false
            btnAccept.isHidden = true
            btnDecline.isHidden = true
            vPostCommentView.isHidden = true
        }
    }
    
    @objc func btnShareTapped() {
        ShareNativeHelper.shared.showShare(controller: self, items: ["share content"])
    }
    
//    func testComment() {
//        for i in 0...3 {
//            let newComment = CommentEntity(comment: "Comment \(i)")
//
//            for j in 0...4 {
//                let newSubComment = SubCommentEntity(comment: "Sub comment \(j)")
//                newComment.subComment.append(newSubComment)
//            }
//
//            listComment.append(newComment)
//        }
//
//        tbDetail.reloadData()
//    }
}

extension OrderDetailViewController: OrderDetailViewProtocol {
    func didGetDetail(record: RecordEntity?) {
        self.record = record
    }
    
    func didHideRecord(data: BaseResponse?) {
        PopUpHelper.shared.showMessageHaveAds(message: "Bạn đã ẩn tin đăng bán sản phẩm này !") {
            self.pop()
        }
    }
}

extension OrderDetailViewController: OrderDetailImageCellDelegate {
    func btnDeleteTapped() {
        PopUpHelper.shared.showYesNoQuestionHaveAds(question: "Bạn chắc chắn muốn xoá bài đăng này ?", completionYes: {
            //FIXME
        }) {
            
        }
    }
    
    func btnHideTapped() {
        PopUpHelper.shared.showYesNoQuestionHaveAds(question: "Bạn có chắc muốn ẩn bài đăng này ?", completionYes: {
            guard let id = self.record?.id else { return }
            self.presenter?.hideRecord(recordID: id)
        }) {
            
        }
    }
}
