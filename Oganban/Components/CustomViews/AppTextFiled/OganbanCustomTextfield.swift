//
//  TextfieldString96.swift
//  Oganban
//
//  Created by Kent on 12/19/18.
//  Copyright © 2018 Vinova. All rights reserved.
//

import UIKit

@IBDesignable class OganbanCustomTextfield: UIView{

    var tfContent: UITextField = {
        let view = UITextField()
        view.isUserInteractionEnabled = true
        view.isEnabled = true
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var lbTitle: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var lbRightText: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.textAlignment = .right
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var ivRightIcon: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    var vLine: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.greyC8C8C8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var textFieldDidBeginEditing : (() -> Void)?
    var completeTapRightIcon : ((Bool) -> Void)?
    var istapRightIcon: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraint()
        setupLayoutTextfield()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setConstraint()
        setupLayoutTextfield()
    }
    
    private func setConstraint(){
        
        self.tfContent.delegate = self
        
        self.addSubview(tfContent)
        self.addSubview(lbTitle)
        self.addSubview(vLine)
        self.addSubview(ivRightIcon)
        self.addSubview(lbRightText)
        
        self.frame.size = CGSize(width: self.frame.size.width, height: 50)
        lbTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        lbTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        lbTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        lbTitle.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        lbRightText.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        lbRightText.topAnchor.constraint(equalTo: lbTitle.topAnchor, constant: 0).isActive = true
        lbRightText.heightAnchor.constraint(equalToConstant: 12).isActive = true
        lbRightText.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        tfContent.leftAnchor.constraint(equalTo: lbTitle.leftAnchor, constant: 0).isActive = true
        tfContent.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        tfContent.topAnchor.constraint(equalTo: lbTitle.bottomAnchor, constant: 12).isActive = true
        tfContent.heightAnchor.constraint(equalToConstant: 14.5).isActive = true
        
        ivRightIcon.centerYAnchor.constraint(equalTo: tfContent.centerYAnchor).isActive = true
        ivRightIcon.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        ivRightIcon.heightAnchor.constraint(equalToConstant: 11.5).isActive = true
        ivRightIcon.widthAnchor.constraint(equalToConstant: 15).isActive = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapRightIcon(_:)))
        self.ivRightIcon.addGestureRecognizer(tapGesture)
        
        vLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        vLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        vLine.topAnchor.constraint(equalTo: tfContent.bottomAnchor, constant: 10).isActive = true
        vLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
    func setupLayoutTextfield(placeholderText: String = "", titleText: String = "Title", backgroundColor: UIColor = AppColor.white, titleColor: UIColor = AppColor.grey9E9E9E, placeholderColor: UIColor = AppColor.grey9E9E9E, contentColor: UIColor = AppColor.black414141, isHiddenBottomLine: Bool = false) {
        
        self.backgroundColor = backgroundColor
        vLine.isHidden = isHiddenBottomLine
        
        tfContent.textColor = contentColor
        tfContent.font = AppFont.fontRegularRoboto15
        tfContent.attributedPlaceholder = NSAttributedString(string: placeholderText,attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
       
        lbTitle.text = titleText
        lbTitle.textColor = titleColor
        lbTitle.font = AppFont.fontRegularRoboto12
       
    }
    
    func showRightIcon(isHidden: Bool = false, sỉze: CGSize = CGSize(width: 15, height: 11.5), icon: UIImage? = nil, paddingRight: CGFloat = 0) {
        ivRightIcon.rightAnchor.constraint(equalTo: self.rightAnchor, constant: paddingRight).isActive = true
        ivRightIcon.heightAnchor.constraint(equalToConstant: sỉze.height).isActive = true
        ivRightIcon.widthAnchor.constraint(equalToConstant: sỉze.width).isActive = true
        ivRightIcon.isHidden = isHidden
        if let icon = icon {
            ivRightIcon.image = icon
        }
    }
    
    func showRightText(isHidden: Bool = false, text: String = "", font: UIFont = AppFont.fontRegularRoboto15, textColor: UIColor = AppColor.grey9E9E9E){
        lbRightText.isHidden = isHidden
        lbRightText.text = text
        lbRightText.font = font
        lbRightText.textColor = textColor
    }
    
     @objc private func tapRightIcon(_ sender: UITapGestureRecognizer) {
        istapRightIcon = !istapRightIcon
        if let complete = self.completeTapRightIcon {
            complete(istapRightIcon)
        }
    }
}
extension OganbanCustomTextfield: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let complete = self.textFieldDidBeginEditing {
            complete()
        }
    }
}
