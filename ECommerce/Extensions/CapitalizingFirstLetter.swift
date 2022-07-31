//
//  CapitalizingFirstLetter.swift
//  ECommerce
//
//  Created by Adarsh Pandey on 29/07/22.
//

import Foundation
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
