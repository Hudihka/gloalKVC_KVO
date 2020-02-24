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
	
	var filter: Filter?

	override func viewDidLoad() {
		super.viewDidLoad()
		
		updaateView()
	}
	
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
		
		///убраем
    }
	
	static func route(_ filter: Filter) -> VCTF{
		
		let storubord = UIStoryboard(name: "Main", bundle: nil)
		let VC = storubord.instantiateViewController(identifier: self.className) as! VCTF
		
		VC.filter = filter
		
		return VC
	}
	
	func updaateView(){
		self.textField.text = "3vf3v3vr3v"

        buttonUpdate.desing(true)
	}
	
	
    @IBAction func saveButtonAction(_ sender: Any) {

        self.navigationController?.popViewController(animated: true)
    }

	
}
