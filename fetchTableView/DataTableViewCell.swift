//
//  DataTableViewCell.swift
//  fetchTableView
//
//  Created by Neerajon 25/09/19.
//  Copyright © 2019 Neeraj Soni. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    @IBOutlet weak var postTitleCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
     
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
