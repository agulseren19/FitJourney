//
//  WorkoutDataSource.swift
//  FitJourney
//
//  Created by Arda Aliz on 8.01.2023.
//

import Foundation

class WorkoutDataSource {
    
    var mutex = 0
    private let sectionTitles = ["Chest", "Biceps", "Triceps"]
    private let muscleNamesForAPI = ["chest", "biceps", "triceps"]
    private var sectionData = [["Row 1", "Row 2"], ["Row 3", "Row 4", "Row 5"], ["Row 6"]]
    private var singleMuscleWorkoutArray: [Workout] = []
    private var allMusclesWorkoutArray: [[Workout]] = []
    
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
                    //self.singleMuscleWorkoutArray = try! decoder.decode([Workout].self, from: data)
                    //self.allMusclesWorkoutArray.append(self.singleMuscleWorkoutArray)
                    //print(self.singleMuscleWorkoutArray)
                    //self.allMusclesWorkoutArray.append(workoutArray)
                    print(workoutArray)
                    print("BB")
                    completion(workoutArray)
                    /*
                    self.mutex = self.mutex + 1
                    if self.mutex == 3 {
                        print("DD")
                        self.delegate?.workoutListLoaded()
                    }
                    */
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
                    //self.singleMuscleWorkoutArray = try! decoder.decode([Workout].self, from: data)
                    //self.allMusclesWorkoutArray.append(self.singleMuscleWorkoutArray)
                    //print(self.singleMuscleWorkoutArray)
                    //self.allMusclesWorkoutArray.append(workoutArray)
                    DispatchQueue.main.async {
                        self.delegate?.workoutDetailsLoaded(workout: workout)
                    }
                    //print("BB")
                    
                    /*
                    self.mutex = self.mutex + 1
                    if self.mutex == 3 {
                        print("DD")
                        self.delegate?.workoutListLoaded()
                    }
                    */
                }
            }
            dataTask.resume()
        }
    }
    
    func getAllListsOfWorkouts(completion: @escaping (String) -> Void){
        let dispatchGroup = DispatchGroup()
  
        for muscle in self.muscleNamesForAPI {
            print("AA \(muscle)")
            dispatchGroup.enter()
            self.getListOfWorkouts(for: muscle) { workoutArray in
                self.allMusclesWorkoutArray.append(workoutArray)
                print("LEAVE")
                dispatchGroup.leave()
            }
            print("CC \(muscle)")
            
        }
        
        print("EE")
        print(allMusclesWorkoutArray)
        
        dispatchGroup.notify(queue: .main) {
            print("NOTIFY'DAYIZ")
            print(self.allMusclesWorkoutArray)
            DispatchQueue.main.async {
                self.delegate?.workoutListLoaded()
            }
            completion("completed")
        }
    }
    
    func getNumberOfWorkouts() -> Int {
        return self.singleMuscleWorkoutArray.count
    }
    
    func getWorkout(section: Int, row: Int) -> Workout? {
        print(allMusclesWorkoutArray)
        guard section < allMusclesWorkoutArray.count else {
            return nil
        }
        guard row < allMusclesWorkoutArray[section].count else {
            return nil
        }
        return allMusclesWorkoutArray[section][row]
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
    
    func getNumberOfMuscleSections() -> Int {
        return self.muscleNamesForAPI.count
    }
}
