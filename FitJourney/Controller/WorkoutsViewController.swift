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
        workoutDataSource.getListOfWorkouts(muscleName: workoutDataSource.getMuscleNamesForAPI()[0])
        workoutDataSource.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WorkoutsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // Number of muscle groups???
        return 1
    }
    /*
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //return sectionTitles[section]
        return workoutDataSource.getSectionTitles()[section]
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return sectionData[section].count
        return workoutDataSource.getNumberOfWorkouts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell") as? WorkoutsTableViewCell
        else{
            return UITableViewCell()
        }
        
        if let workout = workoutDataSource.getWorkout(for: indexPath.row){
            cell.workoutNameLabel.text = workout.name
            cell.equipmentLabel.text = workout.equipment
            cell.difficultyLabel.text = workout.difficulty
        }
        
        return cell
    }
    
    
}

extension WorkoutsViewController: WorkoutDataDelegate {
    func workoutListLoaded() {
        self.workoutsTableView.reloadData()
    }
    
}
