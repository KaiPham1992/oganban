//
//  ProductListViewController.swift
//  Oganban
//
//  Created Admin on 1/5/19.
//  Copyright © 2019 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ProductListViewController: BaseViewController, ProductListViewProtocol {

    @IBOutlet weak var imgAvatar: UIImageView!
    var presenter: ProductListPresenterProtocol?

    var productList = ["1","2","3","4","5"]
    
    @IBOutlet weak var cvProduct: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackToNavigation(icon: AppImage.imgWhiteBack)
        self.setTitleNavigation(title: NavigationTitle.productList)
        registerCollectionView()
        setupView()
    }
    
    func setupView(){
         imgAvatar.setBorderWithCornerRadius(borderWidth: 0, borderColor: UIColor.clear, cornerRadius: imgAvatar.frame.width / 2.0)
    }
    
    func registerCollectionView() {
        cvProduct.self.dataSource = self
        cvProduct.delegate = self
        cvProduct.registerCollectionCell(ProductListCell.self, fromNib: true)
    }
}
extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return productList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCollectionCell(ProductListCell.self, indexPath: indexPath)
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
}
