//
//  VCCounter.swift
//  GlobalKVC_KVO
//
//  Created by Hudihka on 21/02/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class VCTable: UIViewController {
	
	@IBOutlet weak var buttonCount: UIButton!
	@IBOutlet weak var tableView: UITableView!
	
	
	var filter: Filter?
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonCount.desing(true)
		desingTV()
    }
	
	
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
		
		///убраем
    }
	
	static func route(_ filter: Filter) -> VCTable{
		
		let storubord = UIStoryboard(name: "Main", bundle: nil)
		let VC = storubord.instantiateViewController(identifier: self.className) as! VCTable
		
		VC.filter = filter
		
		return VC
	}
	
	
	
	
    @IBAction func saveButtonAction(_ sender: Any) {
		self.navigationController?.popViewController(animated: true)
    }
	

	
	
	
	
    


}

extension VCTable: UITableViewDelegate, UITableViewDataSource{
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filter?.contentMulti.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = filter?.contentMulti[indexPath.row] ?? "-"
		
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
	}
	

    fileprivate func desingTV(){
		
		self.tableView.delegate = self
		self.tableView.dataSource = self

    }


}


