//
//  DatePopup.swift
//  free
//
//  Created by Kent on 12/23/18.
//  Copyright © 2018 Vinova. All rights reserved.
//

import UIKit

class DateFollowWeekPopup: BaseViewXib  {
    
    @IBOutlet weak var btnChoose: UIButton!
    @IBOutlet weak var cvDate: UICollectionView!
    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var vBackground: UIView!
    
    let dateFormatter = DateFormatter()
    var dateList = [Date]()
    var completionDate : CompletionDate?
    var selectedDate: Date?
    
    private var widthContent: CGFloat = 0
    private var heightContent: CGFloat = 0
    private var minXContent: CGFloat = 0
    private var minYContent: CGFloat = 0
    private var widthWindow: CGFloat = 0
    private var heightWindow: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        registerCollectionView()
        setupView()
        getDefaultData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        registerCollectionView()
        setupView()
        getDefaultData()
    }
    
    func registerCollectionView(){
        cvDate.register(UINib(nibName: "DateFollowWeekCell", bundle: nil), forCellWithReuseIdentifier: "DateFollowWeekCell")
        cvDate.dataSource = self
        cvDate.delegate = self
    }
    
    func setupView() {
        dateFormatter.dateFormat = "dd-MM-yyyy"
        btnChoose.layer.cornerRadius = btnChoose.frame.height / 2.0
        btnChoose.layer.masksToBounds = true
    }
    
    func getDefaultData(){
        dateList = self.generateDates(fromStartDate: Date(), value: 6)
        cvDate.reloadData()
    }
    
    func generateDates(isNextDate: Bool = true, fromStartDate :Date, addbyUnit:Calendar.Component = .day, value : Int) -> [Date] {
        
        var dates = [Date]()
        dates.append(fromStartDate)
        
        var date = fromStartDate
        let endDate = Calendar.current.date(byAdding: addbyUnit, value: value, to: date)!
        
        if isNextDate {
            while date < endDate {
                date = Calendar.current.date(byAdding: addbyUnit, value: 1, to: date)!
                dates.append(date)
            }
        } else { // is previous date from start date
            while date > endDate {
                date = Calendar.current.date(byAdding: addbyUnit, value: -1, to: date)!
                dates.insert(date, at: 0)
            }
        }
        return dates
    }
    
    func calculateDates (isNextDate: Bool) {
        if isNextDate {
            guard let endDate = self.dateList.last else {
                return
            }
            let startDate = Calendar.current.date(byAdding: .day, value: 1, to: endDate)!
            dateList = self.generateDates(isNextDate: true, fromStartDate: startDate, value: 6)
        } else {
            guard let endDate = self.dateList.first else {
                return
            }
            let startDate = Calendar.current.date(byAdding: .day, value: -1, to: endDate)!
            dateList = self.generateDates(isNextDate: false, fromStartDate: startDate, value: -6)
        }
        self.cvDate.reloadData()
    }
    
    @IBAction func tapSelectButton(_ sender: UIButton) {
        if let date = selectedDate {
            self.hidePopUp { (_) in
                guard let completion = self.completionDate else { return }
                completion(date)
            }
        }
    }
    
    @IBAction func tapCloseButton(_ sender: UIButton) {
        self.hidePopUp()
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.calculateDates(isNextDate: false)
    }
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        self.calculateDates(isNextDate: true)
    }
}

extension DateFollowWeekPopup: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateFollowWeekCell", for: indexPath) as? DateFollowWeekCell else {
            return UICollectionViewCell()
        }
        
        let date = self.dateList[indexPath.item]
        cell.showData(date: date)
        
        if let selectedDate = selectedDate, Calendar.current.isDate(date, inSameDayAs: selectedDate) {
            cell.setColorSelectedDate(isSelected: true, date: date)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = collectionView.frame.width / 7.0 
        return CGSize(width: width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DateFollowWeekCell else { return }
        cell.setColorSelectedDate(isSelected: true, date: self.dateList[indexPath.item])
        selectedDate = self.dateList[indexPath.item]
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DateFollowWeekCell else { return }
        cell.setColorSelectedDate(isSelected: false, date: self.dateList[indexPath.item])
    }
}

extension DateFollowWeekPopup {
    
    func showPopUp(width: CGFloat = 200, height: CGFloat = 200, completionDate: @escaping CompletionDate) {
        
        if let window = UIApplication.shared.keyWindow {
            let wid = window.safeAreaLayoutGuide.layoutFrame.width - 40
            vContent.frame = CGRect(x: 20, y: window.frame.height + height, width: wid, height: height)
            
            if #available(iOS 11.0, *) {
                let window = UIApplication.shared.keyWindow
                let topPadding = window?.safeAreaInsets.top
                let bottomPadding = window?.safeAreaInsets.bottom
                print("\(String(describing: topPadding)) - \(bottomPadding ?? 0)")
            }
        
            window.addSubview(self)
            print(window.frame)
            self.fillSuperview()
            self.completionDate = completionDate
            self.vBackground.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseOut, animations: { [unowned self] in
                self.vBackground.alpha = 1
                if #available(iOS 11, *) {
                    self.vContent.frame = CGRect(x: self.vContent.frame.minX, y: window.safeAreaLayoutGuide.layoutFrame.height/2 - height/2, width: wid, height: height)
                } else {
                    self.vContent.frame = CGRect(x: self.vContent.frame.minX, y: window.frame.height - height - window.safeAreaLayoutGuide.layoutFrame.height/2, width: wid, height: height)
                }
                }, completion: nil)
        }
    }
    
    func hidePopUp(success: ((Bool) -> Void)? = nil) {
        
        self.vBackground.alpha = 1
        guard let window = UIApplication.shared.keyWindow else { return }
        UIView.animate(withDuration: 0.3, animations: { [unowned self] in
            self.vContent.frame = CGRect(x: 0, y: window.frame.height + 1000, width: self.vContent.frame.width, height: self.vContent.frame.height)
            
            }, completion: { [weak self] _ in
                guard let strongSelf = self else {
                    success?(false)
                    return }
                
                strongSelf.vBackground.alpha = 0
                strongSelf.removeFromSuperview()
                success?(true)
        })
        
    }
}





