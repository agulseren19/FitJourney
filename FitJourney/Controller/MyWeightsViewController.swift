//
//  MyWeightsViewController.swift
//  FitJourney
//
//  Created by Begum Sen on 22.12.2022.
//
import Charts
import UIKit

class MyWeightsViewController: UIViewController {

   
    @IBOutlet weak var myWeightsLineChartView: LineChartView!
    @IBOutlet weak var myWeightsTableView: UITableView!
    let myWeightsDataSource = MyWeightsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myWeightsDataSource.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myWeightsDataSource.getListofWeightEntryFromFirebase()
    }
    
    func setChartValues() {
        let values =
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

extension MyWeightsViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myWeightsDataSource.getNumberOfWeightEntry()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeightEntryCell") as? WeightEntryTableViewCell
        else  {
            return UITableViewCell()
        }
        
        if let weightEntry = myWeightsDataSource.getWeightEntry(for: indexPath.row) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/YY"
            cell.dateLabel.text = dateFormatter.string(from: weightEntry.date)
            cell.weightLabel.text = "\(weightEntry.weight)"
        } else {
            cell.dateLabel.text = "N/A"
            cell.weightLabel.text = "N/A"
        }
        
        return cell
    }
}

extension MyWeightsViewController: MyWeightsDataDelegate {
    func weightEntryListLoaded() {
        myWeightsTableView.reloadData()
    }
}
