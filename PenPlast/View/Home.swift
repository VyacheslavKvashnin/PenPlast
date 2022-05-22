//
//  Home.swift
//  PenPlast
//
//  Created by Вячеслав Квашнин on 26.06.2021.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct Home: View {
    @ObservedObject var categories = getCategoriesData()
    @AppStorage("log_Status") var status = false
    
    private let device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    
    @State private var showOrder = false
    @State private var text = ""
    
    var body: some View {
        VStack {
            if self.categories.datas.count != 0 {
                ScrollView(.vertical, showsIndicators: false) {
                    SearchBar(text: $categories.text)
                        .padding(.top)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: getColumns())) {
                        ForEach(categories.datas.filter({"\($0)".contains(categories.text) || categories.text.isEmpty})) { i in
                            CellView(data: i)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                        }
                        .padding()
                    }
                }
                .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3155980706, green: 0.7586981654, blue: 0.9269877076, alpha: 1)), Color.white]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
            }
        }
    }
    
    func getColumns() -> Int {
        return (device == .mac || device == .pad) ? 3 : ((device == .phone && width == .regular) ? 3 : 1)
    }
}
