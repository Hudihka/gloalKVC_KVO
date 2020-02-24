//
//  UITableView.swift
//  GinzaGO
//
//  Created by Username on 20.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//


import UIKit

typealias TuplCellIndex = (isFirst: Bool, isLast: Bool)

extension UITableView {
    func isLastCell(index: IndexPath) -> Bool {
        let lastSectionIndex = self.numberOfSections - 1
        let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1

        return index == IndexPath(row: lastRowIndex, section: lastSectionIndex)
    }

    func addTableHeaderViewLine() {
        self.tableHeaderView = {
            let line = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 1))
//            line.backgroundColor = separator
            return line
        }()
    }

    func addTableFooterViewLine() {
        self.tableFooterView = {
            let line = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 1))
//            line.backgroundColor = separator
            return line
        }()
    }


    func baseSettingsTV(obj: UITableViewDelegate & UITableViewDataSource,
                        scrollEnabled: Bool = true,
                        clicableCell: Bool = true,
                        separatorStyle: UITableViewCell.SeparatorStyle? = .none,
                        minHeghtCell: CGFloat?,
                        arrayNameCell: [String]?){

        self.delegate = obj
        self.dataSource = obj
        self.backgroundColor = UIColor.clear
        self.isScrollEnabled = scrollEnabled

        if !clicableCell{
            self.allowsSelection = false
        }

        if let separatorStyle = separatorStyle {
            self.separatorStyle = separatorStyle
        }

        if let heghtCell = minHeghtCell {
            self.estimatedRowHeight = heghtCell
            self.rowHeight = UITableView.automaticDimension
        }

        arrayNameCell?.forEach({ (cellName) in
            self.registerCell(cellName: cellName)
        })


    }


    func registerCell(cellName: String){
        self.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
    }

}

extension UITableViewCell {

    func selectColor(){
        let view = UIView()
//        view.backgroundColor = colorBacground
        self.selectedBackgroundView = view
    }

    func desingSeparator(isLast: Bool, offset: CGFloat = 18) {
        if !isLast{
            self.addSeparator(offset, isDown: true)
        }
    }

}
