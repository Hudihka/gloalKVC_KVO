//
//  ManagerFilters.swift
//  GlobalKVC_KVO
//
//  Created by Username on 22.02.2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import Foundation
import UIKit

protocol EqualeLocale: class{
    func equaleLocalFilters(_ blockButton: Bool)
}

protocol EqualGlobal: class {
	func reloadTV()
    func equalGlobalFilters(_ blockButton: Bool)
}

protocol BBItemReload: class{
    func reloadBBItem()
}

class ManagerFilters{
	
	static let shared = ManagerFilters()
	
	private var allFilters: [Filter : FiltersValue] = [:]
	
	private var allFiltersCopy: [Filter : FiltersValue] = [:]
	private var localFiltersCopy: [Filter : FiltersValue] = [:]

    weak var delegateLocale: EqualeLocale?
    weak var delegateGlobal: EqualGlobal?
    weak var delegateBBItem: BBItemReload?
	
	func pushVC(VC: UIViewController, filter: Filter){
		
		guard let NC = VC.navigationController else {return}
		
		switch filter.tupe {
		case .date:
			NC.pushViewController(VCCalendar.route(filter), animated: true)
		case .list:
			NC.pushViewController(VCTable.route(filter), animated: true)
		default:
			NC.pushViewController(VCTF.route(filter), animated: true)
		}
	}
	
	//MARK: Текст на ячейках, если нил то не выбрано
	
	func textCell(_ filtr: Filter) -> String?{
		
		guard let filtrStruct = allFiltersCopy[filtr] else {return nil}
		
		switch filtr.tupe {
		case .date:
			
			guard let first = filtrStruct.arrayDate.min()?.printDate(format: "d.MM.yyyy"),
				let last = filtrStruct.arrayDate.max()?.printDate(format: "d.MM.yyyy")  else {
					return nil
			}
			
			return "от \(first) до \(last)"
			
		case .range:
		
			guard let min = filtrStruct.arrayRange.min(),
				let max = filtrStruct.arrayRange.max() else {return nil}
			
			return "от \(min) до \(max)"
			
		default:
			
			return filtrStruct.arrayString.joined(separator: ", ")
		}
		
	}
	
	
	//MARK: - локальные фильтр
	
	func createLocalCopu(){
		localFiltersCopy = allFiltersCopy
	}
	
	func addFiltrLocal(_ filtr: Filter?, value: Any){
		
		guard let filtr = filtr else {return}
		
		guard var structSelected = localFiltersCopy[filtr] else {
			localFiltersCopy[filtr] = FiltersValue(any: value)
            equal()
			return
		}
		
		structSelected.reloadStruct(filter: filtr, any: value)
        localFiltersCopy[filtr] = structSelected.isEmptuStruct ? nil : structSelected
        equal()
	}
	
	func textTF(_ filtr: Filter?) -> [Int]?{
		guard let filtr = filtr, let array = localFiltersCopy[filtr]?.arrayRange, !array.isEmpty else {return nil}
		
		return array
	}
	
	
	func isSelect(_ filtr: Filter?, str: String) -> Bool{
		
		guard let filtr = filtr, let arrayStr = localFiltersCopy[filtr]?.arrayString else {return false}
		
		return arrayStr.contains(str)
	}
	
	
	func dismisLocale(save: Bool){
		
		if save {
			allFiltersCopy = localFiltersCopy
			self.delegateGlobal?.equalGlobalFilters(allFilters == allFiltersCopy)
		}
		
		localFiltersCopy = [:]
		//TODO добавить нотифиикацию закрытия шторки
	}
	
	
	//MARK: - все фильтры
	
	func createGlobalCopu(){
		allFiltersCopy = allFilters
	}
	
	func deleteGlobal(_ filtr: Filter?){
		
		guard let filtr = filtr else {return}
		
		allFiltersCopy[filtr] = nil
	}
	
	func dismisGlobal(save: Bool){
		
		if save {
			allFilters = allFiltersCopy
            self.delegateBBItem?.reloadBBItem()
		}
		
		localFiltersCopy = [:]
		//TODO добавить нотифиикацию закрытия вью контроллера с фильтрами
	}

    //MARK: delete

    func deleteOne(_ filtr: Filter?){

        guard let filtr = filtr else {return}

        allFiltersCopy[filtr] = nil

        self.delegateGlobal?.reloadTV()
        self.delegateGlobal?.equalGlobalFilters(allFilters == allFiltersCopy)
        if filtr.tupe == .date {
            self.delegateLocale?.equaleLocalFilters(true)
        }
    }

    func deleteAll(){

        allFiltersCopy = [:]

        self.delegateGlobal?.reloadTV()
        self.delegateGlobal?.equalGlobalFilters(allFilters == allFiltersCopy)
    }

    //MARK: BBItem

    var countSelectFilter: Int {
        return allFilters.count
    }
	
	///MARK: - сравнениие значений
	
    private func equal(){
		let value = localFiltersCopy == allFiltersCopy
		self.delegateLocale?.equaleLocalFilters(value)
		
		if value == false{
			self.delegateGlobal?.reloadTV()
		}
		
    }


}
