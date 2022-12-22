//
//  MyWeightsDataSource.swift
//  FitJourney
//
//  Created by Begum Sen on 22.12.2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import Charts

class MyWeightsDataSource {
    private var weightEntryArray: [WeightEntry] = []
    private var weightChartEntryArray: [ChartDataEntry] = []
    var delegate: MyWeightsDataDelegate?
    
    init() {
    }
    
    func getListofWeightEntryFromFirebase(){
        self.weightEntryArray.removeAll()
        var mutex = 0
        for i in 0..<User.sharedInstance.getWeightsArrayCount() {
            var weightEntryId = User.sharedInstance.getWeightsArray()[i]
            let db = Firestore.firestore()
            let docRef2 = db.collection("weights").document(weightEntryId)
            docRef2.getDocument { (document, error) in
                if let document = document, document.exists {
                    var newWeightEntry = WeightEntry (
                        date: (document.get("date") as! Timestamp).dateValue(),
                        weight: document.get("weight") as! Double
                    )
                    var newChartDataEntry = ChartDataEntry(
                        x: Double(i),
                        y: document.get("weight") as! Double
                    )
                    self.weightEntryArray.append(newWeightEntry)
                    self.weightChartEntryArray.append(newChartDataEntry)
                    mutex = mutex + 1
                    if (mutex == User.sharedInstance.getWeightsArrayCount()){
                        self.weightEntryArray = self.weightEntryArray.sorted(by: { $0.date < $1.date })
                        DispatchQueue.main.async {
                            self.delegate?.weightEntryListLoaded()
                        }
                    }
                    else {
                        print("Document does not exist in my Ride")
                    }
                    
                }
            }
        }
    }
    
    func getNumberOfWeightEntry() -> Int {
        return weightEntryArray.count
    }
    
    func getWeightEntry(for index: Int) -> WeightEntry? {
        guard index < weightEntryArray.count else {
            return nil
        }
        return weightEntryArray[index]
    }
    
}
