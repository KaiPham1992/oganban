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
    //MARK:- IBOUTLET VARIABLE
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
    @IBOutlet weak var btnClear         : UIButton!
    @IBOutlet weak var lbCategory       : UILabel!
    @IBOutlet weak var lbDistance       : UILabel!
    @IBOutlet weak var tfSearch         : UITextField!
    @IBOutlet weak var vAccept          : UIView!
    @IBOutlet weak var btnCancel        : UIButton!
    @IBOutlet weak var topViewAnchor    : NSLayoutConstraint!
    
    
    //MARK: - VARIABLE
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
    var oldParentSelected: Int?
    var tempParent: Int?
    var oldChildSelected: [Int] = []
    
    let scaleDropdown = DropDown()
    var paramFilter = RecordParam()
    var dataSource: [PositionRangeEntity] = []
    var indexReload: Int?
    var distance: PositionRangeEntity? {
        didSet {
            self.lbDistance.text = distance?.title
        }
    }
    
    var isFilterTextfield = false
    var isFilter = false
    var timeCall: Timer?
    var isCalculatorHeight = true
    var isCalculatorHeightLeft = true
    
    //------database LIMIT
    let itemsPerBatch = 40
    //-------database OFFSET)
    var offset = 0
    // a flag for when all database items have already been loaded
    var reachedEndOfItems = false
    
    //MARK:- FUNCTION
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        configureCollectionView()
        configureTableView()
        presenter?.getCategoryMerge()

        getParamDefault()
        ProgressView.shared.show()
        self.isFilter = true
        presenter?.filterRecord(param: paramFilter)
        presenter?.getPositionRange()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didSaveLocation), name: Notification.Name("SaveLocation"), object: nil)
        if #available(iOS 11, *) {
            // safe area constraints already set
            topViewAnchor.constant = 0
        } else {
            topViewAnchor.constant = 20
        }
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        setRedStatusBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkGPS()
        self.navigationController?.navigationBar.isHidden = true
        showTabbar()
        setRedStatusBar()
        if isSetting {
            self.distance = UserDefaultHelper.shared.radius
            isSetting = false
        }
        
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
        
        lbPosition.text = UserDefaultHelper.shared.address
        callAPIPosition()
        timeCall = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(callAPI), userInfo: nil, repeats: true)
    }
    
    @objc func didSaveLocation() {
        getParamDefault()
        ProgressView.shared.show()
        self.isFilter = true
        presenter?.filterRecord(param: paramFilter)
        presenter?.getPositionRange()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func configureCollectionView() {
        cvHome.registerCollectionCell(AdmobCell.self)
        cvHome.registerCollectionCell(HomeCell.self)
        cvHome.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        //        cvHome.registerCollectionCell(UICollectionViewCell.self)
        cvHome.delegate = self
        cvHome.dataSource = self
        cvHome.alwaysBounceVertical = true
        cvHome.contentInset.bottom = 20
        cvHome.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
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
        tbLeft.backgroundColor = AppColor.main
        tbRight.backgroundColor = AppColor.main
        tbLeft.layer.cornerRadius = 10
        tbRight.layer.cornerRadius = 10
        tbRight.allowsMultipleSelection = true
        tbLeft.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tbLeft.bounds.size.width - 10)
        tbRight.contentInset.bottom = 40
        vAccept.backgroundColor = AppColor.main
    }
    
    override func setUpViews() {
        setUpScaleDropdown()
        tfSearch.delegate = self
        lbDistance.text = UserDefaultHelper.shared.radius?.title
        self.distance = UserDefaultHelper.shared.radius
        tfSearch.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
        tfSearch.attributedPlaceholder = NSAttributedString(string: "Tìm bài đăng",
                                                            attributes: [NSAttributedString.Key.foregroundColor: AppColor.main])
    }
    
    private func setUpScaleDropdown() {
        
        scaleDropdown.anchorView = vScaleDropdown
        scaleDropdown.backgroundColor = AppColor.main
        DropDown.appearance().setupCornerRadius(10)
        scaleDropdown.selectionBackgroundColor = AppColor.main
        scaleDropdown.selectedTextColor = .yellow
        scaleDropdown.downScaleTransform = CGAffineTransform(rotationAngle: (-.pi))
        scaleDropdown.textColor = .white
        scaleDropdown.separatorColor = AppColor.main
        scaleDropdown.textFont = AppFont.fontRegular11
        scaleDropdown.cellNib = UINib(nibName: "RangeCell", bundle:  nil)
        scaleDropdown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let _ = cell as? RangeCell else { return }
        }
        
        scaleDropdown.selectionAction = { [weak self](index, item) in
            guard let `self` = self else { return }
            self.lbDistance.text = item
            if  self.dataSource[index].title& == "Không giới hạn" {
                self.paramFilter.radius = ""
            } else {
                self.paramFilter.radius = self.dataSource[index].value
            }
            self.distance = self.dataSource[index]
            self.isFilter = true
            ProgressView.shared.show()
            self.presenter?.filterRecord(param: self.paramFilter)
        }
    }
    
    func getParamDefault() {
        offset = 0
        reachedEndOfItems = false
        let radius = UserDefaultHelper.shared.radius?.value
        let long = UserDefaultHelper.shared.long
        let lat = UserDefaultHelper.shared.lat
        paramFilter.long = long
        paramFilter.lat = lat
        paramFilter.radius = radius
//        paramFilter = RecordParam(long: long, lat: lat, radius: radius)
    }
    
    func callAPIPosition() {
        Provider.shared.userAPIService.getGPSPosition(lat: UserDefaultHelper.shared.lat, long: UserDefaultHelper.shared.long, success: { (_) in
        }) { (_) in
        }
    }
    
    @objc private func refreshData(_ sender: Any) {
        self.refreshControl.endRefreshing()
        offset = 0
        paramFilter.offset = 0
        isFilter = true
        reachedEndOfItems = false
        ProgressView.shared.show()
        presenter?.filterRecord(param: paramFilter)
    }
    
    @objc func callAPI() {
        callAPIPosition()
    }
    
    private func refreshFilter() {
        index = 0
        self.refreshControl.endRefreshing()
        lbCategory.text = "Tất cả danh mục"
        tfSearch.text = ""
        self.distance = UserDefaultHelper.shared.radius
        scaleDropdown.clearSelection()
        listRecord.removeAll()
        for (temp, item) in menu.enumerated() {
            menu[temp].isSelected = false
            for (indexChild, _) in item.cateChild.enumerated() {
                menu[temp].cateChild[indexChild].isSelected = false
            }
        }
        hideDropdown()
        tbLeft.reloadData()
        tbRight.reloadData()
    }
    
    //MARK: - IBACTION BUTTON
    @IBAction func btnClearTapped() {
        tfSearch.text = ""
        btnClear.isHidden = true
        isFilter = true
        paramFilter.keyword = nil
        presenter?.filterRecord(param: paramFilter)
    }
    
    @IBAction func btnCancelTapped() {
        tfSearch.text = ""
        view.endEditing(true)
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
        guard let distance = distance else { return }
        presenter?.gotoPositionMaps(delegate: self, address: lbPosition.text&, dataSource: self.dataSource, distance: distance)
    }
    
    @IBAction func btnGotoFavoriteTapped() {
        let vc = FavouriteRouter.createModule()
        self.push(controller: vc)
    }
    
    @IBAction func btnSearchTapped() {
        view.endEditing(true)
        paramFilter.keyword = tfSearch.text&
        isFilterTextfield = true
        isFilter = true
        ProgressView.shared.show()
        presenter?.filterRecord(param: paramFilter)
    }
    
    @IBAction func acceptTapped() {
        hideDropdown()
        
        let listChoose = menu[index].cateChild.filter { (item) -> Bool in
            return item.isSelected
        }
        
        for temp in 0...menu.count - 1 {
            if temp != index {
                for (indexCate, _) in menu[temp].cateChild.enumerated() {
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
            let listCate = listChoose.map { (item) -> String in
                return item.id&
            }
            paramFilter.categoryId = listCate
            paramFilter.isParent = nil
        } else {
            paramFilter.categoryId = [menu[oldParentSelected*].id&]
            paramFilter.isParent = "1"
            lbCategory.text = menu[oldParentSelected*].name
            menu[oldParentSelected*].isSelected = true
            isCalculatorHeightLeft = false
            
            for (tempInt, item) in oldChildSelected.enumerated() {
                menu[oldParentSelected*].cateChild[item].isSelected = false
            }
            tbLeft.reloadData()
            tempParent = nil
        }
        
        
        isFilter = true
        ProgressView.shared.show()
        presenter?.filterRecord(param: paramFilter)
    }
}

//--MARK: - Home view protocol
extension HomeViewController: HomeViewProtocol {
    func didGetPositionRange(list: [PositionRangeEntity]) {
        self.dataSource = list
        if let last = PositionRangeEntity(JSON: ["_id": "8", "_value": ""]) {
            self.dataSource.append(last)
        }
        scaleDropdown.dataSource = dataSource.map({$0.title&})
        //        distance = dataSource[3]
    }
    
    func didFilterRecord(list: [RecordEntity]) {
        // update UITableView with new batch of items on main thread after query finishes
        ProgressView.shared.hide()
        if isFilterTextfield && list.count == 0 {
            isFilterTextfield = false
            PopUpHelper.shared.showMessageHaveAds(message: "Không tìm thấy kết quả")
        } else {
            DispatchQueue.main.async {
                if self.isFilter {
                    self.isFilter = false
//                    self.listRecord.append(RecordEntity(JSON: [:]))
                    self.listRecord = list
                } else {
                    self.listRecord.append(contentsOf: list)
                    if list.count < self.itemsPerBatch {
                        self.reachedEndOfItems = true
                        print("reached end of data. Batch count: \(list.count)")
                    }
                }
            }
        }
    }
    
    func didGetCategoryMerge(list: [CategoryMergeEntity]) {
        if let all = CategoryMergeEntity(JSON: ["name" : "Tất cả danh mục"]) {
            menu = list
            menu.insert(all, at: 0)
            tbLeft.reloadData()
        }
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
    
    func loadMore() {
        
        // don't bother doing another db query if already have everything
        guard !self.reachedEndOfItems else {
            return
        }
        
        // query the db on a background thread
//        DispatchQueue.global(qos: .background).async {
            self.offset += self.itemsPerBatch
            self.paramFilter.offset = self.offset
            self.paramFilter.limit = self.itemsPerBatch
            self.presenter?.filterRecord(param: self.paramFilter)
            
//        }
    }
    
    
}

//--MARK: - Show list record collection view
extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if listRecord.count == 0 {
            //            showNoData()
            lbNoData.removeFromSuperview()
            self.cvHome.addSubview(lbNoData)
            lbNoData.centerSuperview()
            return 0
        } else {
            hideNoData()
            if listRecord.count%10 == 0 {
                return listRecord.count/10
            } else {
                return listRecord.count/10 + 1
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if listRecord.count == 0 {
            //            showNoData()
            return 0
        } else if listRecord.count == 1 {
            hideNoData()
            return 3
        } else {
            hideNoData()
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
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if ((indexPath.row) + (10 * indexPath.section)) == (self.listRecord.count - 10) {
            self.loadMore()
        }
        
        if listRecord.count == 1 {
            if indexPath.row == 0 {
                let cell = collectionView.dequeueCollectionCell(AdmobCell.self, indexPath: indexPath)
                return cell
            } else if indexPath.row == 2 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
                return cell
            } else {
                let cell = collectionView.dequeueCollectionCell(HomeCell.self, indexPath: indexPath)
                let temp = (indexPath.row - 1) + indexPath.section * 10
                cell.setData(record: listRecord[temp])
                return cell
            }
        } else {
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
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.width, height: 125)
        } else {
            return CGSize(width: collectionView.frame.width/2, height: 270)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //FIXME
        let temp = (indexPath.row - 1) + indexPath.section * 10
        let vc = OrderBuyDetailRouter.createModule(recordId: listRecord[temp].id&)
        self.push(controller: vc)
    }
}

//MARK: - CONFIG DROPDOWN MENU CATEGORY
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case tbLeft:
            return menu.count
        case tbRight:
            if menu.count > 0 {
                if index == 0 {
                    return 0
                } else {
                    return menu[index].cateChild.count
                }
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
            if isCalculatorHeightLeft {
                self.heightLeft.constant = heightContent < heightMax ? tableView.contentSize.height : (heightMax)
            } else {
                isCalculatorHeightLeft = true
            }
            cell.indexPath = indexPath
            cell.delegate = self
            return cell
            
        case tbRight:
            let cell = tableView.dequeueTableCell(MenuCell.self)
            if index != 0 {
                cell.lbTitle.text = menu[index].cateChild[indexPath.row].name
                if isCalculatorHeight {
                    self.heightRight.constant = heightContent < heightMax ? tableView.contentSize.height : (heightMax)
                } else {
                    isCalculatorHeight = true
                }
                
                cell.isSelect = menu[index].cateChild[indexPath.row].isSelected
            }
            
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
            menu[oldParentSelected*].isSelected = false
            for (tempInt, item) in oldChildSelected.enumerated() {
                menu[oldParentSelected*].cateChild[item].isSelected = false
                
//                tbRight.reloadRows(at: [IndexPath(item: item, section: indexPath.section)], with: .none)
            }
//            tbRight.reloadData()
            if indexPath.row == 0 {
                oldChildSelected.removeAll()
            }
            index = indexPath.row
            
            menu[index].isSelected = true
            indexReload = oldParentSelected
            tbLeft.reloadData()
//            tbLeft.reloadRows(at: [IndexPath(item: oldParentSelected*, section: indexPath.section), indexPath], with: .none)
            oldParentSelected = index
            lbCategory.text = menu[index].name
            if indexPath.row == 0 {
                paramFilter.categoryId = nil
                paramFilter.isParent = nil
            } else {
                paramFilter.categoryId = [menu[index].id&]
                paramFilter.isParent = "1"
            }
            isFilter = true
            ProgressView.shared.show()
            presenter?.filterRecord(param: paramFilter)
            hideDropdown()
        case tbRight:
            
            if indexPath.row != menu[index].cateChild.count {
                menu[index].cateChild[indexPath.row].isSelected = !menu[index].cateChild[indexPath.row].isSelected
                
                if menu[index].cateChild[indexPath.row].isSelected {
                    var check = false
                    for child in oldChildSelected {
                        if child == indexPath.row {
                            check = true
                        }
                    }
                    if !check {
                        oldChildSelected.append(indexPath.row)
                    }
                } else {
                    for (tempInt, item) in oldChildSelected.enumerated() {
                        if item == indexPath.row {
                            oldChildSelected.remove(at: tempInt)
                        }
                    }
                }
                isCalculatorHeight = false
                tbRight.reloadRows(at: [indexPath], with: .none)
            }
            
        default:
            break
        }
    }
}

