//
//  ViewController.swift
//  Quote
//
//  Created by AllSpark on 13/11/19.
//  Copyright © 2019 AllSpark. All rights reserved.
//

import UIKit

class QuotesHomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    // MARK: ViewOutlets & Objects
    @IBOutlet var quotesTableView: UITableView!
    var resultArray = [Results]()
    var hasSuccesfullLoginOrSignUp: Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
     //  navigationItem.hidesBackButton = true
        self.getQuotesFromJSON()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: Get Quotes from the JOSN
    func getQuotesFromJSON() {
        let urlPath = "https://quote-garden.herokuapp.com/quotes/all"
        let url = NSURL(string: urlPath)
        let session = URLSession.shared
        let task = session.dataTask(with: url! as URL) { data, response, error in
            print("Task completed")
            
            guard data != nil && error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
            do {
                let response = try JSONDecoder().decode(Json4Swift_Base.self, from: data!)
                self.resultArray = response.results!
                DispatchQueue.main.async {
                     self.quotesTableView.reloadData()
                }
            } catch let parseError as NSError {
                print("JSON Error \(parseError.localizedDescription)")
            }
        }
        task.resume()
    }
    
    // MARK: UITableView Delegate And Datasource
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QouteHomeTableViewCell", for: indexPath)
        if let bigCardMenuCell = cell as? QouteHomeTableViewCell {
            let menuInfo = resultArray[indexPath.row]
            if menuInfo.quoteAuthor != "" {
                bigCardMenuCell.lblAuthorName.text = menuInfo.quoteAuthor
            } else {
               bigCardMenuCell.lblAuthorName.text = "Unknown Author"
            }
            bigCardMenuCell.lblShortDiscriptionOfQuote.text = menuInfo.quoteText
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let quoteDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "QuoteDetailViewController") as! QuoteDetailViewController
       // let menuInfo = resultArray[indexPath.row]
       // quoteDetailViewController.lblAuthName.text = menuInfo.quoteAuthor
        quoteDetailViewController.strname = resultArray[indexPath.row].quoteAuthor
        quoteDetailViewController.strQuote = resultArray[indexPath.row].quoteText
       // quoteDetailViewController.quoteTextView.text = menuInfo.quoteText
        
        self.navigationController?.pushViewController(quoteDetailViewController, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

