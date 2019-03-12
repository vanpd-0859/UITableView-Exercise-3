//
//  receivingMessageCell.swift
//  UITableView-02
//
//  Created by Phan Dinh Van on 3/12/19.
//  Copyright © 2019 Phan Dinh Van. All rights reserved.
//

import UIKit

class receivingMessageCell: UITableViewCell {

    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var viewMessage: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewMessage.layer.cornerRadius = 10
        viewMessage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
