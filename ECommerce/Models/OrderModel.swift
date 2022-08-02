//
//  OrderModel.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 02/08/22.
//

import Foundation

struct OrderModel: Codable {
    let id, userID: Int
    let productID, quantity, merchantID, cartID: [Int]

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case productID = "productId"
        case quantity
        case merchantID = "merchantId"
        case cartID = "cartId"
    }
}
