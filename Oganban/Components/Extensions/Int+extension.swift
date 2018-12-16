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
    func toDistance() -> String {
        if self < 1000 {
            return String(format:">%.1fkm", self)
        } else {
            return String(format:">%.0fkm", self)
        }
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
}
