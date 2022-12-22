//
//  NewWeightEntryViewController.swift
//  FitJourney
//
//  Created by Begum Sen on 22.12.2022.
//

import UIKit

class NewWeightEntryViewController: UIViewController {

    @IBOutlet weak var weightPickerView: UIPickerView!
    
    let newWeightEntryHelper = NewWeightEntryHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newWeightEntryHelper.createWeightArrays()
        // Do any additional setup after loading the view.
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
    
    func
}

