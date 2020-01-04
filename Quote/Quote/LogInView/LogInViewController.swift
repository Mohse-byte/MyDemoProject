

//
//  LogInViewController.swift
//  Quote
//
//  Created by AllSpark on 14/11/19.
//  Copyright © 2019 AllSpark. All rights reserved.
//

import UIKit
import Firebase
class LogInViewController: BaseViewController,UITextFieldDelegate {
    
    // MARK: IBOutlets and veriables
    var viewY = CGFloat()
    @IBOutlet var loginBaseView: UIView!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var loginHeightConstant: NSLayoutConstraint!
    @IBOutlet var showPasswordButton: UIButton!
    @IBOutlet var loginViewBottomConstant: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewY = self.loginBaseView.frame.origin.y
        self.adjustViewAccodingToDevice()
        self.changeLoginAndBaseViewUI()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        let swipeDown = UISwipeGestureRecognizer(target: self.view , action : #selector(UIView.endEditing(_:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        view.backgroundColor = UIColor.white
        setupNavBarForLeftMenuIcon(title: "Login")
    }
    
    
    
    // MARK: Set up login button And Base View UI
    func changeLoginAndBaseViewUI() {
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        loginButton.layer.borderWidth = 0.5
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginBaseView.layer.cornerRadius = 15
        loginBaseView.layer.borderWidth = 0.5
        loginBaseView.layer.borderColor = UIColor.black.cgColor
    }
    
    
    
    //  MARK : HANDEL LOGIN ACTION
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error == nil{
                let quoteHomeViewController = self.storyboard?.instantiateViewController(withIdentifier: "QuotesHomeViewController") as? QuotesHomeViewController
                quoteHomeViewController?.hasSuccesfullLoginOrSignUp = true
                self.navigationController?.pushViewController(quoteHomeViewController!, animated: true)
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: AdjustViewAccording to Device
    func adjustViewAccodingToDevice() {
        if UIDevice.iPhoneX {
            loginViewBottomConstant.constant = 195
            loginHeightConstant.constant = 260
        } else {
            loginViewBottomConstant.constant = 125
            loginHeightConstant.constant = 230
        }
    }
    
    // MARK: ShowPassword action
    var iconClick = false
    @IBAction func showPasswordAction(_ sender: Any) {
        if(iconClick == true) {
            passwordTextField.isSecureTextEntry = false
        } else {
            passwordTextField.isSecureTextEntry = true
        }
        iconClick = !iconClick
    }
    // MARK: Adjust View when keyboard is opened
    @objc func keyboardNotification(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            if let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
                if let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue{
                    let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
                    let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
                    let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
                    
                    if (endFrame.origin.y) >= UIScreen.main.bounds.size.height {
                        
                        self.adjustViewAccodingToDevice()
                    } else {
                        self.loginViewBottomConstant?.constant = endFrame.size.height
                    }
                    
                    UIView.animate(withDuration: duration,
                                   delay: TimeInterval(0),
                                   options: animationCurve,
                                   animations: { self.view.layoutIfNeeded() },
                                   completion: nil)
                }
            }
        }
    }
    
}
