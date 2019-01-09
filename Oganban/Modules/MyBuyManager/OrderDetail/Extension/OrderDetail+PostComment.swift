//
//  OrderDetail+PostComment.swift
//  Oganban
//
//  Created by Kai Pham on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit

// MARK: handle view post
extension OrderDetailViewController: PostCommentViewDelegate {
    func postCommentView(_ postCommentView: PostCommentView, changeHeight height: CGFloat) {
         heightConstant.constant = height
    }
    
    func postCommentView(_ postCommentView: PostCommentView, sendComment comment: String) {
        if postCommentView == vPostCommentView {
            let param = SendCommentParam(recordId: recordId&, comment: comment&, isReComment: "0")
            presenter?.sendComment(param: param)
            
        } else {
            let subComment = SubCommentEntity(comment: comment)
            insertSubComment(section: postCommentView.tag, subComment: subComment)
        }
        
    }
    
    override func keyboardWillShow(_ notification: Notification) {
        print("addGesture")
        addGesture()
    }
    
    override func keyboardWillHide() {
        if tapGesture != nil {
            self.view.removeGestureRecognizer(tapGesture)
        }
    }
    
    func addGesture() {
        if tapGesture == nil {
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureExecute))
        }
        
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapGestureExecute() {
        self.view.endEditing(true)
    }
}

