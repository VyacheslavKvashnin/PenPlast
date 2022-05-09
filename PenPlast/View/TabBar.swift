//
//  TabBar.swift
//  PenPlast
//
//  Created by Вячеслав Квашнин on 27.06.2021.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            
            Home()
                .tabItem { Image(systemName: "house") }
            
            CartView()
                .tabItem { Image(systemName: "cart") }
        }
    }
}

