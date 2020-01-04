//
//  QuoteDetailViewController.swift
//  Quote
//
//  Created by AllSpark on 13/11/19.
//  Copyright © 2019 AllSpark. All rights reserved.
//

import UIKit

class QuoteDetailViewController: UIViewController {
    
    @IBOutlet var quoteTextView: UITextView!
    @IBOutlet var lblAuthName: UILabel!
    var strname: String?
    var strQuote: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quoteTextView.text = strQuote
        if strname != "" {
            lblAuthName.text = strname
        } else {
            lblAuthName.text = "Unknown Author"
        }
    }
}
