//
//  NewWeightEntryDelegate.swift
//  FitJourney
//
//  Created by Begum Sen on 22.12.2022.
//

import Foundation

protocol NewWeightEntryDelegate{
    func arraysAreLoaded()
    func newEntrySuccesfullyWrittenToFirebase()
}