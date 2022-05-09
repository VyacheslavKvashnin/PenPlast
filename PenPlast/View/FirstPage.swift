//
//  FirstPage.swift
//  PenPlast
//
//  Created by Вячеслав Квашнин on 03.07.2021.
//

import SwiftUI
import Firebase

struct FirstPage: View {
    
    @State var ccode = ""
    @State var no = ""
    @State var show = false
    @State var msg = ""
    @State var alert = false
    @State var ID = ""
    
    @Environment(\.colorScheme) var colorScheme
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        
        if verticalSizeClass == .compact {
        VStack(spacing: 15) {
            
            ScrollView(.vertical, showsIndicators: false) {
                
            VStack {
                
            Image("logo")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .cornerRadius(15)
            
            Text("Подтвердите свой номер")
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            Text("Пожалуйста, введите свой номер")
                .font(.body)
                .foregroundColor(.gray)
                .padding(.top, 12)
            }
            .multilineTextAlignment(.center)
            
            HStack {
                
                TextField("+7", text: $ccode)
                    .keyboardType(.numberPad)
                    .frame(width: 45)
                    .padding()
                    .background(Color("ColorVerify"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                TextField("Номер", text: $no)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color("ColorVerify"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.top, 15)
            
            NavigationLink(destination: SecondPage(show: $show, ID: $ID), isActive: $show) {
                Button(action: {
                    
                    PhoneAuthProvider.provider().verifyPhoneNumber("+"+self.ccode+self.no, uiDelegate: nil) { (ID, err) in
                        
                        if err != nil {
                            self.msg = (err?.localizedDescription)!
                            self.alert.toggle()
                            return
                        }
                        
                        self.ID = ID!
                        self.show.toggle()
                    }
                    
                }) {
                    Text("Отправить")
                        .frame(width: UIScreen.main.bounds.width - 120, height: 50)
                }
                .foregroundColor(.white)
                .background(Color.yellow)
                .cornerRadius(10)
            }
            
            
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        .padding()
        .alert(isPresented: $alert) {
            Alert(title: Text("Error"), message: Text(self.msg), dismissButton: .default(Text("Ok")))
        }
        }
        } else {
            
            VStack(spacing: 15) {
                
                VStack {
                    
                Image("logo")
                    .resizable()
                    .frame(width: 250, height: 250, alignment: .center)
                    .cornerRadius(15)
                
                Text("Подтвердите свой номер")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                Text("Пожалуйста, введите свой номер")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.top, 12)
                }
                .multilineTextAlignment(.center)
                
                HStack {
                    
                    TextField("+7", text: $ccode)
                        .keyboardType(.numberPad)
                        .frame(width: 45)
                        .padding()
                        .background(Color("ColorVerify"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    TextField("Номер", text: $no)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color("ColorVerify"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.top, 15)
                
                NavigationLink(destination: SecondPage(show: $show, ID: $ID), isActive: $show) {
                    Button(action: {
                        
                        PhoneAuthProvider.provider().verifyPhoneNumber("+"+self.ccode+self.no, uiDelegate: nil) { (ID, err) in
                            
                            if err != nil {
                                self.msg = (err?.localizedDescription)!
                                self.alert.toggle()
                                return
                            }
                            
                            self.ID = ID!
                            self.show.toggle()
                        }
                        
                    }) {
                        Text("Отправить")
                            .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                    }
                    .foregroundColor(.white)
                    .background(Color.yellow)
                    .cornerRadius(10)
                }
                
                
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            }
            .padding()
            .alert(isPresented: $alert) {
                Alert(title: Text("Error"), message: Text(self.msg), dismissButton: .default(Text("Ok")))
            }
        }
    }
}
