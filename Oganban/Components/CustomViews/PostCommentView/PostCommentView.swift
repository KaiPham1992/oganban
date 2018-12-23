//
//  PostCommentView.swift
//  String96
//
//  Created by Ngoc Duong on 12/19/18.
//  Copyright © 2018 Vinova. All rights reserved.
//

import UIKit

protocol PostCommentViewDelegate: class {
    func postCommentView(heightKeyboard: CGFloat)
    func postCommentView(changeHeight: CGFloat)
    func postCommentView(buttonPostTapped text: String)
}

class PostCommentView: BaseViewXib {
    @IBOutlet weak var tvInput: UITextView!
    @IBOutlet weak var lbPlaceHolder: UILabel!
    weak var delegate: PostCommentViewDelegate?
    @IBOutlet weak var btnPost: UIButton!
    
    override func setUpViews() {
        super.setUpViews()
        tvInput.delegate = self
        
        //---
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //---
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.delegate?.postCommentView(changeHeight: self.frame.height)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        calculateHeight()
    }
    
    
}

extension PostCommentView {
    @IBAction func btnPostTapped() {
        self.delegate?.postCommentView(buttonPostTapped: tvInput.text&)
    }
}

// Handle height
extension PostCommentView: UITextViewDelegate {
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            if Utils.isIphoneXOrLater() {
                delegate?.postCommentView(heightKeyboard: keyboardHeight - 36)
            } else {
                delegate?.postCommentView(heightKeyboard: keyboardHeight)
            }
        }
    }
    
    @objc func keyboardWillHide() {
        delegate?.postCommentView(heightKeyboard: 0)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        calculateHeight()
    }
    
    private func calculateHeight() {
        lbPlaceHolder.isHidden = !tvInput.text&.isValidEmpty()
        btnPost.isHidden = !lbPlaceHolder.isHidden
        
        let size = CGSize(width: tvInput.frame.width, height: .infinity)
        let estimatedSize = tvInput.sizeThatFits(size)
        var resultHeight: CGFloat = 40
        if estimatedSize.height > 40  {
            resultHeight = estimatedSize.height + 16 + 16
        } else {
            resultHeight = 40 + 16 + 16
        }
        
        let maxHeight: CGFloat = 40 + 16 + 16 + 100
        resultHeight = resultHeight < maxHeight ? resultHeight: maxHeight
        
        delegate?.postCommentView(changeHeight: resultHeight)
    }
}
