//
//  OrderDetailProtocols.swift
//  Oganban
//
//  Created Kai Pham on 12/23/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol OrderDetailWireframeProtocol: class {

}
//MARK: Presenter -
protocol OrderDetailPresenterProtocol: class {

    var interactor: OrderDetailInteractorInputProtocol? { get set }
    func getDetail(id: String)
    func hideRecord(recordID: String)
    func editRecord(recordID: String, expiredDate: String)
    func getExpiredDay()
    func sendComment(param: SendCommentParam)
    func getCommentList(recordId: String, offset: Int, limit: Int)
}

//MARK: Interactor -
protocol OrderDetailInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func didGetDetail(record: RecordEntity?)
    func didHideRecord(data: BaseResponse?)
    func didEditRecord(data: BaseResponse?)
    func didSendComment(comment: CommentResponseEntity?)
    func didGetCommentList(list: [CommentResponseEntity])
}

protocol OrderDetailInteractorInputProtocol: class {

    var presenter: OrderDetailInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
    func getDetail(id: String)
    func hideRecord(recordID: String)
    func editRecord(recordID: String, expiredDate: String)
    func getExpiredDay()
    func sendComment(param: SendCommentParam)
    func getCommentList(recordId: String, offset: Int, limit: Int)
}

//MARK: View -
protocol OrderDetailViewProtocol: class {

    var presenter: OrderDetailPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func didGetDetail(record: RecordEntity?)
    func didHideRecord(data: BaseResponse?)
    func didEditRecord(data: BaseResponse?)
    func didSendComment(comment: CommentResponseEntity?)
    func didGetCommentList(list: [CommentResponseEntity])
}
