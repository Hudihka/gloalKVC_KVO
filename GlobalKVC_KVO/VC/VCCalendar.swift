//
//  VCCalendar.swift
//  GlobalKVC_KVO
//
//  Created by Hudihka on 24/02/2020.
//  Copyright © 2020 Tatyana. All rights reserved.
//

import UIKit

class VCCalendar: UIViewController {
	
	@IBOutlet weak var buttonCount: UIButton!
	@IBOutlet weak var collectionView: UICollectionView!
	
	let dataParser = DateParser.shared
	var filter: Filter?
	
    var month: [Month] = []
	

    override func viewDidLoad() {
        super.viewDidLoad()

		buttonCount.desing(true)
       desingDiapasone()
    }
	
	
	static func route(_ filter: Filter) -> VCCalendar{
		
		let storubord = UIStoryboard(name: "Main", bundle: nil)
		let VC = storubord.instantiateViewController(withIdentifier: self.className) as! VCCalendar
		
		VC.filter = filter
		
		return VC
	}
	
	
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
		
		///убраем
    }

	
    private func desingDiapasone(){
        guard let filter = filter else {return}

        //задаем диапазон дат для коллекции
        dataParser.dateFrom = filter.minDate
        dataParser.dateTo = filter.maxDate


        desingCollectionView()

    }
    
	
    @IBAction func saveButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}


extension VCCalendar: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{

    func desingCollectionView(){

        month = DateParser.shared.arrayMonth

        self.collectionView.baseSettingsCV(obj: self,
                                           arrayNameCell: ["YearsDayCell"])


        if let section = self.month.firstIndex(where: {dataParser.monthInDayTooDay(date: $0.days)}), section != 0 {
            self.collectionView.layoutIfNeeded()

            let customSection = section - 1
            let days = month[customSection].days

            let index = IndexPath(row: days.count - 1, section: customSection)
            self.collectionView.scrollToItem(at: index, at: .top, animated: true)

            textHeder()
        } else if let date = month.first?.days.first{
            self.title = "\(date.year) г."
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



    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        textHeder()
    }

    func textHeder(){
        if let cell = self.collectionView.visibleCells.first, let indexSection = collectionView.indexPath(for: cell)?.section, let date = month[indexSection].days.first {
            self.title = "\(date.year) г."
        }
    }

}

extension VCCalendar: SelectedDateCell {
	func selectedDate(_ date: Date){
		dataParser.selectedDate(date: date)
		self.collectionView.reloadData()
	}
}
