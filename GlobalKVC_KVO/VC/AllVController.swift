//
//  AllVController.swift
//  GlobalKVC_KVO
//
//  Created by Username on 27.02.2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class AllVController: UIViewController, BBItemReload {


    @IBOutlet weak var labelCount: UILabel!
    let manager = ManagerFilters.shared

    override func viewDidLoad() {
        super.viewDidLoad()
textLabel()
        manager.delegateBBItem = self
    }


    private func textLabel(){
        self.labelCount.text = "Выбранно фильтров \(manager.countSelectFilter)"
    }


    func reloadBBItem() {
        textLabel()
    }
}
