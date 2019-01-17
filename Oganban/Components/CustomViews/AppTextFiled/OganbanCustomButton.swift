//
//  File.swift
//  Oganban
//
//  Created by Kent on 12/19/18.
//  Copyright © 2018 Vinova. All rights reserved.
//

import UIKit

@IBDesignable class OganbanCustomButton: UIView{
    
    var cornerRadiusValue: Double = 0
    
    var isEnabledButton: Bool = false {
        didSet{
            //self.backgroundColor = isEnabledButton ? .orange : Color.grey
            self.isUserInteractionEnabled = isEnabledButton
        }
    }
    
    var ivIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    var lbTitle: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var tapButton : (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraint()
        setupLayoutButton()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setConstraint()
        setupLayoutButton()
    }
    
    private func setConstraint(){
        self.addSubview(ivIcon)
        self.addSubview(lbTitle)
        
        lbTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 10).isActive = true
        lbTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        if UIScreen.main.nativeBounds.height == 1136 { // iPhone 5 or 5S or 5C
            ivIcon.rightAnchor.constraint(equalTo: lbTitle.leftAnchor, constant: -6).isActive = true
        } else {
            ivIcon.rightAnchor.constraint(equalTo: lbTitle.leftAnchor, constant: -10).isActive = true
        }
        
        
        ivIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        ivIcon.frame.size = CGSize(width: 24, height: 24)
        
        cornerRadiusValue = Double(self.frame.height / 2.0)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapView(sender:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapView(sender: UITapGestureRecognizer){
        if let complete = self.tapButton {
            complete()
        }
    }
    
    func setupLayoutButton(withRadius: Bool = true, backgroundColor: UIColor = AppColor.black, titleColor: UIColor = AppColor.white, icon: UIImage? = nil, text: String = "Button", fontText: UIFont? = AppFont.fontRegularRoboto15){
        
        self.backgroundColor = backgroundColor
        self.lbTitle.font = fontText
        self.lbTitle.textColor = titleColor
        self.lbTitle.text = text
        
        if withRadius {
            self.cornerRadius = cornerRadiusValue
        } else {
            self.cornerRadius = 0
        }
        
        if icon == nil {
            self.ivIcon.isHidden = true
            lbTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        } else {
            self.ivIcon.image = icon
            self.ivIcon.isHidden = false
        }
    }
}
