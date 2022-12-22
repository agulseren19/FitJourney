//
//  DateValueFormatter.swift
//  FitJourney
//
//  Created by Begum Sen on 22.12.2022.
//
import Charts
import Foundation


class DateValueFormatter: NSObject, AxisValueFormatter {

    var dateFormatter: DateFormatter!

    override init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
    }

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}
