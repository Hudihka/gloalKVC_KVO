//
//  CalendarView.swift
//  TC5 ЕР
//
//  Created by Username on 09.02.2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

class CalendarView: UIView {

    @IBOutlet var counteinerView: UIView!

    @IBOutlet weak var buttonAction: UIButton!

    @IBOutlet weak var collectionView: UICollectionView!




    let dataParser = DateParser.shared

    var month: [Month] = []

    var filtr: Filter?{
        didSet{
            desingDiapasone()
        }
    }

    override init (frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        settingsView()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
        settingsView()
    }

    private func xibSetup() {
        counteinerView = loadViewFromNib("CalendarView")
        counteinerView.frame = bounds
        counteinerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(counteinerView )
    }

    private func settingsView() {
        downConstreintButton.constant = heightTabBar
        constreintViewIphoneX.constant = isIPhoneXorXmax ? -20 : 20

        counteinerView.addRadius(number: 20)

        buttonAction.addRadius(number: 8)
        buttonAction.settingsAlphaButton(true)

        viewDown.addShadowTabBar()


        buttonAction.settingsAlphaButton(true)

    }

    private func desingDiapasone(){


        guard let filtr = filtr else {return}

        //задаем диапазон дат для коллекции
        dataParser.dateFrom = filtr.minValue?.dateRemoveT()
        dataParser.dateTo = filtr.maxValue?.dateRemoveT()

        //задаем смотрим есть ли уже выбранные фильтры

        dataParser.selectedDataOne = getSelectedDateFiltrManager(from: true)
        dataParser.selectedDataTwo = getSelectedDateFiltrManager(from: false)

        desingCollectionView()

    }


    private func getSelectedDateFiltrManager(from: Bool) -> Date?{
        guard let filtr = filtr else {return nil}

        let index = from ? 0 : 1

        return managerFiltr.textTFFrom(filtr, index: index)?.getDatwToString("dd.MM.yyyy")
    }



    @IBAction func cancelButton(_ sender: Any) {

        EnumNotification.rejectOrApproveTask.notific()
    }


    @IBAction func actionButton(_ sender: UIButton) {


    }



//MARK: - ПРОВЕРКА ДАТ

    func unblockButton(){

        guard let first = dataParser.selectedDataOne, let two = dataParser.selectedDataTwo else {
            buttonAction.settingsAlphaButton(true)
            return
        }


        if first != getSelectedDateFiltrManager(from: true) ||
            two != getSelectedDateFiltrManager(from: false) {

            buttonAction.settingsAlphaButton(false)
            return
        }

        buttonAction.settingsAlphaButton(true)
    }





    deinit {
        NotificationCenter.default.removeObserver(self)
    }


}
