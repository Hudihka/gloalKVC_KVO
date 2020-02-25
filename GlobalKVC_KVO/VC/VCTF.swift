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
		
		NotificationCenter.default.addObserver(self,
											   selector: #selector(kbDidHide),
											   name: UIResponder.keyboardWillHideNotification,
											   object: nil)
		
		updaateView()
	}
	
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
		
		///убраем
    }
	
	static func route(_ filter: Filter) -> VCTF{
		
		let storubord = UIStoryboard(name: "Main", bundle: nil)
		let VC = storubord.instantiateViewController(withIdentifier: self.className) as! VCTF
		
		VC.filter = filter
		
		return VC
	}
	
	func updaateView(){
		guard let filter = filter else {return}
		
		textField.delegate = self
		textField2.delegate = self
		
		self.textField.placeholder = "от \(filter.minIntValue)"
		self.textField2.placeholder = "до \(filter.maxIntValue)"
		
		
		//значения из выбранных фильтров

        buttonUpdate.desing(true)
	}
	
	
    @IBAction func saveButtonAction(_ sender: Any) {

        self.navigationController?.popViewController(animated: true)
    }
	
	@IBAction func tabAction(_ sender: Any) {
		
		textField.resignFirstResponder()
		textField2.resignFirstResponder()
		
	}
	
    @objc func kbDidHide(notification: Notification) {
        ///
    }
	
	
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

	
}


extension VCTF: UITextFieldDelegate {
	
	func textField (_ textField: UITextField,
					shouldChangeCharactersIn range: NSRange,
					replacementString string: String) -> Bool {
		
		guard let filter = filter else {return true}
		
		let firstTF = textField == self.textField

		if firstTF {
			return textField.allowReadMin(minValue: filter.minIntValue,
										  maxValue: filter.maxIntValue,
										  string: string,
										  range: range)

		} else {

			return textField.allowReadMin(maxValue: filter.maxIntValue, string: string, range: range)

		}

    }
	
	
}
