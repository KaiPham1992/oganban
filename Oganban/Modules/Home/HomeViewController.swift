//
//  HomeViewController.swift
//  Oganban
//
//  Created DINH VAN TIEN on 12/18/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import DropDown
import GoogleMaps

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var cvHome           : UICollectionView!
    @IBOutlet weak var lbPosition       : UILabel!
    @IBOutlet weak var vScale           : UIView!
    @IBOutlet weak var vCategory        : UIView!
    @IBOutlet weak var tbLeft           : UITableView!
    @IBOutlet weak var tbRight          : UITableView!
    @IBOutlet weak var heightLeft       : NSLayoutConstraint!
    @IBOutlet weak var heightRight      : NSLayoutConstraint!
    @IBOutlet weak var btnHideDropdown  : UIButton!
    @IBOutlet weak var vScaleDropdown   : UIView!
    @IBOutlet weak var btnFavorite      : UIButton!
    @IBOutlet weak var lbCategory       : UILabel!
    @IBOutlet weak var lbDistance       : UILabel!
    @IBOutlet weak var tfSearch         : UITextField!
    @IBOutlet weak var vAccept          : UIView!
    
    private let refreshControl = UIRefreshControl()
	var presenter: HomePresenterProtocol?
    
    var menu: [CategoryMergeEntity] = [] {
        didSet {
//            self.tbLeft.reloadData()
        }
    }
    
    var listRecord: [RecordEntity] = [] {
        didSet {
            self.cvHome.reloadData()
        }
    }
    
    var index = 0
    var indexCategory = 0
    var listCategory: [CategoryEntity] = []
    
    let scaleDropdown = DropDown()
    var paramFilter = RecordParam()
    var dataSource: [PositionRangeEntity] = []
    var indexReload: Int?

	override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        configureCollectionView()
        configureTableView()
        presenter?.getCategoryMerge()
        presenter?.filterRecord(param: paramFilter)
        presenter?.getPositionRange()
        
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        setRedStatusBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        setRedStatusBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func configureCollectionView() {
        cvHome.registerCollectionCell(AdmobCell.self)
        cvHome.registerCollectionCell(HomeCell.self)
        cvHome.delegate = self
        cvHome.dataSource = self
        cvHome.alwaysBounceVertical = true
        cvHome.contentInset.bottom = 20
        cvHome.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    private func configureTableView() {
        tbLeft.registerTableCell(MenuCell.self)
        tbRight.registerTableCell(MenuCell.self)
        tbRight.registerTableCell(AcceptCell.self)
        tbRight.delegate = self
        tbRight.dataSource = self
        tbLeft.delegate = self
        tbLeft.dataSource = self
        tbRight.rowHeight = UITableView.automaticDimension
        tbLeft.rowHeight = UITableView.automaticDimension
        hideDropdown()
        tbLeft.layer.cornerRadius = 10
        tbRight.layer.cornerRadius = 10
        tbRight.allowsMultipleSelection = true
        tbLeft.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tbLeft.bounds.size.width - 10)
        tbRight.contentInset.bottom = 40
    }
    
    override func setUpViews() {
        setUpScaleDropdown()
        tfSearch.delegate = self
    }
    
    private func setUpScaleDropdown() {
        scaleDropdown.anchorView = vScaleDropdown
        scaleDropdown.backgroundColor = AppColor.main
        DropDown.appearance().setupCornerRadius(10)
        scaleDropdown.textColor = .white
        scaleDropdown.textFont = AppFont.fontRegular11
        scaleDropdown.separatorColor = .gray
        scaleDropdown.selectionBackgroundColor = AppColor.main
        scaleDropdown.selectedTextColor = .yellow
        scaleDropdown.downScaleTransform = CGAffineTransform(rotationAngle: (-.pi))
        scaleDropdown.selectionAction = { [weak self](index, item) in
            guard let `self` = self else { return }
            self.lbDistance.text = item
            self.paramFilter.radius = self.dataSource[index].title&
            self.presenter?.filterRecord(param: self.paramFilter)
        }
    }
    
    @objc private func refreshData(_ sender: Any) {
        // Fetch Weather Data
        self.refreshControl.endRefreshing()
        paramFilter = RecordParam()
        presenter?.filterRecord(param: paramFilter)
    }
    
    @IBAction func hideDropdownTapped() {
        hideDropdown()
    }
    
    func hideDropdown() {
        tbRight.isHidden = true
        tbLeft.isHidden = true
        btnHideDropdown.isHidden = true
        vAccept.isHidden = true
    }
    
    @IBAction func btnShowDropdownCategoryTapped() {
        tbLeft.isHidden = false
        tbLeft.reloadData()
        btnHideDropdown.isHidden = false
    }
    
    @IBAction func btnShowDropdownScaleTapped() {
        scaleDropdown.show()
    }
    
    @IBAction func btnGotoPositionTapped() {
        presenter?.gotoPositionMaps(delegate: self, address: lbPosition.text&)
    }
    
    @IBAction func btnGotoFavoriteTapped() {
        let vc = SignUpRouter.createModule()
        self.push(controller: vc)
    }
    
    @IBAction func btnSearchTapped() {
        view.endEditing(true)
        paramFilter.keyword = tfSearch.text&
        presenter?.filterRecord(param: paramFilter)
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
        presenter?.filterRecord(param: paramFilter)
    }
}

