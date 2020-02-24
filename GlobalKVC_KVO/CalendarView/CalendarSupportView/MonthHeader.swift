//
//  MonthHeader.swift
//  Calendar
//
//  Created by Hudihka on 02/02/2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

class MonthHeader: UICollectionReusableView {
    
    @IBOutlet var collectionLabels: UILabel!
    
    var month: Month? {
        didSet{
            collectionLabels.text = nil
            if let month = month {
                collectionLabels.text = month.nameMonth
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
