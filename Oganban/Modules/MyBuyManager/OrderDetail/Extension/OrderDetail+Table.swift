//
//  OrderDetail+Table.swift
//  Oganban
//
//  Created by Kai Pham on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation

// MARK: table
extension OrderDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTable() {
        tbDetail.delegate = self
        tbDetail.dataSource = self
        tbDetail.registerXibFile(CommentCell.self)
        tbDetail.registerXibFile(AddressCell.self)
        tbDetail.registerXibFile(SubCommentCell.self)
        tbDetail.registerXibFile(ReplyCommentCell.self)
        tbDetail.registerXibFile(OrderDetailImageCell.self)
        tbDetail.registerXibFile(OrderInfoUserCell.self)
        tbDetail.registerXibFile(OrderIntroCell.self)
        tbDetail.registerXibFile(OrderMoreCell.self)
        tbDetail.separatorStyle = .none
        
        tbDetail.rowHeight = UITableView.automaticDimension
        tbDetail.estimatedRowHeight = 150
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case OrderDetailInfoType.infoProduct.rawValue:
            let cell = tbDetail.dequeueTableCell(OrderDetailImageCell.self)
            cell.delegate = self
            cell.record = self.record
            return cell
        case OrderDetailInfoType.intro.rawValue:
            let cell = tbDetail.dequeue(OrderIntroCell.self, for: indexPath)
            cell.record = self.record
            return cell
        case OrderDetailInfoType.infoSaler.rawValue:
            let cell = tbDetail.dequeue(OrderInfoUserCell.self, for: indexPath)
            cell.record = self.record
            return cell
        case OrderDetailInfoType.address.rawValue:
            let cell = tbDetail.dequeue(AddressCell.self, for: indexPath)
            cell.record = self.record
            return cell
        default:
            let indexComment = getIndexSectionComment(sectionTable: indexPath.section)
            let countSubcomment = self.listComment[indexComment].subComment.count
            
            switch countSubcomment {
            case 0:
                if indexPath.item == 0 {
                    let cell = tbDetail.dequeue(CommentCell.self, for: indexPath)
                    cell.comment = getComment(section: indexPath.section)
                    return cell
                } else {
                    let cell = tbDetail.dequeue(ReplyCommentCell.self, for: indexPath)
                    cell.vPostCommentView.tag = indexPath.section
                    cell.vPostCommentView.delegate = self
                    return cell
                }
            case 1:
                if indexPath.item == 0 {
                    let cell = tbDetail.dequeue(CommentCell.self, for: indexPath)
                    cell.comment = getComment(section: indexPath.section)
                    return cell
                } else if indexPath.item == 1 {
                    let cell = tbDetail.dequeue(SubCommentCell.self, for: indexPath)
                    cell.subComment = getLastSubComment(indexPath: indexPath)
                    return cell
                } else {
                    let cell = tbDetail.dequeue(ReplyCommentCell.self, for: indexPath)
                    cell.vPostCommentView.tag = indexPath.section
                    cell.vPostCommentView.delegate = self
                    return cell
                }
            default:
                if indexPath.item == 0 {
                    let cell = tbDetail.dequeue(CommentCell.self, for: indexPath)
                    cell.comment = getComment(section: indexPath.section)
                    return cell
                } else if indexPath.item == 1 {
                    let cell = tbDetail.dequeue(SubCommentCell.self, for: indexPath)
                    cell.subComment = getLastSubComment(indexPath: indexPath)
                    return cell
                } else if indexPath.item == 2 {
                    let cell = tbDetail.dequeue(OrderMoreCell.self, for: indexPath)
                   
                    return cell
                } else {
                    let cell = tbDetail.dequeue(ReplyCommentCell.self, for: indexPath)
                    cell.vPostCommentView.tag = indexPath.section
                    cell.vPostCommentView.delegate = self
                    return cell
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case OrderDetailInfoType.infoProduct.rawValue, OrderDetailInfoType.intro.rawValue, OrderDetailInfoType.infoSaler.rawValue:
            return 1
        case OrderDetailInfoType.address.rawValue:
            return 1
        default:
            let indexComment = section - (self.listHeader.count - 1)
            
            let countSubComment = self.listComment[indexComment].subComment.count
            
            switch countSubComment {
            case 0:
                return 2
            case 1:
                return 3
            default:
                return 4
            }
        }
    }
    
    // Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        let header = HeaderOrderDetail()
        v.addSubview(header)
        header.fillSuperview()
        if section < self.listHeader.count {
            header.lbTitle.text = self.listHeader[section].uppercased()
            v.backgroundColor = AppColor.gray_65_65_65
        }
        
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // comment show header only one
        if section >= self.listHeader.count || section == 0 {
            return 0
        }
        return 47.5
    }
}

// MARK: helper
extension OrderDetailViewController {
    func getIndexSectionComment(sectionTable: Int) -> Int {
        let indexComment = sectionTable - (self.listHeader.count - 1)
        
        return indexComment
    }
    
    func numberOfSection() -> Int {
        return listHeader.count + self.listComment.count - 1
    }
    
    func getComment(section: Int) -> CommentEntity {
        let indexSection = getIndexSectionComment(sectionTable: section)
        return self.listComment[indexSection]
    }
    
    func insertComment(comment: CommentEntity) {
        self.listComment.append(comment)
        tbDetail.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.tbDetail.scrollToBottom()
        }
        
    }
    
    // Subcomment
    func getLastSubComment(indexPath: IndexPath) -> SubCommentEntity {
        let indexSection = getIndexSectionComment(sectionTable: indexPath.section)
        let count = self.listComment[indexSection].subComment.count - 1
        return self.listComment[indexSection].subComment[count]
    }
    
//    func getSubComment(indexPath: IndexPath) -> SubCommentEntity {
//        let indexSection = getIndexSectionComment(sectionTable: indexPath.section)
//        return self.listComment[indexSection].subComment[indexPath.item - 1]
//    }
    
    func insertSubComment(section: Int, subComment: SubCommentEntity) {
        let indexComment = section - (self.listHeader.count - 1)
        self.listComment[indexComment].subComment.append(subComment)
        let section = IndexSet(integer: section)
        self.tbDetail.reloadSections(section, with: .automatic)
        
//        tbDetail.beginUpdates()
//        let indexPath = IndexPath(item: self.listComment[indexComment].subComment.count - 1, section: section)
//        tbDetail.insertRows(at: [indexPath], with: .none)
//        tbDetail.endUpdates()
//
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
//            self.tbDetail.scrollToBottom(section: section)
//        }
    }
}



