//
//  VCCounter.swift
//  GlobalKVC_KVO
//
//  Created by Hudihka on 21/02/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class VCTableOne: UIViewController {
	
	@IBOutlet weak var buttonCount: UIButton!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

		
        buttonCount.desing(true)
    }
	

	
	
	
	
    


}






extension UIButton{
	
	func desing(_ block: Bool){
		self.isEnabled = !block
		self.alpha = block ? 0.5 : 1
	}
	
}
