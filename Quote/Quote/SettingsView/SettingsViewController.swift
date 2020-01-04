//
//  SettingsViewController.swift
//  Quote
//
//  Created by AllSpark on 14/11/19.
//  Copyright © 2019 AllSpark. All rights reserved.
//

import UIKit
import Firebase
class SettingsViewController: BaseViewController {
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var drawerController: KYDrawerController?
    override func viewDidLoad() {
        super.viewDidLoad()
        drawerController = appDelegate.drawerController
      setupNavBarForLeftMenuIcon(title: "Settings")
    }
    
    lazy var logInNavController: UINavigationController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsVC = storyboard.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        return UINavigationController(rootViewController: settingsVC)
    }()
    
    // MARK: HAndel Logout Here
    @IBAction func logoutButtonClicked(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
            }
            catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            drawerController?.mainViewController = logInNavController
            drawerController?.drawerState = .opened
        } else {
            self.presentAlert()
        }
        
    }
}
