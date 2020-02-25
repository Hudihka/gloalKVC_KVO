//
//  VCCounter.swift
//  GlobalKVC_KVO
//
//  Created by Hudihka on 21/02/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class VCTable: MainViewController {
	
	@IBOutlet weak var buttonCount: UIButton!
	@IBOutlet weak var tableView: UITableView!
	
	
	var filter: Filter?
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonCount.desing(true)
		desingTV()
    }
	
	
	static func route(_ filter: Filter) -> VCTable{
		
		let storubord = UIStoryboard(name: "Main", bundle: nil)
		let VC = storubord.instantiateViewController(withIdentifier: self.className) as! VCTable
		
		VC.filter = filter
		
		return VC
	}
	
	
	
	
    @IBAction func saveButtonAction(_ sender: Any) {
		managerFilter.dismisLocale(save: true)
		self.navigationController?.popViewController(animated: true)
    }
	

	
	
	
	
    


}

extension VCTable: UITableViewDelegate, UITableViewDataSource{
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filter?.contentMulti.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		
		let text = filter?.contentMulti[indexPath.row] ?? "-"
		cell.textLabel?.text = text
		
		cell.backgroundColor = managerFilter.isSelect(filter, str: text) ? UIColor.red : UIColor.white
		
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		let text = filter?.contentMulti[indexPath.row] ?? "-"
		managerFilter.addFiltrLocal(filter, value: text)
		tableView.reloadData()
	}
	
	

    fileprivate func desingTV(){
		
		self.tableView.delegate = self
		self.tableView.dataSource = self

    }


}


