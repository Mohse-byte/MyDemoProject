//
//  SideMenuCell.swift
//  cricket
//
//  Created by Brahmastra on 04/05/19.
//  Copyright © 2019 Brahmastra. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {

    @IBOutlet weak var imageViewWidthConst: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var lbl_sideMenu: UILabel!
    @IBOutlet weak var image_sideMenu: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
            imageViewHeightConst.constant = 24
            imageViewWidthConst.constant = 24
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
