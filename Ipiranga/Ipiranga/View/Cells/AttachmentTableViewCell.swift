//
//  AttachmentTableViewCell.swift
//  Ipiranga
//
//  Created by Maurício Mazzocco on 07/12/18.
//  Copyright © 2018 Totvs. All rights reserved.
//

import UIKit

class AttachmentTableViewCell: UITableViewCell {

    @IBOutlet weak var attachmentTitle: UILabel!
    @IBOutlet weak var imageAtt: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
