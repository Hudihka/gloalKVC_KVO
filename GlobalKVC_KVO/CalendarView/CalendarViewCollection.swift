//
//  CalendarViewCollection.swift
//  TC5 ЕР
//
//  Created by Username on 09.02.2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import Foundation
import UIKit


extension CalendarView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{

    func desingCollectionView(){

        month = DateParser.shared.arrayMonth

        self.collectionView.baseSettingsCV(obj: self,
                                           arrayNameCell: ["YearsDayCell"],
                                           arrayNameHeders: ["MonthHeader"])


        if let section = self.month.firstIndex(where: {dataParser.monthInDayTooDay(date: $0.days)}), section != 0 {
            self.collectionView.layoutIfNeeded()

            let customSection = section - 1
            let days = month[customSection].days

            let index = IndexPath(row: days.count - 1, section: customSection)
            self.collectionView.scrollToItem(at: index, at: .top, animated: true)
            self.shadowView.layer.shadowOpacity = 0

            textHeder()
        } else if let date = month.first?.days.first{
            self.title.text = "\(date.year) г."
        }

        collectionView.reloadData()

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

//    //    size
//
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let widthDay = (collectionView.frame.width / 7)

        return CGSize(width: widthDay, height: widthDay)
    }


    //MARK: - Header

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MonthHeader", for: indexPath) as! MonthHeader
        view.month = month[indexPath.section]
        return view

    }


    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        textHeder()

        if !month.isEmpty {
            scrollView.addShadow(view: self.shadowView)
        }
    }

    func textHeder(){
        if let cell = self.collectionView.visibleCells.first, let indexSection = collectionView.indexPath(for: cell)?.section, let date = month[indexSection].days.first {
            self.title.text = "\(date.year) г."
        }
    }

}

extension CalendarView: SelectedDateCell {
    func selectedDate(_ date: Date){
                dataParser.selectedDate(date: date)
                unblockButton()
                self.collectionView.reloadData()

        
    }
}
