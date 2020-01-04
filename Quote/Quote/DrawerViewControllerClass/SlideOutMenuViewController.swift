//
//  SlideOutMenuViewController.swift
//  cricket
//
//  Created by Brahmastra on 15/05/19.
//  Copyright © 2019 Brahmastra. All rights reserved.
//

import UIKit

class SlideOutMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var welcomeTopView: UIView!
    @IBOutlet weak var tableviewSideMenus: UITableView!
    
    var drawerController: KYDrawerController?
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
  
    
    
    lazy var settingNavController: UINavigationController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsVC = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        return UINavigationController(rootViewController: settingsVC)
    }()
   
    lazy var logInNavController: UINavigationController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsVC = storyboard.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        return UINavigationController(rootViewController: settingsVC)
    }()
    
    lazy var signUpNavController: UINavigationController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        return UINavigationController(rootViewController: settingsVC)
    }()

//    lazy var settingNavController: UINavigationController = {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let settingsVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! se
//        return UINavigationController(rootViewController: settingsVC)
//    }()
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        drawerController = appDelegate.drawerController
         tbl_view_sideMenu.reloadData()
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = UIColor.white //UIColor(red: 61/255.0, green: 85/255.0, blue: 145/255.0, alpha: 0.6)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 16)!]
        
    }
    @IBOutlet weak var tbl_view_sideMenu: UITableView!
    @IBOutlet weak var lbl_welcome: UILabel!
   
    
    
    var image_array = [#imageLiteral(resourceName: "Home"),#imageLiteral(resourceName: "Setting")]
    var array : Array = ["Log In","Sign Up","Settings"]
    
    // MARK: - Table View Delegate And DataSources
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
      
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SideMenuCell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell") as! SideMenuCell
        cell.lbl_sideMenu.text = self.array[indexPath.row]
    //    cell.image_sideMenu.image = self.image_array[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       selectedMenuIndex(index: indexPath.row)
       drawerController?.setDrawerState(.closed, animated: true)
    }
    
    
    func selectedMenuIndex(index: Int)
    {
        switch index {
        case 0:
            drawerController?.mainViewController = logInNavController
            if let vc = logInNavController.viewControllers.first as? LogInViewController {
            }
        case 1:
            drawerController?.mainViewController = signUpNavController
        case 2:
           drawerController?.mainViewController = settingNavController
        default:
            print("default")
        }
        
    }
}

