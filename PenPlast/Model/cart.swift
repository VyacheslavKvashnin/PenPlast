//
//  Cart.swift
//  PenPlast
//
//  Created by Вячеслав Квашнин on 27.06.2021.
//

import SwiftUI

struct cart: Identifiable {
    
    var id: String
    var name: String
    var quantity: NSNumber
    var image: String
    var cost: NSNumber
    var quick: Bool
    var payDelivery: Bool

}
