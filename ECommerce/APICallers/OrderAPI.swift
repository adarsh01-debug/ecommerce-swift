//
//  OrderAPI.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 02/08/22.
//

import Foundation

class OrderAPI {
    
    var delegate: Response?
    func postOrderData(userId: Int, productId: [Int], quantity: [Int], merchantId: [Int], cartId: [Int], email: String){
        let stringURL = "http://10.20.4.110:9094/order/"
        guard let url = URL(string: stringURL) else {
            print("Problem in url string")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "userId": userId,
            "productId": productId,
            "quantity": quantity,
            "merchantId": merchantId,
            "cartId": cartId,
            "emailId": email
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let task = URLSession.shared.dataTask(with: request) {data, _, error in
            if (error != nil) {
                print("Error in session")
                return
            }

            if let safeData = data {
                if let convertedData = self.parseJSON(safeData) {
                    //sending the recieved data to view controller
                    self.delegate?.sendUserInfo(user: convertedData)
                    self.delegate?.sendStatus(status: true)
                }
            }
        }
        task.resume()
    }

    func parseJSON(_ userData : Data) -> UserModel? {

        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(UserModel.self, from: userData)
            return decodedData
        } catch {
            print(error.localizedDescription)
            self.delegate?.sendStatus(status: false)
            return nil
        }
    }
}
