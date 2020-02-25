//
//  Filter.swift
//  GlobalKVC_KVO
//
//  Created by Username on 22.02.2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import Foundation
import UIKit


enum TupeFilter{
    case date
    case list
    case range
}


class Filter {

    var name: String = "Name"
    var keyBackend: String?
    var multi: Bool = false
    var tupe: TupeFilter = .list

    var minValue: String?
    var maxValue: String?

    var contentMulti: [String] = []

    init(name: String,
         keyBackend: String?,
         multi: Bool,
         tupe: TupeFilter,
         minValue: String?,
         maxValue: String?,
         contentMulti: [String] = []) {

        self.name = name

        self.keyBackend     = keyBackend
        self.multi          = multi
        self.tupe           = tupe

        self.minValue       = minValue
        self.maxValue       = maxValue

        self.contentMulti   = contentMulti
    }
	
	var minIntValue: Int {
		guard let minValue = minValue else {return 0}
		
		return Int(minValue) ?? 0
	}
	
	var maxIntValue: Int {
		guard let maxValue = maxValue else {return Int.max}
		
		return Int(maxValue) ?? Int.max
	}
	
	
	var minDate: Date? {
		guard let minValue = minValue else {return nil}
		
		return minValue.getDatwToString()
	}
	
	var maxDate: Date? {
		guard let maxValue = maxValue else {return nil}
		
		return maxValue.getDatwToString()
	}
	
	
	//построениие ячеек
	
	
}


extension Filter: Hashable {
	
	static func == (lhs: Filter, rhs: Filter) -> Bool {
		
		if lhs.keyBackend == rhs.keyBackend, lhs.name == rhs.name{
			return true
		}
		
		return false
	}
	
    func hash(into hasher: inout Hasher) {
        hasher.combine(keyBackend)
        hasher.combine(name)
    }
	
}


struct FiltersValue {
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
