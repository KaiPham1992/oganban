//
//  ProductListViewController.swift
//  Oganban
//
//  Created Kent on 1/5/19.
//  Copyright © 2019 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ProductListViewController: BaseViewController {

    @IBOutlet weak var vLevel: LevelMemberView!
    @IBOutlet weak var lbRating: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
    var presenter: ProductListPresenterProtocol?
    
    var favouriteUser: FavouriteEntity?
    
    @IBOutlet weak var cvProduct: UICollectionView!
    var recordList = [RecordEntity]() {
        didSet {
            cvProduct.reloadData()
            if self.recordList.isEmpty {
                cvProduct.isHidden = true
                showNoData()
            } else {
                hideNoData()
            }
        }
    }
    
    var refreshControl:  UIRefreshControl!
    var canLoadMore = false
    var isRefresh = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackToNavigation(icon: AppImage.imgWhiteBack)
        self.setTitleNavigation(title: NavigationTitle.productList)
        registerCollectionView()
        setupView()
        getDefaultData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getFavourite(offset: 0)
    }
    
    func setupView(){
         imgAvatar.setBorderWithCornerRadius(borderWidth: 0, borderColor: UIColor.clear, cornerRadius: imgAvatar.frame.width / 2.0)
        vLevel.setFont(levelFont: AppFont.fontBoldRoboto11, proFont: AppFont.fontBoldRoboto9)
        vLevel.setLevelBackgroundColor(backgroundColor: #colorLiteral(red: 0.9224713445, green: 0.8821728826, blue: 0.8858562112, alpha: 1))
    }
    
    func registerCollectionView() {
        cvProduct.self.dataSource = self
        cvProduct.delegate = self
        cvProduct.registerCollectionCell(ProductListCell.self, fromNib: true)
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        cvProduct.addSubview(refreshControl)
    }
    
    @objc func pullToRefresh() {
        isRefresh = true
        self.refreshControl.endRefreshing()
        presenter?.getFavourite(offset: 0)
    }
    
    func getDefaultData(){
        
        if let user = favouriteUser {//} UserDefaultHelper.shared.loginUserInfo {
            lbName.text = user.fullName
            
            if let pointRatingAvg = user.pointRatingAvg, let pointRating = Float(pointRatingAvg) {
                lbRating.text =  String(format: "%.1f", pointRating)
            } else {
                lbRating.text =  String(format: "%.1f", 0)
            }
            
            imgAvatar.sd_setImage(with: user.urlAvatar , placeholderImage: AppImage.imgDefaultUser)
            
            if user.level != nil {
                vLevel.lbLevel.text = user.level
                if user.isPro == "1" {
                    vLevel.lbPro.isHidden = false
                    vLevel.lbPro.text = "Pro"
                } else {
                    vLevel.lbPro.isHidden = true
                    vLevel.lbPro.text = ""
                }
            }
        }
    }
}
extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return recordList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCollectionCell(ProductListCell.self, indexPath: indexPath) as ProductListCell
        cell.showData(record: recordList[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = cvProduct.frame.width / 2.0 - 0.5
        return CGSize(width: width , height: 220)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if canLoadMore && indexPath.item == self.recordList.count - 5 {
            presenter?.getFavourite(offset: self.recordList.count)
        }
    }
}
extension ProductListViewController: ProductListViewProtocol {
    func getSucessFavourite(record: [RecordEntity]) {
        canLoadMore = false
        canLoadMore = record.count == limitLoad
        
        if self.recordList.isEmpty || isRefresh {
            isRefresh = false
            self.recordList = record
        } else {
            self.recordList.append(contentsOf: record)
        }
    }
    
    func getErrorFavourite(error: APIError?) {
        canLoadMore = false
        self.recordList = []
    }
}
