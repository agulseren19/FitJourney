//
//  Workout.swift
//  FitJourney
//
//  Created by Arda Aliz on 7.01.2023.
//

import Foundation

struct Workout: Decodable {
    let name: String
    let muscle: String
    let equipment: String
    let difficulty: String
}
