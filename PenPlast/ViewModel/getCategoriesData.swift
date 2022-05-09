//
//  getCategoriesData.swift
//  PenPlast
//
//  Created by Вячеслав Квашнин on 26.06.2021.
//

import SwiftUI
import Firebase

class getCategoriesData: ObservableObject {
    
    @Published var text = ""
    
    @Published var datas = [category]()
    
    init() {
        
        let db = Firestore.firestore()
        
        db.collection("Items").addSnapshotListener { (snap, err) in
            
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documentChanges {
                
                let id = i.document.documentID
                let cost = i.document.get("cost") as! NSNumber
                let details = i.document.get("details") as! String
                let image = i.document.get("image") as! String
                let name = i.document.get("name") as! String
                
                self.datas.append(category(id: id, cost: cost, details: details, image: image, name: name))
            }
        }
    }
}
