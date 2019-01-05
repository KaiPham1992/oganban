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
    var category: CategoryEntity?
    var dateSeleted: Date?
    var errorMessage: String = "" {
        didSet {
            print(errorMessage)
        }
    }
    
    var menu: [CategoryMergeEntity] = [] {
        didSet {
            //            self.tbLeft.reloadData()
        }
    }
    var indexReload: Int?
    var index = 0
    var paramFilter = RecordParam()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getCategoryMerge()
        configureTableView()
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        
        addBackToNavigation()
        setTitleNavigation(title: "Đăng tin bán")
        setRedStatusBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        hideDropdown()
        tbLeft.layer.cornerRadius = 10
        tbRight.layer.cornerRadius = 10
        tbLeft.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tbLeft.bounds.size.width - 10)
        tbRight.contentInset.bottom = 40
    }
    
    
    @IBAction func hideDropdownTapped() {
        hideDropdown()
    }
    
    func hideDropdown() {
        tbRight.isHidden = true
        tbLeft.isHidden = true
        btnHideDropdown.isHidden = true
    }
    
    @IBAction func acceptTapped() {
        hideDropdown()
        
        let listChoose = menu[index].cateChild.filter { (item) -> Bool in
            return item.isSelected
        }
        
        for temp in 0...menu.count - 1 {
            if temp != index {
                for indexCate in 0...menu[temp].cateChild.count - 1 {
                    menu[temp].cateChild[indexCate].isSelected = false
                }
            }
        }
        var category = ""
        for choose in listChoose {
            category += "\(choose.name&), "
        }
        if category != "" {
            lbCategory.text = category
        } else {
            lbCategory.text = "Tất cả danh mục"
        }
        
        
        let listCate = listChoose.map { (item) -> String in
            return item.id&
        }
        
        paramFilter.categoryId = listCate
//        presenter?.filterRecord(param: paramFilter)
    }
    
    @IBAction func btnCategoryTapped() {
        tbLeft.isHidden = false
        tbLeft.reloadData()
        btnHideDropdown.isHidden = false
    }
    
    @IBAction func btnContinueTapped() {
//        if !validInput() {
//            return
//        }
        
        let imgSrc = vPhoto.listImage.map {$0.url&}
        let expireDate = dateSeleted?.toString(dateFormat: AppDateFormat.yyyyMMdd)&
        
        postParam = PostRecordParam(categoryId: "128", name: vTitleRecord.textField.text&, imgSrc: imgSrc, quantity: vQuantity.textField.text&, expireDate: expireDate&, aboutRecord: vAbout.tvInput.text&)
        
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
        PopUpHelper.shared.showDateFollowWeekPopup { date in
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
            cell.indexPath = indexPath
            cell.delegate = self
            return cell
            
        case tbRight:
            let cell = tableView.dequeueTableCell(MenuCell.self)
            cell.lbTitle.text = menu[index].cateChild[indexPath.row].name
            self.heightRight.constant = heightContent < heightMax ? tableView.contentSize.height : (heightMax)
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
            for (temp, _) in menu.enumerated() {
                if temp != index {
                    if menu[temp].isSelected == true {
                        indexReload = temp
                        menu[temp].isSelected = false
                        self.tbLeft.reloadRows(at: [IndexPath(item: temp, section: indexPath.section)], with: .none)
                    }
                    
                }
            }
            menu[index].isSelected = true
            tbLeft.reloadRows(at: [indexPath], with: .none)
            tbLeft.isHidden = true
            btnHideDropdown.isHidden = true
            lbCategory.text = menu[index].name
            paramFilter.categoryId = [menu[index].id&]
//            presenter?.filterRecord(param: paramFilter)
        case tbRight:
            if indexPath.row == menu[index].cateChild.count {
                
            } else {
                menu[index].cateChild[indexPath.row].isSelected = !menu[index].cateChild[indexPath.row].isSelected
                tbRight.reloadRows(at: [indexPath], with: .none)
            }
            
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
        for (temp, _) in menu.enumerated() {
            if temp != index {
                if menu[temp].isSelected == true {
                    indexReload = temp
                    menu[temp].isSelected = false
                    self.tbLeft.reloadRows(at: [IndexPath(item: temp, section: indexPath.section)], with: .none)
                }
                
            }
        }
        menu[index].isSelected = true
        tbLeft.reloadRows(at: [indexPath], with: .none)
        tbRight.reloadData()
        tbRight.isHidden = false
    }
}
