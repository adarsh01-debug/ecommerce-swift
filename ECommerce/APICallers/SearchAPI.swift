//
//  SearchAPI.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 30/07/22.
//

import Foundation

class SearchAPI{
    
    let apiURL = "http://localhost:8081/findBySearch/"
    
    var delegate: ProductManagerDelegate?
    
    func fecthBrandDetails(searchField: String) {
        let urlString = "\(apiURL)\(searchField)"
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
                    if let products = self?.parseJSON(safeData) {
                        self?.delegate?.searchedData(products: products)
                    }
                }
            }
            task.resume()
        } else {
            print("\(urlString) is invalid")
        }
    }
    
    func parseJSON(_ productsData: Data) -> [ProductModel]? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode([ProductModel].self, from: productsData)
            return decodeData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

}

