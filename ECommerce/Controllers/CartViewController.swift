//
//  CartViewController.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 28/07/22.
//

import UIKit

class CartViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let kCellIdentifier = "CartCollectionViewCell"

    @IBOutlet var cartCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerCustomViewInCell()
        cartCollectionView.delegate = self
        cartCollectionView.dataSource = self
    }
    
    func registerCustomViewInCell() {
        let nib = UINib(nibName: "CartCollectionViewCell", bundle: nil)
        cartCollectionView.register(nib, forCellWithReuseIdentifier: kCellIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cartCollectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier, for: indexPath) as? CartCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let imageName = "laptopcomputer"
        let image = UIImage(systemName: imageName)
        let imageView = UIImageView(image: image)
        
        cell.cartImage = imageView
        cell.cartName.text = "Product Name"
        cell.cartPrice.text = "$9999"
        cell.cartRating.text = "4.5"
        cell.cartQuantity.text = "6"
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
