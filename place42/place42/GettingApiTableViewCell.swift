//
//  GettingApiTableViewCell.swift
//  place42
//
//  Created by 최강훈 on 2021/03/04.
//  Copyright © 2021 최강훈. All rights reserved.
//

import UIKit

class GettingApiTableViewCell: UITableViewCell {

    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
