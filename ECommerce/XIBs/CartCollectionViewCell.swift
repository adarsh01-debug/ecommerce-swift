//
//  CartCollectionViewCell.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 29/07/22.
//

import UIKit

class CartCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet var cartImage: UIImageView!
    @IBOutlet var cartName: UILabel!
    @IBOutlet var cartPrice: UILabel!
    @IBOutlet var cartRating: UILabel!
    @IBOutlet var cartQuantity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
