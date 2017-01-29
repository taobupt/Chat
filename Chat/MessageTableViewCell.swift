//
//  MessageTableViewCell.swift
//  Chat
//
//  Created by Tao Wang on 1/29/17.
//  Copyright © 2017 Tao Wang. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var information: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
