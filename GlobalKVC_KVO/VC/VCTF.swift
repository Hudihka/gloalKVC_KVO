//
//  VCTF.swift
//  GlobalKVC_KVO
//
//  Created by Hudihka on 21/02/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class VCTF: UIViewController {

    @IBOutlet weak var buttonUpdate: UIButton!

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textField2: UITextField!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		updaateView()
	}
	
	func updaateView(){
		self.textField.text = "3vf3v3vr3v"

        buttonUpdate.desing(true)
	}
	
	
    @IBAction func buttonUpdate(_ sender: UIButton) {


    }

	
}
