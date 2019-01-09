//
//  PostStepOneViewController.swift
//  Oganban
//
//  Created Kai Pham on 1/4/19.
//  Copyright © 2019 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class PostStepOneViewController: BaseViewController {
    
    var presenter: PostStepOnePresenterProtocol?
    @IBOutlet weak var vTitleRecord     : FTextField!
    @IBOutlet weak var vQuantity        : FTextField!
    @IBOutlet weak var vChooseDate      : FTextFieldChoose!
    @IBOutlet weak var vAbout           : AppTextView!
    @IBOutlet weak var lbCategory       : UILabel!
    @IBOutlet weak var vPhoto           : AppCollectionPhoto!
    @IBOutlet weak var heightPhoto      : NSLayoutConstraint!
    //--MENU
    @IBOutlet weak var tbLeft           : UITableView!
    @IBOutlet weak var tbRight          : UITableView!
    @IBOutlet weak var heightLeft       : NSLayoutConstraint!
    @IBOutlet weak var heightRight      : NSLayoutConstraint!
    @IBOutlet weak var btnHideDropdown  : UIButton!
    
    var postParam = PostRecordParam()
    var categoryId: String?
    var dateSeleted: Date?
    var errorMessage: String = "" {
        didSet {
            print(errorMessage)
        }
    }
    
    var record: RecordEntity?
    var isCopyUpdate: Bool = false
    //--Menu
    var menu: [CategoryMergeEntity] = [] {
        didSet {
//            self.tbLeft.reloadData()
        }
    }
    var indexReload: Int?
    var index = 0
//    var paramFilter = RecordParam()
    var oldParentSelected: Int?
    var oldChildSelected: Int?
    var heightTableLeft: CGFloat = 300
    var heightTableRight: CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getCategoryMerge()
        configureTableView()
        checkCopyUpdate()
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        
        addBackToNavigation()
        setTitleNavigation(title: "Đăng tin bán")
        setRedStatusBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getExpireDate()
        hideTabbar()
    }
    
    override func setUpViews() {
        super.setUpViews()
        vTitleRecord.setTextField(title: TitleString.titleRecord, placeHolder: TitleString.placeTitleRecord)
        
        vQuantity.setTextField(title: TitleString.titleQuantity, placeHolder: TitleString.placeTitleQuantity)
        
        vChooseDate.setTextField(title: TitleString.titleExpireSell, placeHolder: TitleString.placeTitleExpireSell)
        
        vAbout.setTitlePlaceHolder(title: "Giới thiệu *", placeHolder: "Nhập giới thiệu sản phẩm (Tối đa 1,500 ký tự)")
        
        //
        vPhoto.configCollectionImageView(delegate: self, controller: self, isSingleSelected: false)
        vChooseDate.delegate = self
        
        //--
        vQuantity.textField.keyboardType = UIKeyboardType.numberPad
    }
    
    private func checkCopyUpdate() {
        if isCopyUpdate {
            setupUpdate()
            self.categoryId = record?.catrgotyID
            self.dateSeleted = record?.createTime
        }
    }
    
    private func configureTableView() {
        tbRight.registerTableCell(MenuCell.self)
        tbRight.registerTableCell(AcceptCell.self)
        tbLeft.registerTableCell(LeftMenuCell.self)
        tbRight.delegate = self
        tbRight.dataSource = self
        tbLeft.delegate = self
        tbLeft.dataSource = self
        tbRight.rowHeight = UITableView.automaticDimension
        tbLeft.rowHeight = UITableView.automaticDimension
//        hideDropdown()
        tbLeft.layer.cornerRadius = 10
        tbRight.layer.cornerRadius = 10
        tbLeft.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tbLeft.bounds.size.width - 10)
        tbRight.contentInset.bottom = 40
        //---
        self.btnHideDropdown.isHidden = true
        self.heightLeft.constant = 0
        self.heightRight.constant = 0
    }
    
    
    @IBAction func hideDropdownTapped() {
        hideDropdown()
    }
    
    func hideDropdown() {
        UIView.animate(withDuration: 0.3) {
            self.btnHideDropdown.isHidden = true
            self.heightLeft.constant = 0
            self.heightRight.constant = 0
            self.view.layoutIfNeeded()
        }
        
    }
    
    @IBAction func btnCategoryTapped() {
        self.btnHideDropdown.isHidden = false
        UIView.animate(withDuration: 0.3) {
            
            self.heightLeft.constant = self.heightTableLeft
            if self.oldChildSelected != nil {
                self.heightRight.constant = self.heightTableRight
            }
            self.view.layoutIfNeeded()
        }
        
    }
    
    @IBAction func btnContinueTapped() {
//        if !validInput() {
//            return
//        }
        
        let imgSrc = vPhoto.listImage.map {$0.url&}
        let expireDate = dateSeleted?.toString(dateFormat: AppDateFormat.yyyyMMdd)&
        
        
        postParam = PostRecordParam(categoryId: categoryId&, name: vTitleRecord.textField.text&, imgSrc: imgSrc, quantity: vQuantity.textField.text&, expireDate: expireDate&, aboutRecord: vAbout.tvInput.text&)
        if isCopyUpdate {
            
            let vc = PostStepTwoRouter.createModule(param: self.postParam, isUpdate: true, record: self.record)
            self.push(controller: vc)
            return
        }
        let vc = PostStepTwoRouter.createModule(param: self.postParam)
        self.push(controller: vc)
    }
    
}

