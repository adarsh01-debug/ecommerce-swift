//
//  CartCollectionViewCell.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 29/07/22.
//

import UIKit

class CartCollectionViewCell: UICollectionViewCell {

    
    var cartId: Int?
    var cartView = CartViewController()
    
    var delegate: CartManagerDelegate?
    
    @IBOutlet var cartImage: UIImageView!
    @IBOutlet var cartName: UILabel!
    @IBOutlet var cartPrice: UILabel!
    @IBOutlet var cartRating: UILabel!
    @IBOutlet var cartQuantity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func deleteFromCart(_ sender: Any) {
        if let id = cartId {
            let stringURL = "http://10.20.4.110:9090/cart/\(id)"
            guard let url = URL(string: stringURL) else {
                print("Problem in url string")
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            let task = URLSession.shared.dataTask(with: request) {data, _, error in
                if (error != nil){
                    print("Error in session")
                    return
                }
                }
                task.resume()
            } else {
                print("No id")
        }
        self.delegate?.reloadCart()
    }
}
