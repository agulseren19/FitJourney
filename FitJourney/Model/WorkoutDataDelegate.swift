//
//  WorkoutDataDelegate.swift
//  FitJourney
//
//  Created by Arda Aliz on 8.01.2023.
//

import Foundation

protocol WorkoutDataDelegate{
    func workoutListLoaded()
    func workoutDetailsLoaded(workout: Workout)
}

extension WorkoutDataDelegate {
    func workoutListLoaded(){}
    func workoutDetailsLoaded(workout: Workout){}
    
}
