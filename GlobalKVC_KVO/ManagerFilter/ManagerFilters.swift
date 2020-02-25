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
	
	var allFilters: [Filter : [Any]] = [:]
	
	
	
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
	
	
	//
	
	
	
}
