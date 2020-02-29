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
	var intTo: Int?  //нужно для диапазона. Если нил то ведено 2 значения
					 //этот параметр используем только для передачи на бэк(ну или локалььной фильтрации)
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


	mutating func reloadStruct(filter: Filter, any: Any, intTwoBudget: Int?){

        if let value = any as? String {
            self.relodStringArray(filter: filter, str: value)
            return
        }

        if let value = any as? Int {
            self.relodIntArray(int: value)
			self.intTo = intTwoBudget
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


struct TFValues {
	var textValueMin: Int?
	var textValueMax: Int?
	
	var textSertchMin: Int = 0
	var textSertchMax: Int = Int.max
	
	
	init(strucFiltr: FiltersValue) {
		let array = strucFiltr.arrayRange
		
		if array.isEmpty {
			return
		}
		
		if array.count == 2 {
			textValueMin = array.min()
			textValueMax = array.max()
			
			textSertchMin = array.min() ?? Int.min
			textSertchMax = array.max() ?? Int.max
			
		} else if let twoValue = strucFiltr.intTo, let first = array.first {
			
			let min = Swift.min(twoValue, first)
			let max = Swift.max(twoValue, first)
			
			textValueMin = min
			textValueMax = max
			
			textSertchMin = min
			textSertchMax = max
		}
	}
	
	var textCell: String? {
		var str = ""
		
		if let min = textValueMin {
			str += "от \(min) "
		}
		
		if let max = textValueMax {
			str += "до \(max)"
		}
		
		return str
	}
	
}
