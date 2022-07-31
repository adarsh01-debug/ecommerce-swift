//
//  ViewController.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 26/07/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, Response {

    let loginAPI = LoginAPI()
    var loggedInUser: UserModel?
    var isVerified: Bool?
    var check: Bool?
    var status: Bool?
    
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var loginButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        username.delegate = self
        password.delegate = self
        
        username.becomeFirstResponder()
        password.isSecureTextEntry = true
        
        loginButtonOutlet.layer.masksToBounds = true
        loginButtonOutlet.layer.cornerRadius = 10.0
        
        loginAPI.delegate = self
        
        username.text = "adarsh@gmail.com"
        password.text = "sm3llyc@T"
    }
    
    
    func sendUserInfo(user: UserModel) {
        DispatchQueue.main.async {
            self.loggedInUser = user
        }
    }
    
    func sendStatus(status: Bool) {
        DispatchQueue.main.async {
            if status, let productViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ProductViewController") as? ProductViewController {
                
                productViewController.email = self.loggedInUser?.emailId
                productViewController.name = self.loggedInUser?.name
                productViewController.phoneNumber = self.loggedInUser?.mobileNumber
                self.navigationController?.pushViewController(productViewController, animated: true)
            } else {
                let alert = UIAlertController(title: "Alert!", message: "Email or Password you entered is incorrect", preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if let user = username.text, let password = password.text {
            loginAPI.fecthBrandDetails(email: user, password: password)
        } else {
            print("Either username or password is nil")
        }
    }
    
    
    @IBAction func registerHere(_ sender: Any) {
        if let registerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "RegisterViewController") as? RegisterViewController {
            navigationController?.pushViewController(registerViewController, animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

