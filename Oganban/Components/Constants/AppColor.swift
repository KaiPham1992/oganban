//
//  AppColor.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/18/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import UIKit

struct AppColor {
    static let red = UIColor(red: 179/255, green: 19/255, blue: 14/255, alpha: 1)
    
    static let redHot = UIColor(red: 237/255.0, green: 27/255.0, blue: 35/255.0, alpha: 1.0)
    
    static let green = UIColor(red: 0/255, green: 134/255, blue: 69/255, alpha: 1)
    static let loadGif = UIColor(hexString: "de3629")
    static let white = UIColor.white
    static let placeHolderWhite = UIColor.white.withAlphaComponent(0.7)
    static let gray = UIColor(red: 169/255, green: 169/255, blue: 169/255, alpha: 1)
    static let clear = UIColor.clear
    static let backgroundMenu = UIColor.black.withAlphaComponent(0.8)
    static let backgroundItem = UIColor.black.withAlphaComponent(0.5)
    static let line = UIColor.black.withAlphaComponent(0.5)
    static let yellow = UIColor(red: 241/255, green: 204/255, blue: 28/255, alpha: 1)
    static let pinkBackground = UIColor(red: 254/255, green: 243/255, blue: 243/255, alpha: 1)
    
    static let baseColors: [UIColor] = [.red, .green, .blue, .yellow, UIColor(hexString: "00ffff"), UIColor(hexString: "ff00ff") , UIColor.white]
    static let textLabel                = UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1)
    static let textColor = UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1)
    static let orange = UIColor(red: 241/255, green: 121/255, blue: 28/255, alpha: 1)
    static let borderDarkGray = UIColor(red: 169/255, green: 169/255, blue: 169/255, alpha: 1)
    static let greenLow = UIColor(red: 49/255, green: 155/255, blue: 0/255, alpha: 1)
    static let grayDark = UIColor(red: 115/255, green: 115/255, blue: 115/255, alpha: 1)
    static let orangePeel = UIColor(red: 255/255, green: 152/255, blue: 1/255, alpha: 1)
}
