//
//  ManagerFilters.swift
//  GlobalKVC_KVO
//
//  Created by Username on 22.02.2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import Foundation
import UIKit


class ManagerFilters{
	
	static let shared = ManagerFilters()
	
	private var allFilters: [Filter : [Any]] = [:]
	
	private var allFiltersCopy: [Filter : [Any]] = [:]
	private var localFiltersCopy: [Filter : [Any]] = [:]
	
	
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
		
		guard let array = allFiltersCopy[filtr] else {return nil}
		
		switch filtr.tupe {
		case .date:
			
			guard let arrayStr = array as? [Date],
				let first = arrayStr.min()?.printDate(format: "d.MM.yyyy"),
				let last = arrayStr.max()?.printDate(format: "d.MM.yyyy")  else {
					return nil
			}
			
			return "от \(first) до \(last)"
			
		case .range:
		
			guard let arrayInt = array as? [Int],
				let min = arrayInt.min(),
				let max = arrayInt.max() else {return nil}
			
			return "от \(min) до \(max)"
			
		default:
			
			guard let arrayStr = array as? [String] else {return nil}
			return arrayStr.joined(separator: ", ")
		}
		
		
	}
	
	
	//MARK: - локальные фильтр
	
	func createLocalCopu(){
		localFiltersCopy = allFiltersCopy
	}
	
	func addFiltrLocal(_ filtr: Filter?, value: Any){
		
		guard let filtr = filtr else {return}
		
		guard var array = localFiltersCopy[filtr] else {
			localFiltersCopy[filtr] = [value]
			return
		}
		
		if filtr.tupe == .list,
			let stringArray = array as? [String],
			let stringValue = value as? String,
		    stringArray.contains(stringValue) {
			
			localFiltersCopy[filtr] = stringArray.filter({$0 != stringValue})
			
		} else {
			array += [value]
			localFiltersCopy[filtr] = array
		}
	
	}
	
	func dismisLocale(save: Bool){
		
		if save {
			allFiltersCopy = localFiltersCopy
		}
		
		localFiltersCopy = [:]
		//TODO добавить нотифиикацию закрытия шторки
		//делаем перезагрузку для страницы с таблицой
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
		}
		
		localFiltersCopy = [:]
		//TODO добавить нотифиикацию закрытия вью контроллера с фильтрами
		//и перезагрузка навигейшен бара
	}
	
	
}
