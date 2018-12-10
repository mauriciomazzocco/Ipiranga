//
//  TaskTableViewCell.swift
//  Ipiranga
//
//  Created by Maurício Mazzocco on 06/12/18.
//  Copyright © 2018 Totvs. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblTxt: UILabel!
    @IBOutlet weak var lblProcess: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
