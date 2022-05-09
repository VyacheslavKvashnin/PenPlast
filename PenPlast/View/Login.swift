//
//  Login.swift
//  PenPlast
//
//  Created by Вячеслав Квашнин on 28.06.2021.
//

import SwiftUI

struct Login: View {
    
    @StateObject var loginData = LoginViewModel()
    
    @State var isSmall = UIScreen.main.bounds.height < 750
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        
        ZStack {
            
            if verticalSizeClass == .compact {
                
                VStack {
                    
                    VStack {
                        
                        Text("Продолжить с телефона")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding()
                        
                        Text("Вы получите 6 значный код для продолжения")
                            .font(isSmall ? .none : .title2)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        // number...
                        
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 6) {
                                
                                Text("Введите свой номер телефона")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Text("+ \(loginData.getCountryCode()) \(loginData.phNo)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                
                            }
                            
                            Spacer(minLength: 0)
                            
                            NavigationLink(destination: Verification(loginData: loginData), isActive: $loginData.gotoVerify) {
                                
                                Text("")
                                    .hidden()
                                
                                Button(action: loginData.sendCode) {
                                    
                                    Text("Далее")
                                        .foregroundColor(.white)
                                        .padding(.vertical, 18)
                                        .padding(.horizontal, 38)
                                        .background(Color.yellow)
                                        .cornerRadius(15)
                                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                                }
                            }
                            .disabled(loginData.phNo == "" ? true : false)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)
                    }
                    .frame(height: UIScreen.main.bounds.height / 1.8)
                    .background(Color.white)
                    .cornerRadius(20)
                    
                    
                    CustomNumberPad(value: $loginData.phNo, isVerify: false)
                    
                }
                .background(Color.purple.opacity(0.06).ignoresSafeArea(.all, edges: .bottom))
                
                if loginData.error {
                    
                    AlertView(msg: loginData.errorMsg, show: $loginData.error)
                }
            } else {
                
                VStack {
                    
                    VStack {
                        
                        Text("Продолжить с телефона")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top, 40)
                        
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(15)
                            .padding()
                            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
                        
                        Text("Вы получите 6 значный код для продолжения")
                            .font(isSmall ? .none : .title2)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        // number...
                        
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 6) {
                                
                                Text("Введите свой номер телефона")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Text("+ \(loginData.getCountryCode()) \(loginData.phNo)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                
                            }
                            Spacer(minLength: 0)
                            
                            NavigationLink(destination: Verification(loginData: loginData), isActive: $loginData.gotoVerify) {
                                
                                Text("")
                                    .hidden()
                                
                                Button(action: loginData.sendCode) {
                                    
                                    Text("Далее")
                                        .foregroundColor(.white)
                                        .padding(.vertical, 18)
                                        .padding(.horizontal, 38)
                                        .background(Color("ColorButton"))
                                        .cornerRadius(15)
                                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                                }
                            }
                            .disabled(loginData.phNo == "" ? true : false)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)
                    }
                    .frame(height: UIScreen.main.bounds.height / 1.8)
                    .background(Color.white)
                    .cornerRadius(20)
                    
                    
                    CustomNumberPad(value: $loginData.phNo, isVerify: false)
                    
                    Spacer()
                }
                .padding(.bottom, 40)
             
                
                if loginData.error {
                    
                    AlertView(msg: loginData.errorMsg, show: $loginData.error)
                }
            }
        }
       
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3155980706, green: 0.7586981654, blue: 0.9269877076, alpha: 1)), Color.white]), startPoint: .top, endPoint: .bottom))
        .ignoresSafeArea(.all, edges: .all)
    }
    
}
