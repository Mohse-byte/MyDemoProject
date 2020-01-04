//
//  QouteHomeTableViewCell.swift
//  Quote
//
//  Created by AllSpark on 13/11/19.
//  Copyright © 2019 AllSpark. All rights reserved.
//

import UIKit

class QouteHomeTableViewCell: UITableViewCell {

    @IBOutlet var lblShortDiscriptionOfQuote: UILabel!
    @IBOutlet var lblAuthorName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
