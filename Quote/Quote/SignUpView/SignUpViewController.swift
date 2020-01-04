//
//  SignUpViewController.swift
//  Quote
//
//  Created by AllSpark on 14/11/19.
//  Copyright © 2019 AllSpark. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: BaseViewController,UITextFieldDelegate {
    // MARK: IBOutlets and Variables
    @IBOutlet var baseScrollView: UIScrollView!
    @IBOutlet var signUpBaseView: DesignableView!
    @IBOutlet var confirmPassswordTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var signUpViewHeightConstant: NSLayoutConstraint!
    @IBOutlet var signUpViewBottomConstant: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseScrollView.scrollsToTop = true
        self.adjustViewAccordingToUIDevice()
        setupNavBarForLeftMenuIcon(title: "Sign up")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: (.now() + .milliseconds(500))) {
            self.baseScrollView.flashScrollIndicators()
        }
        
    }
    
    @IBAction func signUpButtonCliked(_ sender: Any) {
        if passwordTextField.text != confirmPassswordTextField.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!){ (user, error) in
                if error == nil {
                    let quoteHomeViewController = self.storyboard?.instantiateViewController(withIdentifier: "QuotesHomeViewController") as? QuotesHomeViewController
                    quoteHomeViewController?.hasSuccesfullLoginOrSignUp = true
                    self.navigationController?.pushViewController(quoteHomeViewController!, animated: true)
                }
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    func adjustViewAccordingToUIDevice() {
        if UIDevice.iPhoneX {
            signUpViewBottomConstant.constant = 315
            signUpViewHeightConstant.constant = 315
        } else {
            signUpViewBottomConstant.constant = 215
            signUpViewHeightConstant.constant = 215
        }
    }
    
    //MARK: UITextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
