//
//  CartAPI.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 01/08/22.
//

import Foundation

class CartAPI{
    
    let apiURL = "http://10.20.4.110:9090/cart/user/"
    
    var delegate: CartManagerDelegate?
    
    func fecthCartDetails(userId: Int) {
        let urlString = "\(apiURL)\(userId)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { [weak self] (data, response, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                    return
                }
                
                if let safeData = data {
                    if let carts = self?.parseJSON(safeData) {
                        self?.delegate?.userCartData(cart: carts)
                    }
                }
            }
            task.resume()
        } else {
            print("\(urlString) is invalid")
        }
    }
    
    func parseJSON(_ cartData: Data) -> [CartModel]? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode([CartModel].self, from: cartData)
            return decodeData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

}

