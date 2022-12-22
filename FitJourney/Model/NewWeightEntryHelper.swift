//
//  NewWeightEntryHelper.swift
//  FitJourney
//
//  Created by Begum Sen on 22.12.2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class NewWeightEntryHelper {
    
    var kgArray = [Int]()
    var grArray = [Int]()
    var delegate: NewWeightEntryDelegate?
    
    init() {
    }
    
    func createWeightArrays(){
        for i in 0...200 {
            kgArray.append(i)
        }
        
        for i in 0...9 {
            grArray.append(i)
        }
        
        DispatchQueue.main.async {
            self.delegate?.arraysAreLoaded()
        }
    }
    
    func addNewWeightEntryToFirebase (date: Date, kg: Int, gr: Int){
        
        let newWeight: Double = Double(kg) + (Double(gr)*0.1)
        let db = Firestore.firestore()
        let id = db.collection("weights").document().documentID;
        db.collection("weights").document(id).setData([
            "date": date,
            "weight": newWeight ])
        { err in
            if let err = err {
                print("Error writing new weight entry: \(err)")
            } else {
                print("New weight entry successfully written!")
            }
        }
        
        let docRef = db.collection("users").document(User.sharedInstance.getEmail())
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                docRef.updateData([
                    "weights": FieldValue.arrayUnion([id])
                ])
                User.sharedInstance.appendToWeightsArray(id: id)
                DispatchQueue.main.async {
                    self.delegate?.newEntrySuccesfullyWrittenToFirebase()
                }
            }
            else {
                print("Document does not exist")
            }
        }
    }
    
    func getKgArrayCount () -> Int {
        return kgArray.count
    }
    
    func getGrArrayCount () -> Int{
        return grArray.count
    }
    
    func getKgArray(row: Int) -> Int {
        if kgArray.count == 0 {
            return 0
        }
        return kgArray[row]
    }
    
    func getGrArray(row: Int) -> Int {
        if grArray.count == 0 {
            return 0
        }
        return grArray[row]
    }
   
}
