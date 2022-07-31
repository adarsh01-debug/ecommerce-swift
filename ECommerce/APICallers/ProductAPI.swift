//
//  ProductAPI.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 29/07/22.
//
//
import Foundation



class ProductAPI {
    
    let apiURL = "http://10.20.4.110:8080/product"
    
    weak var delegate: ProductManagerDelegate?
    
    func fecthProductsDetails() {
        performRequest(with: apiURL)
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
                    if let products = self?.parseJSON(safeData) {
                        self?.delegate?.updatedData(products: products)
                    } else {
                        print("Error while parsing data")
                    }
                } else {
                    print("Data isn't safe")
                }
            }
            task.resume()
        } else {
            print("\(urlString) is invalid")
        }
    }
    
    func parseJSON(_ productData: Data) -> [ProductModel]? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode([ProductModel].self, from: productData)
            return decodeData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

