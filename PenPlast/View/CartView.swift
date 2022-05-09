//
//  CartView.swift
//  PenPlast
//
//  Created by Вячеслав Квашнин on 27.06.2021.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct CartView: View {
    
    @ObservedObject var cartData = getCartData()
    
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.horizontalSizeClass) var width
    
    init() {
        UITableView.appearance().separatorStyle = .singleLine
       UITableViewCell.appearance().backgroundColor = .white
       UITableView.appearance().backgroundColor = .white
    }
    
    var body: some View {
        
        VStack {
            
            Text(self.cartData.datas.count != 0 ? "В вашей корзине:" : "Ваша корзина пуста")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding([.top, .bottom])
                .frame(width: UIScreen.main.bounds.width)
                .background(Color("ColorButton").shadow(radius: 3))
            
            if self.cartData.datas.count != 0 {
                
                List {
                    
                    ForEach(self.cartData.datas) { i in
                        
                        HStack(spacing: 15) {
                            
                            AnimatedImage(url: URL(string: i.image))
                                .resizable()
                                .frame(width: 55, height: 55)
                                .cornerRadius(10)
                            
                            VStack(alignment: .leading) {
                                
                                Text(i.name)
                                    .font(.body)
                                
                                HStack {
                                    Text("Количество: \(i.quantity)")
                                        .font(.caption)
                                    
                                    Spacer()
                                    
                                    Text("Цена: \(i.cost)₽")
                                        .font(.caption)
                                }
                                .padding(.top, 5)
                            }
                        }
                        .onTapGesture {
                            UIApplication.shared.windows.last?.rootViewController?.present(textFieldAlertView(id: i.id), animated: true, completion: nil)
                        }
                    }
                    .onDelete { (index) in
                        let db = Firestore.firestore()
                        
                        db.collection("cart").document(self.cartData.datas[index.last!].id).delete { (err) in
                            
                            if err != nil {
                                print((err?.localizedDescription)!)
                                return
                            }
                            self.cartData.datas.remove(atOffsets: index)
                        }
                    }
                    .listRowBackground(Color("ColorCell"))
                    .foregroundColor(.black)
                }
            }
            
            Spacer()
            
            HStack {
                Text("Итого: ")
                    .fontWeight(.bold)
                
                Spacer()
                
                Text("\(cartData.calculatePrice())₽")
                    .fontWeight(.bold)
            }
            .foregroundColor(.black)
            .padding()
            
            VStack {
                Button(action: cartData.updateOrder) {
                    
                    Text(cartData.ordered ? "Отменить заказ" : "Отправить заказ")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .frame(width: UIScreen.main.bounds.width, height: 40)
                .background(Color("ColorButton").shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5))
                
            }
        }
        .frame(width: (device == .pad && width == .regular) ? 650 : 300, height: (device == .pad && width == .regular) ? 850 : 350)
        .background(Color("ColorCell"))
        .cornerRadius(25)
    }
}

func textFieldAlertView(id: String) -> UIAlertController {
    let alert = UIAlertController(title: "Обновить количество", message: "Введите количество", preferredStyle: .alert)
    
    alert.addTextField {(txt) in
        
        txt.placeholder = "Количество"
        txt.keyboardType = .numberPad
        
    }
    
    let update = UIAlertAction(title: "Обновить", style: .default) { (_) in
        
        let db = Firestore.firestore()
        let value = alert.textFields![0].text!
        
        db.collection("cart").document(id).updateData(["quantity": Int(value)!]) { (err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
        }
    }
    
    let cancel = UIAlertAction(title: "Oтмена", style: .destructive, handler: nil)
    
    alert.addAction(cancel)
    
    alert.addAction(update)
    
    return alert
}
