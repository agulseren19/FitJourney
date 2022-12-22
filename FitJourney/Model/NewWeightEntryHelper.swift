//
//  NewWeightEntryHelper.swift
//  FitJourney
//
//  Created by Begum Sen on 22.12.2022.
//

import Foundation

class NewWeightEntryHelper {
    
    var kgArray = [Int]()
    var grArray = [Int]()
    
    
    func createWeightArrays(){
        for i in 0...200 {
            kgArray.append(i)
        }
        
        for i in 0...10 {
            grArray.append(i)
        }
    }
    
    func getKgArrayCount () -> Int {
        return kgArray.count
    }
    
    func getGrArrayCount () -> Int{
        return grArray.count
    }
   
}
