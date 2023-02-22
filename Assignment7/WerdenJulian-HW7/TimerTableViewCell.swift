// Project: WeardenJulian-HW7
// EID: jfw864
// Course: CS329E
//
//  TimerTableViewCell.swift
//  WerdenJulian-HW7
//
//  Created by Julian Wearden on 10/31/22.
//

import UIKit

class TimerTableViewCell: UITableViewCell {

    //Make labels a part of the Cell
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
