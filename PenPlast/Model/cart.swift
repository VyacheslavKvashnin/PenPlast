//
//  Cart.swift
//  PenPlast
//
//  Created by Вячеслав Квашнин on 27.06.2021.
//

import SwiftUI

struct cart: Identifiable {
    let id: String
    let name: String
    var quantity: NSNumber
    let image: String
    let cost: NSNumber
    let quick: Bool
    let payDelivery: Bool
}
