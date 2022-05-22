//
//  CellView.swift
//  PenPlast
//
//  Created by Вячеслав Квашнин on 26.06.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct CellView: View {
    let data: category
    @State private var show = false
    
    var body: some View {
        VStack {
            AnimatedImage(url: URL(string: data.image)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 270)
                .padding(.horizontal)
            HStack {
                VStack(alignment: .leading) {
                    Text(data.name)
                        .font(.title)
                        .fontWeight(.heavy)
                        .lineLimit(2)
                    Text("\(data.cost)₽")
                        .font(.body)
                        .fontWeight(.heavy)
                        .padding(.bottom)
                }
                .foregroundColor(.black)
                Spacer()
                
                Button(action: {
                    self.show.toggle()
                }) {
                    Image(systemName: "arrow.right")
                        .font(.body)
                        .foregroundColor(.white)
                        .padding(14)
                        .background(Color("ColorButton"))
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 6)
        }
        .background(Color("ColorCell"))
        .cornerRadius(15)
        .onTapGesture {
            self.show.toggle()
        }
        .sheet(isPresented: $show) {
            OrderView(data: data)
        }
    }
}
