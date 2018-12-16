//
//  AppImageSlide.swift
//  RedStar
//
//  Created by Ngoc Duong on 11/25/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import Foundation
import ImageSlideshow


class AppImageSlide: BaseViewXib {
    @IBOutlet weak var imageSlideShow: ImageSlideshow!
    @IBOutlet weak var lbIndex: AppLabel!
    @IBOutlet weak var vNodata: NoDataView!
    
    var listURLImage = [URL]()
    
    var listItem = [Any]() {
        didSet {
            var listUrlTemp = [URL]()
            var imageSource: [SDWebImageSource] = []
            if let listImage = listItem as? [BannerEntity] {
                
                imageSource = listImage.map { _banner -> SDWebImageSource? in
                    if let url = URL(string: "\(BASE_URL_IMAGE)\(_banner.imgSrc&)") {
                        
                        listUrlTemp.append(url)
                        return SDWebImageSource(url: url, placeholder: AppImage.imgPlaceHolder)
                    }
                    return nil
                    }.compactMap{$0}
            }
            
            if let listImage = listItem as? [ProjectImageEntity] {
                imageSource = listImage.map { _img -> SDWebImageSource? in
                    if let url = URL(string: "\(BASE_URL_IMAGE)\(_img.fileSrc&)") {
                         listUrlTemp.append(url)
                        return SDWebImageSource(url: url, placeholder: AppImage.imgPlaceHolder)
                    }
                    return nil
                    }.compactMap{$0}
            }
            if imageSource.count > 0 {
                listURLImage = listUrlTemp
                imageSlideShow.setImageInputs(imageSource)
                lbIndex.text = "1/\(self.listItem.count)"
                imageSlideShow.isHidden = false
            } else {
                lbIndex.text = ""
                imageSlideShow.isHidden = true
            }
           
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        imageSlideShow.pageIndicator = nil
        imageSlideShow.slideshowInterval = 5
        imageSlideShow.contentScaleMode = .scaleAspectFit
        imageSlideShow.backgroundColor = UIColor.black
        
        imageSlideShow.activityIndicator = DefaultActivityIndicator()
        imageSlideShow.currentPageChanged = {[weak self] page in
            guard let strongSelf = self else { return }
            strongSelf.lbIndex.text = "\(page + 1)/\(strongSelf.listItem.count)"
        }
        lbIndex.textColor = .white
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnImageTapped)))
    }
    
    @objc func btnImageTapped() {
        let vc = ListPhotoViewController.createModule(listBanner: listURLImage, currentIndex: imageSlideShow.currentPage)
        RouterService.shared.navigationRoot?.pushViewController(vc, animated: true) 
    }
}
