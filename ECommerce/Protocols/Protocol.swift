//
//  Protocol.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 29/07/22.
//

import Foundation

protocol ProductManagerDelegate: AnyObject {
    func updatedData(products: [ProductModel])
    func searchedData(products: [ProductModel])
}

protocol Response {
    func sendUserInfo(user: UserModel)
    func sendStatus(status: Bool)
}

protocol CartManagerDelegate: AnyObject {
    func userCartData(cart: [CartModel])
    func reloadCart()
}

protocol SingleProductManagerDelegate: AnyObject {
    func singleProductData(product: ProductModel)
}
