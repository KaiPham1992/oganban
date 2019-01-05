//
//  PostStepOneInteractor.swift
//  Oganban
//
//  Created Kai Pham on 1/4/19.
//  Copyright © 2019 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class PostStepOneInteractor: PostStepOneInteractorInputProtocol {

    weak var presenter: PostStepOneInteractorOutputProtocol?
    
    func getCategoryMerge() {
        Provider.shared.categoryAPIService.getCategoryMerge(success: { (result) in
            self.presenter?.didGetCategoryMerge(list: result)
        }) { (error) in
            
        }
    }
}