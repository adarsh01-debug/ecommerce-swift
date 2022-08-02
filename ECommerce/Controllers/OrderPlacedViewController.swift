//
//  OrderPlacedViewController.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 02/08/22.
//

import UIKit

class OrderPlacedViewController: UIViewController {

    
    @IBOutlet var orderPlaced: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        orderPlaced.image = UIImage(named: "what-is-order-fulfillment.gif")
    }

}
