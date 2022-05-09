//
//  OrderView.swift
//  PenPlast
//
//  Created by Вячеслав Квашнин on 26.06.2021.
//

import SwiftUI
import FirebaseFirestore
import SDWebImageSwiftUI

struct OrderView: View {
    
    var data: category
    @State var cash = false
    @State var quick = false
    @State var quantity = 0
    @Environment(\.presentationMode) var presentation
    
    
    var body: some View {
        
        VStack(spacing: 15) {
          
            ZStack {
            Rectangle()
                .fill(Color.white.opacity(0.5))
                .clipShape(Capsule())
                .frame(width: 35, height: 4, alignment: .center)
                .cornerRadius(25)
                .padding(.top, 2)
                
            HStack {
                Spacer()

                Button(action: {
                    withAnimation {
                        presentation.wrappedValue.dismiss()
                    }

                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(Color.white.opacity(0.5))
                })
                .padding([.top, .trailing])
            }
            }
         
            AnimatedImage(url: URL(string: data.image)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                .padding([.leading, .trailing])
            
            VStack(alignment: .leading, spacing: 25) {
                Text(data.name)
                    .font(.title)
                    .fontWeight(.heavy)
                
                Text("\(data.cost)₽")
                    .fontWeight(.heavy)
                    .font(.body)
                
                Toggle(isOn: $cash, label: {
                    Text("Оплата при доставке")
                })
                
                Toggle(isOn: $quick, label: {
                    Text("С доставкой")
                })
                
                Stepper(
                    onIncrement: {self.quantity += 1 },
                    onDecrement: { if self.quantity != 0 {
                        self.quantity -= 1
                    } },
                    label: {
                        Text("Количество:  \(self.quantity)")
                    })
            }
            .foregroundColor(.black)
            .frame(width: 370, alignment: .center)
            
            Button(action: {
                
                let db = Firestore.firestore()
                db.collection("cart").document()
                    .setData(["item": self.data.name, "quantity": self.quantity, "payDelivery": self.quick, "quick": self.cash, "image": self.data.image, "cost": self.data.cost]) { (err) in
                        
                        if err != nil {
                            print((err?.localizedDescription)!)
                            return
                        }
                        withAnimation(.default) {
                            self.presentation.wrappedValue.dismiss()
                        }
                    }
            }) {
                Text("Добавить в корзину")
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .background(Color("ColorButton"))
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                    .padding(.bottom, 80)
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3155980706, green: 0.7586981654, blue: 0.9269877076, alpha: 1)), Color.white]), startPoint: .top, endPoint: .bottom).ignoresSafeArea())
        .ignoresSafeArea(.all, edges: .all)

    }
}
