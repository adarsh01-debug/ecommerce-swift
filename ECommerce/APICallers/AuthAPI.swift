//
//  AuthAPI.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 26/07/22.
//

import Foundation

//protocol BrandManagerDelegate: AnyObject {
//    func updatedData(brand: [BrandModel])
//}

import Foundation

protocol checkValidation {
    func sendUserInfo(user: UserModel)
    func sendStatus(status: Bool)

}

class LoginAPI{
    
    var delegate:checkValidation?
    func postLogInData(id:String, password:String){
        let stringURL = "http://10.20.4.81:8080/user/"
        guard let url = URL(string: stringURL) else {
            print("Problem in url string")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "emailID": id,
            "password": password
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let task = URLSession.shared.dataTask(with: request) {data, _, error in
            if (error != nil){
                print("Error in session")
                return
            }

            if let safeData = data{
                print("no error")
                if let convertedData = self.parseJSON(safeData){
                    //sending the recieved data to view controller
                    self.delegate?.sendUserInfo(user: convertedData)
                    self.delegate?.sendStatus(status: true)
                }
            }
        }
        task.resume()
    }

    func parseJSON(_ productData : Data) -> UserModel? {

        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(UserModel.self, from: productData)
            return decodedData
        } catch {
            print("No user with the given id")
            self.delegate?.sendStatus(status: false)
            return nil
        }
    }
}

