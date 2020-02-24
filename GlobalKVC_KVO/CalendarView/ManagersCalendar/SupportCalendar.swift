//
//  SupportCalendar.swift
//  Calendar
//
//  Created by Username on 31.01.2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import Foundation
import UIKit


struct Year {

    var numberYear: Int
    var months: [Month] = []

    init(date: Date) {

        self.numberYear = date.year

        let calendar = Calendar.current

        for i in 1...12{
            let dateMonth = DateComponents(calendar: calendar, year: self.numberYear, month: i).date!

            let month = Month(date: dateMonth, year: self.numberYear, numberMonth: i)

            self.months.append(month)

        }
    }


}



struct Month {

    var days: [Date] = []
    var nameMonth: String
    var offset: Int = 0 //отступ для первого дня
    var isDiapazone = false //есть хоть один день в этом месяце что в диапазоне возможных дат

    init(date: Date, year: Int, numberMonth: Int) {
        self.nameMonth = date.monthString
        self.offset = Date(day: 1, month: numberMonth, year: year).nameDayMonth - 1
        self.days = date.daysArrayDate(yerar: year, month: numberMonth)
        self.isDiapazone = DateParser.shared.monthInDiapason(date: self.days)
    }

}


