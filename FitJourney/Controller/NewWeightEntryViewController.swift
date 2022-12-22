//
//  NewWeightEntryViewController.swift
//  FitJourney
//
//  Created by Begum Sen on 22.12.2022.
//

import UIKit

class NewWeightEntryViewController: UIViewController {

    @IBOutlet weak var weightPickerView: UIPickerView!
    
    @IBOutlet weak var weightDatePicker: UIDatePicker!
    
    let newWeightEntryHelper = NewWeightEntryHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newWeightEntryHelper.delegate = self
        newWeightEntryHelper.createWeightArrays()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let newDate  = weightDatePicker.date
        let newKg =  newWeightEntryHelper.getKgArray(row: weightPickerView.selectedRow(inComponent: 0))
        let newGr = newWeightEntryHelper.getGrArray(row: weightPickerView.selectedRow(inComponent: 1))
        
        newWeightEntryHelper.addNewWeightEntryToFirebase(date: newDate, kg: newKg, gr: newGr)
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

extension NewWeightEntryViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0{
            return newWeightEntryHelper.getKgArrayCount()
        }
        return newWeightEntryHelper.getGrArrayCount()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return String(newWeightEntryHelper.getKgArray(row: row))
        }
        return String(newWeightEntryHelper.getGrArray(row: row))
    }
 
}

extension NewWeightEntryViewController: NewWeightEntryDelegate {
    
    func arraysAreLoaded(){
        weightPickerView.reloadAllComponents()
    }
    
    func newEntrySuccesfullyWrittenToFirebase() {
        //pop the previous screen
        self.navigationController?.popToRootViewController(animated: true)
    }
}

