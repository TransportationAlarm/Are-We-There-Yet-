//
//  HistoryTableViewCell.swift
//  BuzMe
//
//  Created by Anita on 3/31/16.
//  Copyright © 2016 BuzMe-codepath. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        startLabel.preferredMaxLayoutWidth = startLabel.frame.size.width
        distanceLabel.preferredMaxLayoutWidth = distanceLabel.frame.size.width
        destinationLabel.preferredMaxLayoutWidth = destinationLabel.frame.size.width
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