extension PostStepOneViewController: PostStepOneViewProtocol {
    func didGetCategoryMerge(list: [CategoryMergeEntity]) {
        self.menu = list
        tbLeft.reloadData()
    }
}

extension PostStepOneViewController: AppCollectionPhotoDelegate {
    func appCollectionPhoto(_ collectionView: AppCollectionPhoto, changedHeight height: CGFloat) {
        heightPhoto.constant = height
    }
    
    func appCollectionPhoto(_ collectionView: AppCollectionPhoto, selectedImages images: [AppPhoto]) {
        
    }
}

extension PostStepOneViewController: FTextFieldChooseDelegate {
    func btnChooseTapped(sender: FTextFieldChoose) {
        
        PopUpHelper.shared.showDateFollowWeekPopup(maxDate: DataManager.shared.maxDate) { date in
            self.dateSeleted = date
            self.vChooseDate.textField.text = date?.toString(dateFormat: AppDateFormat.ddMMYYYY_VN)
        }
    }
}


extension PostStepOneViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case tbLeft:
            return menu.count
        case tbRight:
            if menu.count > 0 {
                return menu[index].cateChild.count
            } else {
                return 0
            }
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let heightContent = tableView.contentSize.height
        let heightMax = UIScreen.main.bounds.height - 300
        switch tableView {
        case tbLeft:
            let cell = tableView.dequeueTableCell(LeftMenuCell.self)
            cell.lbTitle.text = menu[indexPath.row].name
            cell.lbTitle.textColor = menu[indexPath.row].isSelected ? .yellow : .white
            self.heightLeft.constant = heightContent < heightMax ? tableView.contentSize.height : (heightMax)
            self.heightTableLeft = heightContent < heightMax ? tableView.contentSize.height : (heightMax)
            cell.indexPath = indexPath
            cell.delegate = self
            return cell
            
        case tbRight:
            let cell = tableView.dequeueTableCell(MenuCell.self)
            cell.lbTitle.text = menu[index].cateChild[indexPath.row].name
            self.heightRight.constant = heightContent < heightMax ? tableView.contentSize.height : (heightMax)
            self.heightTableRight = heightContent < heightMax ? tableView.contentSize.height : (heightMax)
            cell.isSelect = menu[index].cateChild[indexPath.row].isSelected
            return cell
            
        default:
            self.heightLeft.constant = tableView.contentSize.height
            self.heightRight.constant = tableView.contentSize.height
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case tbLeft:
            index = indexPath.row
            menu[oldParentSelected*].isSelected = false
            menu[oldParentSelected*].cateChild[oldChildSelected*].isSelected = false
            menu[index].isSelected = true
            tbLeft.reloadRows(at: [IndexPath(item: oldParentSelected*, section: indexPath.section), indexPath], with: .none)
            oldParentSelected = index
            lbCategory.text = menu[index].name
//            paramFilter.categoryId = [menu[index].id&]
            categoryId = menu[index].id&
            hideDropdown()
            //--ID category parent
//            presenter?.filterRecord(param: paramFilter)
            
        case tbRight:
            menu[oldParentSelected*].cateChild[oldChildSelected*].isSelected = false
            menu[oldParentSelected*].cateChild[indexPath.row].isSelected = true
            tbRight.reloadRows(at: [IndexPath(item: oldChildSelected*, section: indexPath.section), indexPath], with: .none)
            oldChildSelected = indexPath.row
            lbCategory.text =  menu[oldParentSelected*].cateChild[indexPath.row].name
            categoryId = menu[oldParentSelected*].cateChild[indexPath.row].id&
            //--get id category there
            hideDropdown()
            
        default:
            break
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row != indexReload {
            cell.transform = CGAffineTransform(rotationAngle: (-.pi))
            
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        }
    }
}

extension PostStepOneViewController: LeftMenuCellDelegate {
    func openRightMenu(indexPath: IndexPath) {
        index = indexPath.row
        
        if oldParentSelected != index {
            menu[oldParentSelected*].isSelected = false
            menu[oldParentSelected*].cateChild[oldChildSelected*].isSelected = false
            
        }
        menu[index].isSelected = true
        tbLeft.reloadRows(at: [IndexPath(item: oldParentSelected*, section: indexPath.section), indexPath], with: .none)
        oldParentSelected = index
        tbRight.reloadData()
        tbRight.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.heightRight.constant = self.heightTableRight
            self.view.layoutIfNeeded()
        }
    }
}

