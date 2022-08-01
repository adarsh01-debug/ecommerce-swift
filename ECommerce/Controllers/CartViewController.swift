//
//  CartViewController.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 28/07/22.
//

import UIKit

class CartViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CartManagerDelegate, SingleProductManagerDelegate {
    
    var cartModel: [CartModel]?
    var cartAPI = CartAPI()
    
    var singleProduct = SingleProductAPI()
    var userCartProducts: [ProductModel]? = []
    
    let kCellIdentifier = "CartCollectionViewCell"
    
    var userId: Int?
    
    @IBOutlet var cartCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        registerCustomViewInCell()
        cartCollectionView.delegate = self
        cartCollectionView.dataSource = self
        
        cartAPI.delegate = self
        cartAPI.fecthCartDetails(userId: userId!)
        
        singleProduct.delegate = self
    }
    
    func userCartData(cart: [CartModel]) {
        DispatchQueue.main.async {
            self.cartModel = cart
            self.userCartProducts?.removeAll()
            if let cartModel = self.cartModel , !cartModel.isEmpty {
                for item in cartModel {
                    self.getProduct(productId: item.productID)
                }
            } else {
                DispatchQueue.main.async {
                        self.cartCollectionView.reloadData()
                }
            }
        }
    }
    
    func getProduct(productId: Int) {
        singleProduct.fecthProductDetails(productId: productId)
    }
    
    func reloadCart() {
        if let cartModel = self.cartModel {
            print(cartModel)
            //userCartData(cart: cartModel)
            cartAPI.fecthCartDetails(userId: userId!)
            
        }
    }
    
    func singleProductData(product: ProductModel) {
        self.userCartProducts?.append(product)
        if let brand = self.userCartProducts?[0].brand {
            print("00000" + brand)
        }
        DispatchQueue.main.async {
            if self.cartModel?.count == self.userCartProducts?.count {
                self.cartCollectionView.reloadData()
            }
        }
    }
    
    func registerCustomViewInCell() {
        let nib = UINib(nibName: "CartCollectionViewCell", bundle: nil)
        cartCollectionView.register(nib, forCellWithReuseIdentifier: kCellIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userCartProducts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cartCollectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier, for: indexPath) as? CartCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        
        let data = userCartProducts?[indexPath.row]
        
        if let image = data?.image {
            cell.cartImage.load(url: URL(string: image)!)
        }
        cell.cartName.text = data?.brand
        
        if let id = cartModel?[indexPath.row].id {
            cell.cartId = id
        } else {
            cell.cartId = nil
        }
        
        if let price = data?.price {
            cell.cartPrice.text = "$ \(String(describing: price))"
        }
        
        if let rating = data?.rating {
            if String(describing: rating) == "0" {
                cell.cartRating.text = "No Rating"
            } else {
                cell.cartRating.text = "\(String(describing: rating))"
            }
        }
        
        if let quantity = cartModel?[indexPath.row].quantity {
            cell.cartQuantity.text = "\(String(describing: quantity))"
        }
    
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cartCollectionView.bounds.width , height: cartCollectionView.bounds.height/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
    
}
