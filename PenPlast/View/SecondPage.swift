//
//  SecondPage.swift
//  PenPlast
//
//  Created by Вячеслав Квашнин on 03.07.2021.
//

import SwiftUI
import Firebase

struct SecondPage: View {
    
    @State var code = ""
    @Binding var show: Bool
    @Binding var ID: String
    @State var msg = ""
    @State var alert = false
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        
        if verticalSizeClass == .compact {
        
            ScrollView(.vertical, showsIndicators: false) {
                
            
        VStack {
            
            ZStack {
            Button(action: {
                
                self.show.toggle()
                
            }) {
                
                Image(systemName: "chevron.left")
                    .font(.title)
            }
            .foregroundColor(.orange)
                
                Spacer()
            }
            
            GeometryReader {_ in
                
                VStack(spacing: 15) {
                    
                    
                    Image("logo")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .cornerRadius(15)
                    
                    Text("Проверочный код")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    
                    Text("Пожалуйста, введите проверочный код")
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding(.top, 12)
                    
                    
                    TextField("Проверочный код", text: $code)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color("ColorVerify"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.top, 15)
                    
                    Button(action: {
                        
                        let credential =
                        PhoneAuthProvider.provider().credential(withVerificationID: self.ID, verificationCode: self.code)
                        
                        Auth.auth().signIn(with: credential) { (res, err) in
                            
                            if err != nil {
                                self.msg = (err?.localizedDescription)!
                                self.alert.toggle()
                                return
                            }
                            
                            UserDefaults.standard.set(true, forKey: "status")
                            
                            NotificationCenter.default.post(name: Notification.Name("statusChange"), object: nil)
                            
                        }
                    }) {
                        Text("Проверить")
                            .frame(width: UIScreen.main.bounds.width - 120, height: 50)
                    }
                    .foregroundColor(.white)
                    .background(Color.yellow)
                    .cornerRadius(10)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
         
                }
            }
        }
        .padding()
        .alert(isPresented: $alert) {
            Alert(title: Text("Error"), message: Text(self.msg), dismissButton: .default(Text("Ok")))
        }
            }
            
        } else {
            
            VStack {
                
                HStack {
                Button(action: {
                    
                    self.show.toggle()
                    
                }) {
                    
                    Image(systemName: "chevron.left")
                        .font(.title)
                }
                .foregroundColor(.orange)
                    
                    Spacer()
                }
                
                GeometryReader {_ in
                    
                    VStack(spacing: 15) {
                        
                        Spacer()
                        
                        Image("logo")
                            .resizable()
                            .frame(width: 250, height: 250, alignment: .center)
                            .cornerRadius(15)
                        
                        Text("Проверочный код")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        
                        Text("Пожалуйста, введите проверочный код")
                            .font(.body)
                            .foregroundColor(.gray)
                            .padding(.top, 12)
                        
                        
                        TextField("Проверочный код", text: $code)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color("ColorVerify"))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.top, 15)
                        
                        Button(action: {
                            
                            let credential =
                            PhoneAuthProvider.provider().credential(withVerificationID: self.ID, verificationCode: self.code)
                            
                            Auth.auth().signIn(with: credential) { (res, err) in
                                
                                if err != nil {
                                    self.msg = (err?.localizedDescription)!
                                    self.alert.toggle()
                                    return
                                }
                                
                                UserDefaults.standard.set(true, forKey: "status")
                                
                                NotificationCenter.default.post(name: Notification.Name("statusChange"), object: nil)
                                
                            }
                        }) {
                            Text("Проверить")
                                .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                        }
                        .foregroundColor(.white)
                        .background(Color.yellow)
                        .cornerRadius(10)
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                        
                        Spacer()
                    }
                }
            }
            .padding()
            .alert(isPresented: $alert) {
                Alert(title: Text("Error"), message: Text(self.msg), dismissButton: .default(Text("Ok")))
            }
        }
    }
}
