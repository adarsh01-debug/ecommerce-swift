//
//  SingleProductAPI.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 01/08/22.
//

import Foundation


class SingleProductAPI{
    
    let apiURL = "http://10.20.4.110:8080/product/"
    
    var delegate: SingleProductManagerDelegate?
    
    func fecthProductDetails(productId: Int) {
        let urlString = "\(apiURL)\(productId)"
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
                    if let product = self?.parseJSON(safeData) {
                        self?.delegate?.singleProductData(product: product)
                    }
                }
            }
            task.resume()
        } else {
            print("\(urlString) is invalid")
        }
    }
    
    func parseJSON(_ productData: Data) -> ProductModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(ProductModel.self, from: productData)
            return decodeData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

}
