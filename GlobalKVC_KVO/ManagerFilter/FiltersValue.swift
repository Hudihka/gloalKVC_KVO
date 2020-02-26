//
//  FilterValue.swift
//  GlobalKVC_KVO
//
//  Created by Username on 26.02.2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import Foundation

struct FiltersValue: Equatable {
    var arrayRange = [Int]()
    var arrayString = [String]()
    var arrayDate = [Date]()

    init(int: [Int] = [],
         string: [String] = [],
         date: [Date] = [],
         any: Any?) {

        arrayRange = int
        arrayString = string
        arrayDate = date


        if let value = any as? String {
            arrayString = [value]
        }

        if let value = any as? Int {
            arrayRange = [value]
        }

        if let value = any as? Date {
            arrayDate = [value]
        }
    }


    mutating func reloadStruct(filter: Filter, any: Any){

        if let value = any as? String {
            self.relodStringArray(filter: filter, str: value)
            return
        }

        if let value = any as? Int {
            self.relodIntArray(int: value)
            return
        }

        if let value = any as? Date {
            self.relodDateArray(date: value)
        }
    }

    var isEmptuStruct: Bool{
        return arrayRange.isEmpty && arrayDate.isEmpty && arrayString.isEmpty
    }


    mutating private func relodStringArray(filter: Filter, str: String) {
        if filter.multi {
            if arrayString.contains(str) {
                arrayString = arrayString.filter({$0 != str})
            } else {
                arrayString += [str]
            }
        } else {
            self.arrayString = arrayString.contains(str) ? [] : [str]
        }
    }

    mutating private func relodIntArray(int: Int) {
        self.arrayRange.append(int)
    }

    mutating private func relodDateArray(date: Date) {
        self.arrayDate.append(date)
    }
}
