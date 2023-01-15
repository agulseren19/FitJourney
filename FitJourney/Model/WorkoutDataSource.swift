//
//  WorkoutDataSource.swift
//  FitJourney
//
//  Created by Arda Aliz on 8.01.2023.
//

import Foundation

class WorkoutDataSource {
    
    private let sectionTitles = ["Chest", "Biceps", "Triceps", "Middle Back", "Lower Back"]
    private let muscleNamesForAPI = ["chest", "biceps", "triceps", "middle_back", "lower_back"]
    
    private var singleMuscleWorkoutArray: [Workout] = []
    private var allMusclesWorkoutArray: [[Workout]] = [ [], [], [], [], [] ]
    private var filteredAllMusclesWorkoutArray: [[Workout]] = [ [], [], [], [], [] ]
    
    var delegate: WorkoutDataDelegate?
    
    init() {
        
    }
    
    func getListOfWorkouts(for muscleName: String, completion: @escaping ([Workout]) -> Void) {
        let session = URLSession.shared
        let muscle = "\(muscleName)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let url = URL(string: "https://api.api-ninjas.com/v1/exercises?muscle="+muscle!) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("8ZhKD6CGxE5oiY9JaXuzJQ==E1hegZPhxnJckxia", forHTTPHeaderField: "X-Api-Key")
            let dataTask = session.dataTask(with: request) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    print(data)
                    let workoutArray: [Workout] = try! decoder.decode([Workout].self, from: data)
                    completion(workoutArray)
                }
            }
            dataTask.resume()
        }
    }
    
    func getWorkoutDetail(with name: String) {
        let session = URLSession.shared
        let nameForURL = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let url = URL(string: "https://api.api-ninjas.com/v1/exercises?name="+nameForURL!) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("8ZhKD6CGxE5oiY9JaXuzJQ==E1hegZPhxnJckxia", forHTTPHeaderField: "X-Api-Key")
            let dataTask = session.dataTask(with: request) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    print("buraya bak")
                    print(data)
                    let workout: Workout = try! decoder.decode(Workout.self, from: data)
                    DispatchQueue.main.async {
                        self.delegate?.workoutDetailsLoaded(workout: workout)
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    func getAllListsOfWorkouts(completion: @escaping (String) -> Void){
        let dispatchGroup = DispatchGroup()
  
        for muscle in self.muscleNamesForAPI {
            
            dispatchGroup.enter()
            self.getListOfWorkouts(for: muscle) { workoutArray in
                if let muscleIndex = self.muscleNamesForAPI.firstIndex(of: muscle){
                    self.allMusclesWorkoutArray[muscleIndex] = workoutArray
                    self.filteredAllMusclesWorkoutArray[muscleIndex] = workoutArray
                    
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            DispatchQueue.main.async {
                self.delegate?.workoutListLoaded()
            }
            completion("completed")
        }
    }
    
    func filterDataWithSearchBar(searchText: String) {
        filteredAllMusclesWorkoutArray = [ [], [], [], [], [] ]
        if searchText == "" {
            filteredAllMusclesWorkoutArray = allMusclesWorkoutArray
        } else {
            for index in 0...(allMusclesWorkoutArray.count-1){
                
                for workout in allMusclesWorkoutArray[index]{
                    if workout.name.lowercased().contains(searchText.lowercased()){
                        filteredAllMusclesWorkoutArray[index].append(workout)
                    }
                }
            }
        }
        DispatchQueue.main.async {
            self.delegate?.workoutListLoaded()
        }
    }
    
    func getNumberOfWorkouts() -> Int {
        return self.singleMuscleWorkoutArray.count
    }
    
    func getWorkout(section: Int, row: Int) -> Workout? {
        guard section < filteredAllMusclesWorkoutArray.count else {
            return nil
        }
        guard row < filteredAllMusclesWorkoutArray[section].count else {
            return nil
        }
        return filteredAllMusclesWorkoutArray[section][row]
    }
 
    func getSectionTitles() -> [String] {
        return self.sectionTitles
    }
    
    func getMuscleNamesForAPI() -> [String] {
        return self.muscleNamesForAPI
    }
    
    func getAllMusclesWorkoutArray() -> [[Workout]] {
        return self.allMusclesWorkoutArray
    }
    
    func getFilteredAllMusclesWorkoutArray() -> [[Workout]] {
        return self.filteredAllMusclesWorkoutArray
    }
    
    func getNumberOfMuscleSections() -> Int {
        return self.muscleNamesForAPI.count
    }
}
