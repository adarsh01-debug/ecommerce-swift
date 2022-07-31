//
//  ProductDetailViewController.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 29/07/22.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    var productImage, productCategory, productBrand, productPrice, productRating, productStock, productCamera, productRam, productProcessor, productDailShape, productHeadphoneType, productColor, productScreenType, productScreenSize: String?
    
    
    @IBOutlet var pImage: UIImageView!
    @IBOutlet var category: UILabel!
    @IBOutlet var brand: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var rating: UILabel!
    @IBOutlet var stock: UILabel!
    @IBOutlet var camera: UILabel!
    @IBOutlet var ram: UILabel!
    @IBOutlet var processor: UILabel!
    @IBOutlet var dailShape: UILabel!
    @IBOutlet var headphoneType: UILabel!
    @IBOutlet var color: UILabel!
    @IBOutlet var screenType: UILabel!
    @IBOutlet var screenSize: UILabel!
    @IBOutlet var details: UILabel!
    
    
    @IBOutlet var addToCart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        category.font = UIFont.italicSystemFont(ofSize: 15.0)
        brand.font = UIFont.boldSystemFont(ofSize: 26.0)
        price.textColor = .red
        
        rating.font = UIFont.italicSystemFont(ofSize: 15.0)
        stock.font = UIFont.italicSystemFont(ofSize: 15.0)
        
        camera.font = UIFont.italicSystemFont(ofSize: 15.0)
        ram.font = UIFont.italicSystemFont(ofSize: 15.0)
        processor.font = UIFont.italicSystemFont(ofSize: 15.0)
        dailShape.font = UIFont.italicSystemFont(ofSize: 15.0)
        headphoneType.font = UIFont.italicSystemFont(ofSize: 15.0)
        color.font = UIFont.italicSystemFont(ofSize: 15.0)
        screenType.font = UIFont.italicSystemFont(ofSize: 15.0)
        screenSize.font = UIFont.italicSystemFont(ofSize: 15.0)
        
        details.font = UIFont.italicSystemFont(ofSize: 15.0)
        details.text = "Details: "
        details.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        addToCart.layer.masksToBounds = true
        addToCart.layer.cornerRadius = 10.0
        
        updateLabels()
    }
    
    
    @IBAction func addToCartAction(_ sender: Any) {
        
    }
    
    func updateLabels() {
        if let pCategory = productCategory {
            category.text = pCategory
        } else {
            category.text = "No Category"
        }
        
        if let pBrand = productBrand {
            brand.text = pBrand
        } else {
            brand.text = "No Brand"
        }
        
        if let pPrice = productPrice {
            price.text = "$ \(pPrice)"
        } else {
            price.text = "No Category"
        }
        
        if let pStock = productStock {
            stock.text = pStock
        } else {
            stock.text = "No Stock"
        }
        
        if let pRating = productRating {
            rating.text = pRating
        } else {
            rating.text = "No Rating"
        }
        
        if let pCamera = productCamera {
            camera.text = pCamera
        } else {
            camera.text = "NULL"
        }
        
        if let pRam = productRam {
            ram.text = pRam
        } else {
            ram.text = "NULL"
        }
        
        if let pProcessor = productProcessor {
            processor.text = pProcessor
        } else {
            processor.text = "NULL"
        }
        
        if let pDailShape = productDailShape {
            dailShape.text = pDailShape
        } else {
            dailShape.text = "NULL"
        }
        
        if let pHeadPhoneType = productHeadphoneType {
            headphoneType.text = pHeadPhoneType
        } else {
            headphoneType.text = "NULL"
        }
        
        if let pColor = productColor {
            color.text = pColor
        } else {
            color.text = "NULL"
        }
        
        if let pScreenType = productScreenType {
            screenType.text = pScreenType
        } else {
            screenType.text = "NULL"
        }
        
        if let pScreenSize = productScreenSize {
            screenSize.text = pScreenSize
        } else {
            screenSize.text = "NULL"
        }
        
        if let imageUrl = productImage {
            pImage.load(url: URL(string: imageUrl)!)
        }
    }
}
