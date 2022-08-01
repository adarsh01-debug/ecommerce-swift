//
//  ProductModel.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 29/07/22.
//

import Foundation

struct ProductModel: Codable {
    let id: Int?
    let category: Category?
    let brand: String?
    let merchantID, price, stock, rating: Int?
    let camera, ram: Int?
    let processor, dialShape, strapMaterial, headphoneType: String?
    let color, screenType: String?
    let screenSize: Int?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id, category, brand
        case merchantID = "merchantId"
        case price, stock, rating, camera, ram, processor, dialShape, strapMaterial, headphoneType, color, screenType, screenSize, image
    }
}

enum Category: String, Codable {
    case headphone = "headphone"
    case laptop = "laptop"
    case mobile = "mobile"
    case television = "television"
    case watch = "watch"
}

//struct ProductModel: Codable {
//    let id: Int?
//    let category: Category?
//    let brand: String?
//    let merchantID, price, stock, rating: Int?
//    let camera, ram: Int?
//    let processor, dialShape, headphoneType, color: String?
//    let screenType: String?
//    let screenSize: Int?
//    let image: String?
//    let starpMaterial: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, category, brand
//        case merchantID = "merchantId"
//        case price, stock, rating, camera, ram, processor, dialShape, headphoneType, color, screenType, screenSize, image, starpMaterial
//    }
//}
//
//enum Category: String, Codable, CaseIterable {
//    case headphone = "headphone"
//    case laptop = "laptop"
//    case mobile = "mobile"
//    case television = "television"
//    case watch = "watch"
//}

struct CategoryModel {
    let image: String?
    let name: String?
}
