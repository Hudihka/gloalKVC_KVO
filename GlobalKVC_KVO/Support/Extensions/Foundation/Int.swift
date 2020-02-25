//
//  Int.swift
//  GlobalKVC_KVO
//
//  Created by Hudihka on 24/02/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import Foundation


extension Int{
	
	var countSummbol: Int{
		return "\(self)".count
	}
	
	func equalLenghtSumbol(str: String) -> Bool{
		
		return str.count <= countSummbol
		
	}
	
	
}
