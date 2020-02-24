//
//  VCTable.swift
//  GlobalKVC_KVO
//
//  Created by Username on 22.02.2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class VCTable: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        desingTV()

    }

}


extension VCTable: UITableViewDelegate, UITableViewDataSource{

    fileprivate func desingTV(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)


        return cell
    }


}
