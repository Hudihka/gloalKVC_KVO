//
//  CalendarCollection.swift
//  GlobalKVC_KVO
//
//  Created by Username on 27.02.2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import Foundation
import UIKit

protocol ReloadYeare: class {
    func textYear(_ text: String)
}

class CalendarCollection: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    fileprivate let dateParser = DateParser.shared
    fileprivate var month: [Month] = []
    fileprivate let managerFilter = ManagerFilters.shared

    weak var delegateYeare: ReloadYeare?

    var filter: Filter? {
        didSet{
            dateParser.dateFrom = filter?.minDate
            dateParser.dateTo = filter?.maxDate
            month = dateParser.arrayMonth
            scrollCollectionView()
        }
    }

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)

        backgroundColor = UIColor.clear
        delegate = self
        dataSource = self

        register(UINib(nibName: YearsDayCell.className, bundle: nil), forCellWithReuseIdentifier: YearsDayCell.className)

        register(UINib(nibName: MonthHeader.className, bundle: nil),
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: MonthHeader.className)

        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        layout.headerReferenceSize = CGSize(width: self.frame.size.width, height: 50)

        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func scrollCollectionView(){

        if let section = self.month.firstIndex(where: {DateParser.shared.monthInDayTooDay(date: $0.days)}), section != 0 {
            self.layoutIfNeeded()

            let customSection = section - 1
            let days = month[customSection].days

            let index = IndexPath(row: days.count - 1, section: customSection)
            self.scrollToItem(at: index, at: .top, animated: true)

            textHeder()
        }else if let date = month.first?.days.first{
            self.delegateYeare?.textYear("\(date.year) г.")
        }

        self.reloadData()

    }


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return month.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let mon = month[section]
        return mon.days.count + mon.offset
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YearsDayCell", for: indexPath) as! YearsDayCell

        let ind = indexPath.row
        let mon = month[indexPath.section]
        let offset = mon.offset

        if offset != 0, ind < offset {
            cell.day = nil
            return cell
        }

        cell.day = mon.days[ind - offset]
        cell.delegate = self

        return cell
    }

    //  size

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let widthDay = (self.frame.width / 7)

        return CGSize(width: widthDay, height: widthDay)
    }



    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        textHeder()
    }

    func textHeder(){
        if let cell = self.visibleCells.first, let indexSection = self.indexPath(for: cell)?.section, let date = month[indexSection].days.first {
            self.delegateYeare?.textYear("\(date.year) г.")
        }
    }

    //MARK: - Header

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MonthHeader", for: indexPath) as! MonthHeader
        view.month = month[indexPath.section]
        return view

    }
}

extension CalendarCollection: SelectedDateCell {
    func selectedDate(_ date: Date){

        dateParser.selectedDate(date: date)

        if let dateOne = dateParser.selectedDataOne, let dateTwo = dateParser.selectedDataTwo {
            managerFilter.addFiltrLocal(filter, value: dateOne)
            managerFilter.addFiltrLocal(filter, value: dateTwo)
        } else {
            managerFilter.deleteOne(filter)
        }

        self.reloadData()
    }
}
