//
//  getCartData.swift
//  PenPlast
//
//  Created by Вячеслав Квашнин on 27.06.2021.
//

import SwiftUI
import Firebase

class getCartData: ObservableObject {
    
    @Published var datas = [cart]()
    
    @Published var ordered = false
    
    init() {
        let db = Firestore.firestore()
        
        db.collection("cart").addSnapshotListener { (snap, err) in
            
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documentChanges {
                
                if i.type == .added {
                    
                    let id = i.document.documentID
                    let name = i.document.get("item") as! String
                    let quantity = i.document.get("quantity") as? NSNumber
                    let image = i.document.get("image") as! String
                    let cost = i.document.get("cost") as? NSNumber
                    let quick = i.document.get("quick") as! Bool
                    let payDelivery = i.document.get("payDelivery") as? Bool
                    
                    self.datas.append(cart(id: id, name: name, quantity: quantity ?? 0, image: image, cost: cost ?? 0, quick: quick, payDelivery: payDelivery ?? (0 != 0)))
                }
                
                if i.type == .modified {
                    let id = i.document.documentID
                    let quantity = i.document.get("quantity") as! NSNumber
                    
                    for j in 0..<self.datas.count {
                        if self.datas[j].id == id {
                            self.datas[j].quantity = quantity
                        }
                    }
                }
            }
        }
    }
    
    func calculatePrice() -> Int {
        var price: Int = 0
        
        datas.forEach { (item) in
            
            price += Int(truncating: item.cost) * Int(truncating: item.quantity)
            
        }
        return price
    }

    
    func updateOrder() {
        
        let db = Firestore.firestore()
        
        if ordered {
            ordered = false
            db.collection("Users").document(Auth.auth().currentUser!.phoneNumber!).delete { (err) in
                if err != nil {
                    self.ordered = true
                }
            }
            return
        }
        
        var details: [[String: Any]] = []
        
        datas.forEach { (cart) in
            
            details.append([
                "name": cart.name,
                "quantity": cart.quantity,
                "cost": cart.cost,
                "quick": cart.quick,
                "payDelivery": cart.payDelivery
            ])
        }
        ordered = true
        db.collection("Users").document(Auth.auth().currentUser!.phoneNumber!).setData([
            
            "ordered_new": details,
            "total_cost": calculatePrice()
            
        ]) { (err) in
            if err != nil {
                self.ordered = false
                return
            }
            print("success")
        }
    }
}
