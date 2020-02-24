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
	

    fileprivate func desingTV(){
		
		self.tableView.delegate = self
		self.tableView.dataSource = self

    }


}


