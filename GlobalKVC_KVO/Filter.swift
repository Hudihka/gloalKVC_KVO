//
//  Filter.swift
//  GlobalKVC_KVO
//
//  Created by Username on 22.02.2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import Foundation

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
	
	


}
