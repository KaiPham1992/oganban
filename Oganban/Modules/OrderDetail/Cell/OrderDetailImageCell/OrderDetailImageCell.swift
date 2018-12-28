//
//  OrderDetailImageCell.swift
//  Oganban
//
//  Created by Kai Pham on 12/28/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

class OrderDetailImageCell: BaseTableCell {
    
    @IBOutlet weak var imageSlide: AppImageSlide!

    override func awakeFromNib() {
        super.awakeFromNib()
        // test fix me
        imageSlide.listItem = [
            BannerEntity(url: "http://genknews.genkcdn.vn/thumb_w/660/2017/34917206910-b35ff8ee7f-b-1505014773627.jpg"),BannerEntity(url: "http://genknews.genkcdn.vn/thumb_w/660/2017/34917206910-b35ff8ee7f-b-1505014773627.jpg"),BannerEntity(url: "http://genknews.genkcdn.vn/thumb_w/660/2017/34917206910-b35ff8ee7f-b-1505014773627.jpg"),BannerEntity(url: "http://genknews.genkcdn.vn/thumb_w/660/2017/34917206910-b35ff8ee7f-b-1505014773627.jpg"),BannerEntity(url: "http://genknews.genkcdn.vn/thumb_w/660/2017/34917206910-b35ff8ee7f-b-1505014773627.jpg"),BannerEntity(url: "http://genknews.genkcdn.vn/thumb_w/660/2017/34917206910-b35ff8ee7f-b-1505014773627.jpg"),BannerEntity(url: "http://genknews.genkcdn.vn/thumb_w/660/2017/34917206910-b35ff8ee7f-b-1505014773627.jpg"),
        ]
    }
    
}
