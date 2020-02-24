//
//  SupportClass.swift
//  ginzaWindRegistration
//
//  Created by Hudihka on 15/01/2019.
//  Copyright © 2019 Username. All rights reserved.
//

import UIKit


let hDdevice = UIScreen.main.bounds.size.height
let wDdevice = UIScreen.main.bounds.size.width


var getHKey: Int {

    //без автокоррекцией
    switch hDdevice {
    case 896: return 267//XMAX
    case 812: return 257//X
    case 736: return 226//7+/8+
    case 667: return 216//7/8
    case 568: return 216//5
    default: return 253
    }
}


var getHKeyAutokorec: Int {

    //с автокоррекции
    switch hDdevice {
    case 896: return 317//XMAX
    case 812: return 302//X
    case 736: return 271//7+/8+
    case 667: return 260//7/8
    case 568: return 253//5
    default: return 253
    }
}

var isIPhone5: Bool {
    return hDdevice == 568
}

var isIPhoneXorXmax: Bool {
    return hDdevice >= 812
}

var indentNavigationBarHeight: CGFloat {
    return statusBarHeight + navigBarHeight //88 : 64
}

var statusBarHeight: CGFloat{
    return isIPhoneXorXmax ? 44 : 20
}

let navigBarHeight: CGFloat = 44

var heightTabBar: CGFloat {
    return isIPhoneXorXmax ? 84 : 58
}

//MARK: - Calendar

let scrollInTooDay = true
  
//Коллекшен вью с годами
let offsetCV: CGFloat   = 5
let offsetCell: CGFloat = 3

let widthMonth = (wDdevice - (2 * offsetCV) - (4 * offsetCell)) / 3
let widthDayInMonth = widthMonth / 7
let heightMonth = (widthDayInMonth * 6.5) + 30 //30 высота лейбла

//Коллекшен вью с месяцами

let widthWeek = wDdevice - (2 * offsetCV)
let widthDay  = widthWeek / 7

//


//MARK: - Colors


let colorDay = UIColor.black
let colorWekend = UIColor.red

let selectedView = UIColor.red.withAlphaComponent(0.3)

