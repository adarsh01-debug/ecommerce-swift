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
