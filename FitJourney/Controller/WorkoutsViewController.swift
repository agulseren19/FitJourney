//
//  WorkoutsViewController.swift
//  FitJourney
//
//  Created by Arda Aliz on 7.01.2023.
//

import UIKit

class WorkoutsViewController: UIViewController, UISearchResultsUpdating {

    @IBOutlet weak var workoutsTableView: UITableView!
    
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    let searchController = UISearchController()
    
    private var workoutDataSource = WorkoutDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadingActivityIndicator.isHidden = false
        workoutsTableView.isHidden = true
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        workoutDataSource.delegate = self
        workoutDataSource.getAllListsOfWorkouts { string in
        }
        
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
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text
        else {
            return
        }
        
        self.workoutDataSource.filterDataWithSearchBar(searchText: text)
    }
    
}

extension WorkoutsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return workoutDataSource.getNumberOfMuscleSections()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return workoutDataSource.getSectionTitles()[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if workoutDataSource.getFilteredAllMusclesWorkoutArray().isEmpty {
            return 0
        } else{
            return workoutDataSource.getFilteredAllMusclesWorkoutArray()[section].count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        loadingActivityIndicator.isHidden = true
        workoutsTableView.isHidden = false
        self.workoutsTableView.reloadData()
    }
    
}
