//
//  DataViewCell.swift
//  fetchTableView
//
//  Created by Neeraj on 25/09/19.
//  Copyright © 2019 Neeraj Soni. All rights reserved.
//

import UIKit

class DataViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        title.text = ""
        date.text = ""
    }
    
}
