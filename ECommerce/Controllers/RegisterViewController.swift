//
//  RegisterViewController.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 26/07/22.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate, Response{
    func sendUserInfo(user: UserModel, isLoggedIn: Bool) {
    }
    
    func validate(user: String, password: String) -> Bool {
        return false
    }
    
    
    let signup = SignUpAPI()
    

    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var confirmPassword: UITextField!
    @IBOutlet var phoneNumber: UITextField!
    @IBOutlet var name: UITextField!
    @IBOutlet var registerButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        signup.delegate = self
        
        name.delegate = self
        email.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
        phoneNumber.delegate = self
        
        registerButtonOutlet.layer.masksToBounds = true
        registerButtonOutlet.layer.cornerRadius = 10.0
        
        name.becomeFirstResponder()
        password.isSecureTextEntry = true
        confirmPassword.isSecureTextEntry = true
        
        name.text = "Adarsh"
        email.text = "adarsh@email.com"
        password.text = "sm3llyc@T"
        confirmPassword.text = "sm3llyc@T"
        phoneNumber.text = "8353988322"
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if let name = name.text, let email = email.text, let password = password.text, let confirmPassword = confirmPassword.text, let phone = phoneNumber.text {
            if validate(name: name, email: email, password: password, confirmPassword: confirmPassword, phone: phone) {
                // post request to the database
                signup.postSignInData(id: email, password: password, name: name, mobileNumber: phone)
                
                // navigate back to login page
                navigationController?.popViewController(animated: true)
            } else {
                let alert = UIAlertController(title: "Alert!", message: "Fields are either empty or incorrect", preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            print("Nil values are being returned")
        }
    }
    
    func sendUserInfo(user: UserModel) {
        print("User Registered")
    }
    
    func sendStatus(status: Bool) {
        print(status)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func validate(name: String , email: String, password: String, confirmPassword: String, phone: String) -> Bool {
        if name == "" || email == "" || password == "" || confirmPassword == "" || phone == "" {
            return false
        }
        
        if isValidEmail(email), isValidPassword(password: password, confirmPassword: confirmPassword) {
            return true
        }
        
        return false
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"

        return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
    
    func isValidPassword (password: String, confirmPassword: String ) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
        
        let passwordValid = NSPredicate(format:"SELF MATCHES %@", passwordRegEx).evaluate(with: password)
        
        if passwordValid, password == confirmPassword {
            return true
        }
        
        return false
    }

}
