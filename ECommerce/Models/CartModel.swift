//
//  CartModel.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 01/08/22.
//

import Foundation

struct CartModel: Codable {
    let id, userID, productID, quantity: Int
    let merchantID: Int

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case productID = "productId"
        case quantity
        case merchantID = "merchantId"
    }
}
