//
//  Verification.swift
//  PenPlast
//
//  Created by Вячеслав Квашнин on 28.06.2021.
//

import SwiftUI

struct Verification: View {
    
    @ObservedObject var loginData : LoginViewModel
    @Environment(\.presentationMode) var presentation
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
       
        ZStack {
            
            if verticalSizeClass == .compact {
            VStack {
                
                VStack {
                    
                    HStack {
                        
                        Button(action: {presentation.wrappedValue.dismiss()}) {
                            
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        Text("Проверка номера")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        if loginData.loading {ProgressView()}
                    }
                    .padding()
                    
                    Spacer()
                    
                    HStack(spacing: 15) {
                        
                        ForEach(0..<6, id: \.self) { index in
                            
                            CodeView(code: getCodeAtIndex(index: index))
                            
                        }
                    }
                    .padding()
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    
                    Button(action: loginData.verifyCode) {
                        
                        Text("Создать аккаунт и продолжить")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(Color("ColorButton"))
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                    }
                    .padding()
                }
                .frame(height: UIScreen.main.bounds.height / 1.8)
                .background(Color.white)
                .cornerRadius(20)
                
                CustomNumberPad(value: $loginData.code, isVerify: true)
            }
            .background(Color.black.opacity(0.1).ignoresSafeArea(.all, edges: .bottom))
            
            if loginData.error {
                AlertView(msg: loginData.errorMsg, show: $loginData.error)
            }
            } else {
                
                VStack {
                    
                    VStack {
                        
                        HStack {
                            
                            Button(action: {presentation.wrappedValue.dismiss()}) {
                                
                                Image(systemName: "arrow.left")
                                    .font(.title2)
                                    .foregroundColor(.black)
                            }
                            
                            Spacer()
                            
                            Text("Проверка номера")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                
                            
                            Spacer()
                            
                            if loginData.loading {ProgressView()}
                        }
                        .padding()
                        .padding(.top, 40)
                        
                        Text("Код отправлен на \(loginData.phNo)")
                            .foregroundColor(.gray)
                            .padding(.bottom)
                        
                        Spacer()
                        
                        HStack(spacing: 15) {
                            
                            ForEach(0..<6, id: \.self) { index in
                                
                                CodeView(code: getCodeAtIndex(index: index))
                                
                            }
                        }
                        .padding()
                        .padding(.horizontal, 20)
                        
                        Spacer()
                        
                        HStack(spacing: 6) {
                            
                            Text("Не получили код?")
                                .foregroundColor(.gray)
                            
                            Button(action: loginData.requestCode) {
                                
                                Text("Запросить еще раз")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            }
                        }
                        Button(action: {}) {
                            
                            Text("Получить по звонку")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                        .padding(.top, 6)
                        
                        Button(action: loginData.verifyCode) {
                            
                            Text("Создать аккаунт и продолжить")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 30)
                                .background(Color("ColorButton"))
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                        }
                        .padding()
                    }
                    .frame(height: UIScreen.main.bounds.height / 1.8)
                    .background(Color.white)
                    .cornerRadius(20)
                    
                    CustomNumberPad(value: $loginData.code, isVerify: true)
                }
                .padding(.bottom, 40)
                
                
                if loginData.error {
                    AlertView(msg: loginData.errorMsg, show: $loginData.error)
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3155980706, green: 0.7586981654, blue: 0.9269877076, alpha: 1)), Color.white]), startPoint: .top, endPoint: .bottom))
        .ignoresSafeArea(.all, edges: .all)
    }
    
    func getCodeAtIndex(index: Int) -> String {
        
        if loginData.code.count > index {
            
            let start = loginData.code.startIndex
            
            let current = loginData.code.index(start, offsetBy: index)
            
            return String(loginData.code[current])
        }
        return ""
    }
}

struct CodeView: View {
    
    var code: String
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            Text(code)
                .font(.title2)
                .foregroundColor(.black)
                .fontWeight(.bold)
                .frame(height: 45)
            
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 4)
        }
    }
}
