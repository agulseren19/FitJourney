//
//  WorkoutsViewController.swift
//  FitJourney
//
//  Created by Arda Aliz on 7.01.2023.
//

import UIKit

class WorkoutsViewController: UIViewController {

    @IBOutlet weak var workoutsTableView: UITableView!
    
    private var workoutDataSource = WorkoutDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        workoutDataSource.delegate = self
        print("QQ1")
        workoutDataSource.getAllListsOfWorkouts { string in
            print("Viewcontrollerda complete içindeyiz")
            print(string)
        }
        print("QQ2")
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let cell = sender as? UITableViewCell,
           let indexPath = workoutsTableView.indexPath(for: cell),
           let workoutDetailsController = segue.destination as? WorkoutDetailsViewController {
            
            workoutDetailsController.section = indexPath.section
            workoutDetailsController.row = indexPath.row
            workoutDetailsController.workoutDataSource = self.workoutDataSource
        }
    }
    
}

extension WorkoutsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // Number of muscle groups???
        print("XX1")
        return workoutDataSource.getNumberOfMuscleSections()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //return sectionTitles[section]
        print("XX2")
        return workoutDataSource.getSectionTitles()[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return sectionData[section].count
        print("XX3")
        if workoutDataSource.getAllMusclesWorkoutArray().isEmpty {
            return 0
        } else{
            return workoutDataSource.getAllMusclesWorkoutArray()[section].count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("XX4")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell") as? WorkoutsTableViewCell
        else{
            return UITableViewCell()
        }
        
        if let workout = workoutDataSource.getWorkout(section: indexPath.section, row: indexPath.row){
            cell.workoutNameLabel.text = workout.name
            cell.equipmentLabel.text = workout.equipment
            cell.difficultyLabel.text = workout.difficulty
        }
        
        return cell
    }
    
    
}

extension WorkoutsViewController: WorkoutDataDelegate {
    func workoutListLoaded() {
        print("QQ3")
        self.workoutsTableView.reloadData()
    }
    
}
