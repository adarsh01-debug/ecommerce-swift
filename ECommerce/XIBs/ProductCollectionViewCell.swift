//
//  ProductCollectionViewCell.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 29/07/22.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productBrand: UILabel!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var productStock: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productBrand.font = UIFont.boldSystemFont(ofSize: 16.0)
    }

}
