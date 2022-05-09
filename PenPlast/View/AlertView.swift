//
//  AlertView.swift
//  PenPlast
//
//  Created by Вячеслав Квашнин on 28.06.2021.
//

import SwiftUI

struct AlertView: View {
    
    var msg: String
    @Binding var show: Bool
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 15, content: {
            
            Text("Сообщение")
                .fontWeight(.bold)
                .foregroundColor(.gray)
            
            Text(msg)
                .foregroundColor(.gray)
            
            Button(action: {
                withAnimation {
                    show.toggle()
                }
            }, label: {
                
                Text("Отмена")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 80)
                    .background(Color("ColorButton"))
                    .cornerRadius(15)
            })
            .frame(alignment: .center)
        })
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .padding(.horizontal, 25)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.3).ignoresSafeArea())
    }
}
