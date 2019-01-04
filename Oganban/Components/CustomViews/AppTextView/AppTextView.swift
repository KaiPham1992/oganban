//
//  AppTextView.swift
//  Oganban
//
//  Created by Kai Pham on 1/4/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import Foundation

import UIKit

class AppTextView: UIView {
    let lbTitle: UILabel = {
        let lb          = UILabel()
        lb.font         = AppFont.fontRegular13
        lb.textColor    = AppColor.textLabel
        return lb
    }()
    
    let viewContain: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var tvInput: UITextView = {
        let tv              = UITextView()
        tv.font             = AppFont.fontRegular15
        tv.textColor        = AppColor.textTextField
        tv.backgroundColor  = UIColor.clear
        tv.delegate         = self
        return tv
    }()
    
    let lbPlaceHolder: UILabel = {
        let lb              = UILabel()
        lb.font             = AppFont.fontRegular15
        lb.textColor        = AppColor.gray_65_65_65
        lb.numberOfLines    = 0
        return lb
    }()
    
    let vLine: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.textLabel
        return view
    }()
    
    //---
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    var maxTextCount: Int = 1500
    
    func setupViews() {
        addSubview(lbTitle)
        addSubview(viewContain)
        viewContain.addSubview(tvInput)
        viewContain.addSubview(lbPlaceHolder)
        viewContain.addSubview(vLine)
        tvInput.delegate = self
        
        //--lbtitle
        lbTitle.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: AppFont.fontRegular13.lineHeight)
        //-- view contain
        viewContain.anchor(self.lbTitle.bottomAnchor, left: lbTitle.leftAnchor, bottom: self.bottomAnchor, right: lbTitle.rightAnchor, topConstant: 7, leftConstant: -3, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        //tfInput
        tvInput.anchor(viewContain.topAnchor, left: viewContain.leftAnchor, bottom: viewContain.bottomAnchor, right: viewContain.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        tvInput.contentInset = UIEdgeInsets(top: -7, left: 0, bottom: 0, right: 0 )
        
        lbPlaceHolder.anchor(tvInput.topAnchor, left: tvInput.leftAnchor, bottom: nil, right: tvInput.rightAnchor, topConstant: 0, leftConstant: 3, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        vLine.anchor(left           : viewContain.leftAnchor,
                     bottom         : viewContain.bottomAnchor,
                     right          : viewContain.rightAnchor,
                     leftConstant   : 0,
                     bottomConstant : 0,
                     rightConstant  : 0,
                     heightConstant : 1)
    }
    
}

extension AppTextView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        vLine.backgroundColor = UIColor.red
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text&.isEmpty {
            showPlaceholder()
        }
        vLine.backgroundColor = AppColor.textLabel
    }
    
    func textViewDidChange(_ textView: UITextView) {
        lbPlaceHolder.isHidden = !textView.text.cutWhiteSpace().isValidEmpty()
    }
    
    func setPlaceHolder(placeHolder: String) {
        lbPlaceHolder.text = placeHolder
    }
    
    func hidePlaceHolder() {
        lbPlaceHolder.isHidden = true
    }
    
    func showPlaceholder() {
        lbPlaceHolder.isHidden = false
    }
    
    func setTitle(title: String) {
        lbTitle.text = title
    }
    
    func setTitlePlaceHolder(title: String, placeHolder: String) {
        lbTitle.text = title
        lbPlaceHolder.text = placeHolder
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        hidePlaceHolder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText         = textView.text ?? ""
        guard let stringRange   = Range(range, in: currentText) else { return false }
        let changedText         = currentText.replacingCharacters(in: stringRange, with: text)
        
        if changedText.count <= maxTextCount {
            return true
        } else {
            if text.count != 1 {
                textView.resignFirstResponder()
                let countDelete     = changedText.count - maxTextCount
                textView.text       = changedText.dropLast(countDelete).description
            }
            return false
        }
    }
}
