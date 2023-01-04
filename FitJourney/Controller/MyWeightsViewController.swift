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
        //self.title = "My Weights"
        // Do any additional setup after loading the view.
        myWeightsDataSource.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myWeightsDataSource.getListofWeightEntryFromFirebase()
    }
    
    func setChartValues() {
        guard let values = myWeightsDataSource.getWeightChartEntryArray() else { return  }
        let set = LineChartDataSet(entries: values, label: "My Weights")
        set.mode = .cubicBezier
        let weightData = LineChartData(dataSet: set)
        myWeightsLineChartView.xAxis.valueFormatter = DateValueFormatter()
        self.myWeightsLineChartView.data = weightData
        self.myWeightsLineChartView.xAxis.setLabelCount(myWeightsDataSource.getNumberOfWeightChartEntry(), force: true)
        myWeightsLineChartView.xAxis.labelPosition = .bottom
        myWeightsLineChartView.xAxis.yOffset = 10.0
        self.myWeightsLineChartView.animate(xAxisDuration: Double(myWeightsDataSource.getNumberOfWeightChartEntry())*0.03)
        
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
        self.setChartValues()
    }
}
