//
//  VCTF.swift
//  GlobalKVC_KVO
//
//  Created by Hudihka on 21/02/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class VCTF: MainViewController {

    @IBOutlet weak var buttonUpdate: UIButton!

	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var textField2: UITextField!
	
	private var minValue: Int{
		return textField.count ?? filter?.minIntValue ?? 0
	}
	
	private var maxValue: Int{
		return textField2.count ?? filter?.maxIntValue ?? Int.max
	}
	
	private var isNoEmmpty: Bool{
		if textField.count != nil {
			return true
		}
		
		return textField2.count != nil
	}
	
	private var inDiapasone: Bool {
		
		guard let filtr = filter else {return false}
		
		if filtr.minIntValue <= minValue, maxValue <= filtr.maxIntValue {
			return true
		}
		
		return false
	}
	
	
	var filter: Filter?

	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		
		NotificationCenter.default.addObserver(self,
											   selector: #selector(kbDidHide),
											   name: UIResponder.keyboardWillHideNotification,
											   object: nil)
		
		updaateView()
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
		
		if let tfStruct = managerFilter.getTFStruct(filter) {
			
			if let min = tfStruct.textValueMin {
				self.textField.text = "\(min)"
			}
			
			if let max = tfStruct.textValueMax {
				self.textField2.text = "\(max)"
			}
		}

        buttonUpdate.desing(true)
	}
	
	
    @IBAction func saveButtonAction(_ sender: Any) {
		managerFilter.dismisLocale(save: true)
        self.navigationController?.popViewController(animated: true)
    }
	
	@IBAction func tabAction(_ sender: Any) {
		
		textField.resignFirstResponder()
		textField2.resignFirstResponder()
		
	}
	
    @objc func kbDidHide(notification: Notification) {
		if isNoEmmpty, minValue <= maxValue, inDiapasone{
			
			//есть оба значениия
			if let min = textField.count, let max = textField2.count {
				managerFilter.addFiltrLocal(filter, value: [min, max])
				return
			}
			
			guard let filtr = filter else {return}
			let value = textField.count ?? textField2.count ?? filtr.minIntValue
			let toInt = textField.count == nil ? filtr.minIntValue : filtr.maxIntValue
			
			managerFilter.addFiltrLocal(filter, value: [value], intTwoBudget: toInt)
			
		} else {
			textField.text = nil
			textField2.text = nil
			managerFilter.addFiltrLocal(filter, value: [])
		}
    }

	override func equaleLocalFilters(_ blockButton: Bool) {
        buttonUpdate.desing(blockButton)
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