extension HomeViewController: HomeViewProtocol {
    func didGetPositionRange(list: [PositionRangeEntity]) {
        self.dataSource = list
        scaleDropdown.dataSource = list.map({$0.title&})
    }
    
    func didFilterRecord(list: [RecordEntity]) {
        listRecord = list
    }
    
    func didGetCategoryMerge(list: [CategoryMergeEntity]) {
        menu = list
        tbLeft.reloadData()
    }
    
    func getCategoryChildSuccess(list: [CategoryEntity]) {
//        menu[indexCategory].listChild = list
//        indexCategory += 1
//        self.getChild()
    }
    
    func getCategorySuccess(list: [CategoryEntity]) {
//        listCategory = list
//        menu = list.map({ (item) -> Menu in
//            return Menu(parent: item)
//        })
//        getChild()
    }
    
    func getChild() {
        for (index, item) in listCategory.enumerated() {
            if index == indexCategory {
                self.presenter?.getCategoryChild(id: item.id&)
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if listRecord.count%10 == 0 {
            return listRecord.count/10
        } else {
            return listRecord.count/10 + 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if listRecord.count%10 == 0 {
            return 11
        } else {
            if section == listRecord.count/10 {
                return listRecord.count%10 + 1
            } else {
                return 11
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueCollectionCell(AdmobCell.self, indexPath: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueCollectionCell(HomeCell.self, indexPath: indexPath)
            let temp = (indexPath.row - 1) + indexPath.section * 10
            cell.setData(record: listRecord[temp])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.width, height: 125)
        } else {
            return CGSize(width: collectionView.frame.width/2, height: 260)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
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
            let cell = tableView.dequeueTableCell(MenuCell.self)
            cell.lbTitle.text = menu[indexPath.row].name
            cell.lbTitle.textColor = menu[indexPath.row].isSelected ? .yellow : .white
            self.heightLeft.constant = heightContent < heightMax ? tableView.contentSize.height : (heightMax)
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
            tbRight.reloadData()
            tbRight.isHidden = false
            vAccept.isHidden = false
            
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

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        paramFilter.keyword = textField.text&
        presenter?.filterRecord(param: paramFilter)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.endEditing(true)
        paramFilter.keyword = textField.text&
        presenter?.filterRecord(param: paramFilter)
    }
}

extension HomeViewController: PositionViewControllerDelegate {
    func positionSelected(location: CLLocationCoordinate2D, address: String, distance: Int) {
        let long = String(location.longitude)
        let lat = String(location.latitude)
        paramFilter.long = long
        paramFilter.lat = lat
        lbPosition.text = address
        self.paramFilter.radius = self.dataSource[distance].title&
        presenter?.filterRecord(param: paramFilter)
    }
}
