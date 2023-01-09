//
//  WorkoutDetailsViewController.swift
//  FitJourney
//
//  Created by Arda Aliz on 9.01.2023.
//

import UIKit

class WorkoutDetailsViewController: UIViewController {

    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var difficultyNameLabel: UILabel!
    @IBOutlet weak var equipmentNameLabel: UILabel!
    @IBOutlet weak var muscleNameLabel: UILabel!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    var section: Int?
    var row: Int?
    
    var workoutDataSource: WorkoutDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //workoutDataSource.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let sectionIndex = section,
           let rowIndex = row,
           let workoutDataSource = workoutDataSource,
           let workout = workoutDataSource.getWorkout(section: sectionIndex, row: rowIndex){
            workoutNameLabel.text = workout.name
            muscleNameLabel.text = workout.muscle
            equipmentNameLabel.text = workout.equipment
            difficultyNameLabel.text = workout.difficulty
            instructionsTextView.text = workout.instructions
        }else {
            workoutNameLabel.text = "N/A"
            muscleNameLabel.text = "N/A"
            equipmentNameLabel.text = "N/A"
            difficultyNameLabel.text = "N/A"
            instructionsTextView.text = "N/A"
        }
        
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
