//
//  WeightEntryTableViewCell.swift
//  FitJourney
//
//  Created by Begum Sen on 22.12.2022.
//

import UIKit

class WeightEntryTableViewCell: UITableViewCell {

   
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
