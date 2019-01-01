//
//  PositionMapsHelper.swift
//  Oganban
//
//  Created by DINH VAN TIEN on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
class PositionMapsHelper: NSObject {
    static let shared = PositionMapsHelper()
    var controller: UIViewController?
    var completion: CompletionMessage?
}

extension PositionMapsHelper: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        self.completion?(place.formattedAddress)
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress ?? "null")")
//        self.tfAddress.text = place.formattedAddress
        print("Place attributions: \(String(describing: place.attributions))")
        
        controller?.dismiss(animated: true, completion: nil)
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        //        print("Error: \(error.description)")
        //        self.dismiss(animated: true, completion: nil)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("Autocomplete was cancelled.")
        controller?.dismiss(animated: true, completion: nil)
    }
    
    func showSearch(controller: UIViewController?, completion: CompletionMessage?) {
        self.completion = completion
        self.controller = controller
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        controller?.present(acController, animated: true, completion: nil)
    }
}
