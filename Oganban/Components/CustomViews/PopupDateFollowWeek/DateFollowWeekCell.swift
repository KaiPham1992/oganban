//
//  CollectionViewCell.swift
//  free
//
//  Created by Admin on 12/23/18.
//  Copyright © 2018 Vinova. All rights reserved.
//

import UIKit

class DateFollowWeekCell: UICollectionViewCell {

    @IBOutlet weak var lbDay: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbMonth: UILabel!
    @IBOutlet weak var lbYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func showData(date: Date){
        
        self.setColorDate(date: date)
        let calendar = Calendar.current
    
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        lbDay.text = getNameOfDay(date: date)
        lbDate.text = "\(day)"
        lbMonth.text = "THÁNG " + "\(month)"
        lbYear.text = "\(year)"
    }
    
    func getNameOfDay(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "EEEE"
        let dayInWeek = dateFormatter.string(from: date as Date)
        
        switch dayInWeek {
        case "Monday":
            return "Thứ 2"
        case "Tuesday":
            return "Thứ 3"
        case "Wednesday":
            return "Thứ 4"
        case "Thursday":
            return "Thứ 5"
        case "Friday":
            return "Thứ 6"
        case "Saturday":
            return "Thứ 7"
        default:
            return "CN"
        }
    }
    
    private func setColorDate(date: Date){
        lbDay.textColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "yyyy/mm/dd"
        
       // if dateFormatter.string(from: date) == dateFormatter.string(from: Date()){
        if Calendar.current.isDate(date, inSameDayAs: Date()) {
            lbDate.textColor = AppColor.grey9E9E9E
            lbMonth.textColor = AppColor.grey9E9E9E
            lbYear.textColor = AppColor.grey9E9E9E
        } else {
            lbDate.textColor = AppColor.red
            lbMonth.textColor = AppColor.red
            lbYear.textColor = AppColor.red
        }
    }
    
    func setColorSelectedDate(isSelected: Bool, date: Date){
        if isSelected {
            lbDate.textColor = AppColor.green
            lbMonth.textColor = AppColor.green
            lbYear.textColor = AppColor.green
        } else {
            setColorDate(date: date)
        }
    }
}
