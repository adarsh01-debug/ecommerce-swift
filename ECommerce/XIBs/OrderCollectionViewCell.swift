//
//  OrderCollectionViewCell.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 02/08/22.
//

import UIKit

class OrderCollectionViewCell: UICollectionViewCell {

    @IBOutlet var name: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var quantity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
