//
//  Int+extension.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 10/12/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//


import UIKit
postfix operator *

postfix func *<T>(element: T?) -> Int {
    return (element == nil) ? 0: Int("\(element!)")!
}


extension Double {
    func roundedTwoDemical() -> String {
        return String(format: "%.2f", self)
    }
    
    func roundedOneDemical() -> String {
        return String(format: "%.1f", self)
    }
    
    func toUInt64() -> UInt64 {
        if self < 0 {
            return 0
        }
        let number = UInt64(self)
        
        return number
    }
}

extension Float {
    /// Rounds the double to decimal places value
    func roundedTwoDemical() -> String {
        return String(format: "%.2f", self)
    }
}

extension CGFloat {
    func toInt() -> Int {
        let intValue = Int(self)
        let mod = self - CGFloat(intValue)
        
        if mod > 0.5 {
            return intValue + 1
        } else {
            return intValue
        }
    }
}

extension Int {
    func toIntPositive()-> Int {
        if self >= 0 {
            return self
        }
        return 0 - self
    }
}

extension UInt64 {
    var toCurrency: String {
        let price = self as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "vi_vn")
        
        guard let currency = formatter.string(from: price) else { return ""}
        return currency.replacingOccurrences(of: ".", with: ",")
    }
}

public extension Double {
    
    /// Returns a random floating point number between 0.0 and 1.0, inclusive.
    public static var random: Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }
    
    /// Random double between 0 and n-1.
    ///
    /// - Parameter n:  Interval max
    /// - Returns:      Returns a random double point number between 0 and n max
    public static func random(min: Double, max: Double) -> Double {
        return Double.random * (max - min) + min
    }
    
    var toCurrency: String {
        let price = self as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_us")
        
        guard let currency = formatter.string(from: price) else { return ""}
        return currency.replacingOccurrences(of: "$", with: "")
    }
}
