//
//  AuthAPI.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 26/07/22.
//

import Foundation

class LoginAPI{
    
    let apiURL = "http://10.20.4.157:8080/user/login/"
    var userPassword: String?
    var userEmail: String?
    
    var delegate: Response?
    
    func fecthBrandDetails(email: String, password: String) {
        userPassword = password
        userEmail = email
        let urlString = "\(apiURL)\(email)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { [weak self] (data, response, error) in
                if error != nil {
                    print("Error!")
                    return
                }
                
                if let safeData = data {
                    if let user = self?.parseJSON(safeData) {
                        if ((self?.validate(user: user.emailId, password: user.password)) != nil) {
                            self?.delegate?.sendUserInfo(user: user)
                            self?.delegate?.sendStatus(status: true)
                        } else {
                            self?.delegate?.sendStatus(status: false)
                        }
                    }
                }
            }
            task.resume()
        } else {
            print("\(urlString) is invalid")
        }
    }
    
    func parseJSON(_ brandData: Data) -> UserModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(UserModel.self, from: brandData)
            return decodeData
        } catch {
            self.delegate?.sendStatus(status: false)
            return nil
        }
    }
    
    func validate(user email: String, password: String) -> Bool {
        if email == "" || password == "" {
            return false
        }

        if let userEmail = userEmail, let userPassword = userPassword, userEmail == email, userPassword == password {
            //print(userPassword, password)
                return true
        }

        return false
    }

}

