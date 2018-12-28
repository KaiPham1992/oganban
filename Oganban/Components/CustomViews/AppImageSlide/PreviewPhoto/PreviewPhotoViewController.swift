//
//  PreviewPhotoViewController.swift
//  RedStar
//
//  Created by Ngoc Duong on 12/6/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import UIKit
import ImageSlideshow

class PreviewPhotoViewController: UIViewController {
    @IBOutlet weak var imageSlideShow: ImageSlideshow!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        loadImage()
    }
    private  var currentPage: Int = 0
    private var listBanner = [URL]() {
        didSet {
            loadImage()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpStatusBar(color: UIColor.black)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setUpStatusBar(color: AppColor.red)
    }
    
    func setUpStatusBar(color: UIColor) {
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        guard let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView else { return }
        statusBar.backgroundColor = color
    }
    
    private func loadImage() {
        if imageSlideShow != nil {
            let imageSource = listBanner.map { _banner -> SDWebImageSource? in
                return SDWebImageSource(url: _banner, placeholder: AppImage.imgPlaceHolderImage)
                }.compactMap{$0}
            
            imageSlideShow.setImageInputs(imageSource)
        }
    }
    
    func setUpViews() {
        
        imageSlideShow.pageIndicator = nil
        imageSlideShow.contentScaleMode = .scaleAspectFit
        imageSlideShow.backgroundColor = UIColor.black
        imageSlideShow.activityIndicator = DefaultActivityIndicator()
        imageSlideShow.zoomEnabled = true
        imageSlideShow.maximumScale = 5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.imageSlideShow.setScrollViewPage(self.currentPage + 1, animated: true)
        }
        //imageSlideShow.currentPageChanged = {[weak self] page in
        //            guard let strongSelf = self else { return }
        
        //}
    }
    
    static func createModule(listBanner: [URL], currentPage: Int) -> PreviewPhotoViewController {
        let vc = PreviewPhotoViewController.initFromNib()
        vc.listBanner = listBanner
        vc.currentPage = currentPage
        
        return vc
    }
    
    @IBAction func btnCloseTapped() {
        self.dismiss()
    }
}
