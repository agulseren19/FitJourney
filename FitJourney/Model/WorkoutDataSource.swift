//
//  WorkoutDataSource.swift
//  FitJourney
//
//  Created by Arda Aliz on 8.01.2023.
//

import Foundation

class WorkoutDataSource {
    
    private let sectionTitles = ["Chest", "Biceps", "Triceps"]
    private let muscleNamesForAPI = ["chest", "biceps", "triceps"]
    private var sectionData = [["Row 1", "Row 2"], ["Row 3", "Row 4", "Row 5"], ["Row 6"]]
    private var workoutArray: [Workout] = []
    
    var delegate: WorkoutDataDelegate?
    
    init() {
        
    }
    
    func getListOfWorkouts(muscleName: String) {
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
                    self.workoutArray = try! decoder.decode([Workout].self, from: data)
                    print(self.workoutArray)
                    DispatchQueue.main.async {
                        self.delegate?.workoutListLoaded()
                    }
                    
                }
            }
            dataTask.resume()
        }
        
        
        /*
        let muscle = "biceps".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/exercises?muscle="+muscle!)!
        var request = URLRequest(url: url)
        request.setValue("YOUR_API_KEY", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
        */
        
    }
    
    func getNumberOfWorkouts() -> Int {
        return workoutArray.count
    }
    
    func getWorkout(for index: Int) -> Workout? {
        guard index < workoutArray.count else {
            return nil
        }
        return workoutArray[index]
    }
    
    func getSectionTitles() -> [String] {
        return self.sectionTitles
    }
    
    func getMuscleNamesForAPI() -> [String] {
        return self.muscleNamesForAPI
    }
}
