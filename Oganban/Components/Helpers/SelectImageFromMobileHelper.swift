//
//  SelectImageFromMobileHelper.swift
//  Oganban
//
//  Created by Kai Pham on 12/28/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation
import ImagePicker

class SelectImageFromMobileHelper: NSObject {
    static let shared = SelectImageFromMobileHelper()
    
    //--
    var limit = 10
    var completionImages: ((_ images: [UIImage]) -> Void)?
    
    func showSelectImage(limit: Int = 10, completionImages: @escaping ((_ images: [UIImage]) -> Void)) {
        self.limit = limit
        self.completionImages = completionImages
        
        showImagePicker()
    }
}


extension SelectImageFromMobileHelper: ImagePickerDelegate {
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
        completionImages?(images)
//        delegate?.appCollectionPhoto(self, selectedImages: imagesItems)
    }
    
    func showImagePicker() {
        guard let controller = UIApplication.topViewController() else { return }
        let imagePickerController = ImagePickerController()
        imagePickerController.imageLimit = limit
        
        imagePickerController.delegate = self
        controller.present(imagePickerController, animated: true, completion: nil)
    }
}
