//
//  OrderViewController.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 02/08/22.
//

import UIKit

class OrderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SingleProductManagerDelegate {
    
    
    let kCellIdentifier = "OrderCollectionViewCell"
    var singleProduct = SingleProductAPI()
    
    var userCartProducts: [ProductModel]? = []

    var userId: Int?
    var productId: [Int]?
    var quantity: [Int]?
    var merchantId: [Int]?
    var cartId: [Int]?
    
    
    
    @IBOutlet var orderCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerCustomViewInCell()
        orderCollectionView.delegate = self
        orderCollectionView.dataSource = self
        
        singleProduct.delegate = self
    }
    
    func getProduct() {
        if let productId = self.productId {
            for item in productId {
                singleProduct.fecthProductDetails(productId: item)
            }
        }
    }
    
    func singleProductData(product: ProductModel) {
        self.userCartProducts?.append(product)
    }
    
    func registerCustomViewInCell() {
        let nib = UINib(nibName: "OrderCollectionViewCell", bundle: nil)
        orderCollectionView.register(nib, forCellWithReuseIdentifier: kCellIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = orderCollectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier, for: indexPath) as? OrderCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let data = userCartProducts?[indexPath.row]
        
        cell.name.text = data?.brand
        cell.price.text = "$ \(String(describing: data?.price))"
        cell.quantity.text = "\(quantity![indexPath.row])"
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: orderCollectionView.bounds.width , height: orderCollectionView.bounds.height/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }

}
