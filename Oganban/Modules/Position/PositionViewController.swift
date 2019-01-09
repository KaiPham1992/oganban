//
//  PositionViewController.swift
//  Oganban
//
//  Created DINH VAN TIEN on 12/29/18.
//  Copyright © 2018 Coby. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import GoogleMaps
import GooglePlaces
import DropDown

protocol PositionViewControllerDelegate: class {
    func positionSelected(location: CLLocationCoordinate2D, address: String, distance: PositionRangeEntity)
}

class PositionViewController: BaseViewController {
    
    @IBOutlet weak var mapView          : GMSMapView!
    @IBOutlet weak var lbTitleMarker    : UILabel!
    @IBOutlet weak var vTitleMarker     : UIView!
    @IBOutlet weak var tfAddress        : UITextField!
    @IBOutlet weak var vDropdown        : UIView!
    @IBOutlet weak var lbScale          : UILabel!
    
    var presenter: PositionPresenterProtocol?
    var locationManager = CLLocationManager()
    var centerMapCoordinate:CLLocationCoordinate2D!
    var marker:GMSMarker!
    var address = ""
    var dataSource: [PositionRangeEntity] = []
    var distance: PositionRangeEntity? {
        didSet {
            //            lbScale.text = distance?.title
        }
    }
    weak var delegate: PositionViewControllerDelegate?
    let scaleDropdown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        self.distance = UserDefaultHelper.shared.radius
    }
    
    override func setUpViews() {
        self.mapView?.isMyLocationEnabled = true
        //Location Manager code to fetch current location
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        tfAddress.delegate = self
        tfAddress.text = address
        setUpDropdown()
        lbScale.text = distance?.title
    }
    
    func setUpDropdown() {
        scaleDropdown.anchorView = vDropdown
        scaleDropdown.backgroundColor = AppColor.main
        DropDown.appearance().setupCornerRadius(10)
        scaleDropdown.textColor = .white
        scaleDropdown.textFont = AppFont.fontRegular11
        scaleDropdown.separatorColor = .gray
        scaleDropdown.selectionBackgroundColor = AppColor.main
        scaleDropdown.selectedTextColor = .yellow
        scaleDropdown.downScaleTransform = CGAffineTransform(rotationAngle: (-.pi))
        scaleDropdown.selectionAction = { [weak self](index, item) in
            guard let `self` = self else { return }
            self.distance = self.dataSource[index]
            self.lbScale.text = item
            //            if  self.dataSource[index].title& == "Không giới hạn" {
            //                self.paramFilter.radius = ""
            //            } else {
            //                self.paramFilter.radius = self.dataSource[index].title&
            //            }
            //            self.presenter?.filterRecord(param: self.paramFilter)
            let long = CGFloat(self.centerMapCoordinate.longitude)
            let lat = CGFloat(self.centerMapCoordinate.latitude)
            guard let distance = self.distance else { return }
            self.presenter?.getCountRecord(long: long, lat: lat, radius: Int(distance.value&))
        }
        scaleDropdown.dataSource = dataSource.map({$0.title&})
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        setTitleNavigation(title: "Chọn vị trí của bạn")
        addButtonTextToNavigation(title: "Huỷ", style: .left, action: #selector(btnRejectTapped), textColor: .gray)
        addButtonTextToNavigation(title: "Xong", style: .right, action: #selector(btnDoneTapped), textColor: .yellow)
    }
    
    @objc func btnRejectTapped() {
        presenter?.dismiss()
    }
    
    @objc func btnDoneTapped() {
        guard let distance = distance else { return }
        delegate?.positionSelected(location: centerMapCoordinate, address: tfAddress.text&, distance: distance)
        presenter?.dismiss()
    }
    
    @IBAction func showDropdownTapped() {
        scaleDropdown.show()
    }
}

extension PositionViewController: PositionViewProtocol {
    func didGetCountRecord(count: Int) {
        if count < 1000 {
            lbTitleMarker.text = "\(count) Tin đăng bán gần đây"
        } else {
            lbTitleMarker.text = "+999 Tin đăng bán gần đây"
        }
        vTitleMarker.isHidden = false
    }
}

extension PositionViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        self.mapView?.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
        
    }
}

//MARK: - delegate map position
extension PositionViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let latitude = mapView.camera.target.latitude
        let longitude = mapView.camera.target.longitude
        centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.placeMarkerOnCenter(centerMapCoordinate:centerMapCoordinate)
        print(centerMapCoordinate)
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        print(mapView.camera.target)
        print(position.target)
        let long = CGFloat(position.target.longitude)
        let lat = CGFloat(position.target.latitude)
        getAddressFromLocation(pdblLatitude: lat, withLongitude: long)

        
        guard let distance = self.distance else { return }
        presenter?.getCountRecord(long: long, lat: lat, radius: Int(distance.value&))
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        vTitleMarker.isHidden = true
    }
    
    func placeMarkerOnCenter(centerMapCoordinate:CLLocationCoordinate2D) {
        if marker == nil {
            marker = GMSMarker()
        }
        
        marker.position = centerMapCoordinate
        marker.map = self.mapView
    }
    
    
    func getAddressFromLocation(pdblLatitude: CGFloat, withLongitude pdblLongitude: CGFloat) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        var addressString : String = ""
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    print(addressString)
                    self.tfAddress.text = addressString
                }
        })
    }
}

extension PositionViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        PositionMapsHelper.shared.showSearch(controller: self) { address in
            textField.text = address
        }
    }
}
