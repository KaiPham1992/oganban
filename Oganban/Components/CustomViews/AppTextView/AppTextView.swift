//
//  GoFixTextView.swift
//  GoFixProvider
//
//  Created by Kai Pham on 9/10/18.
//  Copyright © 2018 sg.vinova.gofixProvider. All rights reserved.
//

import Foundation

import UIKit

protocol AppTextViewDelegate: class {
    func didChangeText()
}

class AppTextView: UIView {
    let lbTitle: UILabel = {
        let lb = UILabel()
        return lb
    }()
    
    let viewContain: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var tvInput: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.clear
        tv.font = AppFont.fontRegular15
        tv.delegate = self
        return tv
    }()
    
    let lbPlaceHolder: UILabel = {
        let lb = UILabel()
        lb.font = AppFont.fontRegular15
        lb.textColor = .black
        lb.numberOfLines = 0
        return lb
    }()
    
    weak var delegate: AppTextViewDelegate?
    //---
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        addSubview(lbTitle)
        addSubview(viewContain)
        viewContain.addSubview(tvInput)
        viewContain.addSubview(lbPlaceHolder)
        tvInput.delegate = self
        
        //--lbtitle
        lbTitle.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 13, widthConstant: 0, heightConstant: 10) //NCSFont.fontRegular13.lineHeight)
        //-- view contain
        viewContain.anchor(self.lbTitle.bottomAnchor, left: lbTitle.leftAnchor, bottom: self.bottomAnchor, right: lbTitle.rightAnchor, topConstant: 0, leftConstant: -3, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        //tfInput
        tvInput.anchor(viewContain.topAnchor, left: viewContain.leftAnchor, bottom: viewContain.bottomAnchor, right: viewContain.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        tvInput.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0 )
        
        lbPlaceHolder.anchor(tvInput.topAnchor, left: tvInput.leftAnchor, bottom: nil, right: tvInput.rightAnchor, topConstant: 7, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
}

extension AppTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        lbPlaceHolder.isHidden = !textView.text.cutWhiteSpace().isValidEmpty()
        delegate?.didChangeText()
    }
    
    func setPlaceHolder(placeHolder: String) {
        lbPlaceHolder.text = placeHolder
    }
    
    func setTitle(title: String) {
        lbTitle.text = title
    }
    
    //    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    //        let currentText = textView.text ?? ""
    //        guard let stringRange = Range(range, in: currentText) else { return false }
    //        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
    //
    //        if changedText.count <= maxTextCount {
    //            return true
    //        } else {
    //            textView.resignFirstResponder()
    //            PopUpHelper.shared.showError(title: ConstantMessage.Task.errorTitle, message: ConstantMessage.Task.errorPasteOverCharacter)
    //            return false
    //        }
    //    }
}
