//
//  PostCommentView.swift
//  String96
//
//  Created by Ngoc Duong on 12/19/18.
//  Copyright © 2018 Vinova. All rights reserved.
//

import UIKit

protocol PostCommentViewDelegate: class {
//    func postCommentView(heightKeyboard: CGFloat)
    func postCommentView(_ postCommentView: PostCommentView, changeHeight height: CGFloat)
//    func postCommentView(buttonPostTapped text: String)
    
    func postCommentView(_ postCommentView: PostCommentView, sendComment comment: String)
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
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.delegate?.postCommentView(self, changeHeight: self.frame.height)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        calculateHeight()
    }
    
    func setPlaceHolder(placeHolder: String) {
        self.lbPlaceHolder.text = placeHolder
    }
    
    
}

extension PostCommentView {
    @IBAction func btnPostTapped() {
        self.delegate?.postCommentView(self, sendComment: tvInput.text&)
        tvInput.text = ""
        calculateHeight()
    }
}

// Handle height
extension PostCommentView: UITextViewDelegate {
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
        
        delegate?.postCommentView(self, changeHeight: resultHeight)
    }
}
