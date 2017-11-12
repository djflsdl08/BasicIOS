//
//  LapTableViewCell.swift
//  Timer
//
//  Created by 김예진 on 2017. 11. 12..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit

class LapTableViewCell: UITableViewCell {

    @IBOutlet var time: UILabel!
    @IBOutlet var lapCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
