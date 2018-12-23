//
//  MySellViewController.swift
//  Oganban
//
//  Created DINH VAN TIEN on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class MySellViewController: UIViewController, MySellViewProtocol {

	var presenter: MySellPresenterProtocol?
    @IBOutlet weak var vPhoto: AppCollectionPhoto!
    @IBOutlet weak var heightPhoto: NSLayoutConstraint!

	override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        vPhoto.configCollectionImageView(delegate: self, controller: self, isSingleSelected: false)
        vPhoto.listImage = [AppPhoto(status: AppPhotoStatus.new, image: AppImage.imgCheck, url: nil)]
    }

}

extension MySellViewController: AppCollectionPhotoDelegate {
    func appCollectionPhoto(_ collectionView: AppCollectionPhoto, changedHeight height: CGFloat) {
        print("----\(height)-----")
        heightPhoto.constant = height
    }
    
    func appCollectionPhoto(_ collectionView: AppCollectionPhoto, selectedImages images: [AppPhoto]) {
        print("----\(images.count)-----")
    }
    
}
