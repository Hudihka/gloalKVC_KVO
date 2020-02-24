//
//  ViewController.swift
//  GlobalKVC_KVO
//
//  Created by Hudihka on 20/02/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var filterArray = [Filter]()
	
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var tableView: UITableView!


	override func viewDidLoad() {
		super.viewDidLoad()
		
        saveButton.desing(true)
	}

    

    @IBAction func saveButtonAction(_ sender: Any) {

        saveButton.desing(true)
    }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource{

    fileprivate func desingTV(){

        tableView.baseSettingsTV(obj: self,
                                 minHeghtCell: 60,
                                 arrayNameCell: [String]?)


    }


}
