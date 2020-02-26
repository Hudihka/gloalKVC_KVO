//
//  MainViewController.swift
//  GlobalKVC_KVO
//
//  Created by Hudihka on 25/02/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, EqualeFilters {
	
	var managerFilter = ManagerFilters.shared

    override func viewDidLoad() {
        super.viewDidLoad()

		managerFilter.createLocalCopu()
        managerFilter.delegate = self
    }
	
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
		
		managerFilter.dismisLocale(save: false)
    }

    func equaleLocalFilters(blockButton: Bool){}

}
