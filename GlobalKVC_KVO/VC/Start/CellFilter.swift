//
//  CellFilter.swift
//  GlobalKVC_KVO
//
//  Created by Username on 22.02.2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit



class CellFilter: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
	@IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var buttonClear: UIButton!


    var filter: Filter? {
        didSet{
            desingTV()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
		labelDescription.text = nil
    }


    private func desingTV(){
        guard let filter = self.filter else {return}

		labelTitle.text = filter.name
		labelDescription.text = ManagerFilters.shared.textCell(filter)

    }
    
}
