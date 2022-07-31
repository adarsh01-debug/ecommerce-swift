//
//  ProfileViewController.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 28/07/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var name: String?
    var email: String?
    var phoneNumber: String?
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.font = UIFont.italicSystemFont(ofSize: 16.0)
        
        emailLabel.font = UIFont.italicSystemFont(ofSize: 16.0)

        phoneLabel.font = UIFont.italicSystemFont(ofSize: 16.0)

        updateLabels()
    }
    
    func updateLabels() {
        if let name = name {
            nameLabel.text = name
        } else {
            nameLabel.text = "No Name Given"
        }
        
        if let email = email {
            emailLabel.text = email
        } else {
            emailLabel.text = "No Email Given"
        }

        if let phone = phoneNumber {
            phoneLabel.text = phone
        } else {
            phoneLabel.text = "No Number Given"
        }

    }

}
