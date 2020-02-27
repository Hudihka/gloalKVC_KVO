//
//  VCCalendar.swift
//  GlobalKVC_KVO
//
//  Created by Hudihka on 24/02/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class VCCalendar: MainViewController {
	
	@IBOutlet weak var buttonCount: UIButton!

	var filter: Filter?

    override func viewDidLoad() {
        super.viewDidLoad()

        let CV = CalendarCollection()

        view.addSubview(CV)

        CV.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        CV.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        CV.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true

        if let ancor = buttonCount?.topAnchor {
            CV.bottomAnchor.constraint(equalTo: ancor, constant: -60).isActive = true
        }

        CV.filter = filter

		buttonCount.desing(true)
    }
	
	
	static func route(_ filter: Filter) -> VCCalendar{
		
		let storubord = UIStoryboard(name: "Main", bundle: nil)
		let VC = storubord.instantiateViewController(withIdentifier: self.className) as! VCCalendar
		
		VC.filter = filter
		
		return VC
	}
    
	
    @IBAction func saveButtonAction(_ sender: Any) {
		managerFilter.dismisLocale(save: true)
        self.navigationController?.popViewController(animated: true)
    }

	override func equaleLocalFilters(_ blockButton: Bool) {
        buttonCount.desing(blockButton)
    }

}


