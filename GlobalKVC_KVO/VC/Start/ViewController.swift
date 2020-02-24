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
		
		filterArray = [
			Filter(name: "Таблица одиночная",
				   keyBackend: "KeyBack1",
				   multi: false,
				   tupe: .list,
				   minValue: nil,
				   maxValue: nil,
				   contentMulti: ["Maha", "Paha", "Vova", "Assa", "Egor", "Petr", "Olga"]),
			Filter(name: "Таблица мульти",
				   keyBackend: "KeyBack2",
				   multi: true,
				   tupe: .list,
				   minValue: nil,
				   maxValue: nil,
				   contentMulti: ["MahaMulti", "PahaMulti", "VovaMulti", "AssaMulti", "EgorMulti", "PetrMulti", "OlgaMulti"]),
			Filter(name: "Budget",
				   keyBackend: "KeyBack2",
				   multi: false,
				   tupe: .range,
				   minValue: "500",
				   maxValue: "80000",
				   contentMulti: []),
			Filter(name: "Calendar",
				   keyBackend: "KeyBack3",
				   multi: false,
				   tupe: .date,
				   minValue: "2019-02-24T09:25:25+0000",
				   maxValue: "2020-10-24T09:25:25+0000",
				   contentMulti: [])
		]
		
		desingTV()
        saveButton.desing(true)
	}

    

    @IBAction func saveButtonAction(_ sender: Any) {

        saveButton.desing(true)
    }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filterArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CellFilter", for: indexPath) as! CellFilter
		cell.filter = filterArray[indexPath.row]
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let filtr = filterArray[indexPath.row]
		
		filtr.tupe.pushVC(filter: filtr)
	}
	

    fileprivate func desingTV(){

        tableView.baseSettingsTV(obj: self,
                                 minHeghtCell: 60,
                                 arrayNameCell: ["CellFilter"])


    }


}