//MARK: - TEXTFIELD DELEGATE
extension HomeViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tfSearch.text = ""
        btnCancel.isHidden = false
        btnFavorite.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        paramFilter.keyword = textField.text&
        isFilterTextfield = true
        isFilter = true
        btnCancel.isHidden = true
        btnFavorite.isHidden = false
        ProgressView.shared.show()
        presenter?.filterRecord(param: paramFilter)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.endEditing(true)
        guard let text = textField.text else { return }
        if !text.isEmpty {
            paramFilter.keyword = textField.text&
            isFilterTextfield = true
            isFilter = true
            btnCancel.isHidden = true
            btnFavorite.isHidden = false
            ProgressView.shared.show()
            presenter?.filterRecord(param: paramFilter)
        }
    }
    
    @objc func textFieldDidChanged() {
        if tfSearch.text&.isEmpty {
            btnClear.isHidden = true
        } else {
            btnClear.isHidden = false
        }
    }
}

//MARK: - DELEGATE POSITION
extension HomeViewController: PositionViewControllerDelegate {
    func positionSelected(location: CLLocationCoordinate2D, address: String, distance: PositionRangeEntity) {
        let long = String(location.longitude)
        let lat = String(location.latitude)
        paramFilter.long = long
        paramFilter.lat = lat
        lbPosition.text = address
        self.distance = distance
        self.paramFilter.radius = distance.value&
        isFilter = true
        ProgressView.shared.show()
        presenter?.filterRecord(param: paramFilter)
    }
    
    func checkGPS() {
        if UserDefaultHelper.shared.lat.isEmpty {
            if CLLocationManager.authorizationStatus() != .authorizedAlways && CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                    self.present(controller: CheckGPSViewController.initFromNib())
                }
            }
        }
    }
}

//MARK: - DELEGATE HOME CELL
extension HomeViewController: LeftMenuCellDelegate {
    func openRightMenu(indexPath: IndexPath) {
        index = indexPath.row
        if index != 0 {
            tempParent = oldParentSelected
            if oldParentSelected != index {
                menu[oldParentSelected*].isSelected = false
                indexReload = oldParentSelected
                isCalculatorHeightLeft = false
                tbLeft.reloadRows(at: [IndexPath(row: oldParentSelected*, section: indexPath.section)], with: .none)
                for (tempInt, item) in oldChildSelected.enumerated() {
                    menu[oldParentSelected*].cateChild[item].isSelected = false
                }
                oldParentSelected = index
                oldChildSelected.removeAll()
            }
            menu[index].isSelected = true
            isCalculatorHeightLeft = false
            tbLeft.reloadRows(at: [indexPath], with: .none)
            tbRight.reloadData()
            tbRight.isHidden = false
            vAccept.isHidden = false
        }
    }
}

