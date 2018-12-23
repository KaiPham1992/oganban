//
//  AppCollectionPhoto.swift
//  Oganban
//
//  Created by Kai Pham on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit
import ImagePicker

protocol AppCollectionPhotoDelegate: class {
    func appCollectionPhoto(_ collectionView: AppCollectionPhoto, changedHeight height: CGFloat)
    func appCollectionPhoto(_ collectionView: AppCollectionPhoto, selectedImages images: [AppPhoto])
}

class AppCollectionPhoto: UIView {
    
    lazy var cvPhoto: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.isScrollEnabled = false
        return cv
        
    }()
    
    weak var delegate: AppCollectionPhotoDelegate?
    weak var controller: UIViewController?
    var isSingleSelected = false
    var listIdDelete = [Int]() // use when edit
    
    var limit = 10
    
    var listImage = [AppPhoto]() {
        didSet {
            cvPhoto.reloadData()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
                self.calculateHeight()
            })
        }
    }
    //Layout Setting Variables
    var numberOfItemsPerRow: Int = 5
    var canEdit: Bool = true
    var deleteIcon: UIImage = AppImage.imgClose
    var addIcon: UIImage = AppImage.imgUploadPhoto
    var cellBorderColor: UIColor = AppColor.line
    var borderAll: Bool = true
    var ratioCell: CGFloat = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView(){
        self.backgroundColor = UIColor.clear
        addSubview(cvPhoto)
        cvPhoto.fillSuperview()
        cvPhoto.registerCollectionCell(AppCollectionPhotoCell.self, fromNib: false)
    }
    
    func configCollectionImageView(delegate: AppCollectionPhotoDelegate?, controller: UIViewController?, isSingleSelected: Bool = false) {
        self.delegate = delegate
        self.controller = controller
        self.isSingleSelected = isSingleSelected
    }
    
    private func calculateHeight() {
        let countCell = listImage.count + 1
        var line = countCell / numberOfItemsPerRow
        let mod = countCell % numberOfItemsPerRow
        
        if mod > 0 {
            line += 1
        }
        
        let heightLine = (self.cvPhoto.frame.width - 20 ) / CGFloat(numberOfItemsPerRow) * ratioCell
        let totalHeight = heightLine * CGFloat(line) + CGFloat((line - 1) * numberOfItemsPerRow)
        delegate?.appCollectionPhoto(self, changedHeight: totalHeight)
    }
}

extension AppCollectionPhoto: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if canEdit {
            return listImage.count + 1
        } else {
            return listImage.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCollectionCell(AppCollectionPhotoCell.self, indexPath: indexPath)
        cell.imgClose.isHidden = !canEdit || ( indexPath.item == 0 || isSingleSelected)
        cell.imgClose.image = deleteIcon
        if canEdit && indexPath.item == 0 {
            cell.imgPhoto.backgroundColor = .yellow
            cell.imgPhoto.image = addIcon
            cell.borderColor = cellBorderColor
        } else {
            let i = canEdit ? 1 : 0
            cell.photo = listImage[indexPath.item - i]
            if canEdit {
                cell.btnRemove.tag = indexPath.item - i
                cell.btnRemove.addTarget(self, action: #selector(btnRemoveTapped), for: .touchUpInside)
            }
            cell.borderColor = borderAll ? cellBorderColor : .clear
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20 ) / CGFloat(numberOfItemsPerRow)
        return CGSize(width: width, height: width * ratioCell)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if canEdit && indexPath.item == 0 {
            showImagePicker()
        }
    }
    
    @objc func btnRemoveTapped(sender: UIButton) {
        if sender.tag < listImage.count {
            self.listImage.remove(at: sender.tag)
            self.cvPhoto.reloadData()
        }
        
    }
}


extension AppCollectionPhoto: ImagePickerDelegate {
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.dismiss(animated: true, completion: nil)
        self.receivedImages(imagePicker: imagePicker, images: images)
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        self.receivedImages(imagePicker: imagePicker, images: images)
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    private func receivedImages(imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.dismiss(animated: true, completion: nil)
        
        
        let imagesItems = images.map({ (image) -> AppPhoto in
            return AppPhoto(status: .new, image: image.resizeImage(maxWidth: 750), url: nil)
        })
        if isSingleSelected {
            self.listImage = imagesItems
        } else {
            self.listImage.append(contentsOf: imagesItems)
        }
        
        delegate?.appCollectionPhoto(self, selectedImages: imagesItems)
    }
    
    func showImagePicker() {
        guard let controller = controller else { return }
        let imagePickerController = ImagePickerController()
        if isSingleSelected {
            limit = 1
            imagePickerController.imageLimit = limit
        } else {
            imagePickerController.imageLimit = limit
        }
        
        imagePickerController.delegate = self
        controller.present(imagePickerController, animated: true, completion: nil)
    }
}
