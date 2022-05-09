//
//  ContentView.swift
//  PenPlast
//
//  Created by Вячеслав Квашнин on 26.06.2021.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State var show = false
    @AppStorage("log_Status") var status = false
    @ObservedObject var cartData = getCartData()
    
    @Environment(\.colorScheme) var colorScheme
    
    init(){
        
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.3155980706, green: 0.7586981654, blue: 0.9269877076, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        
    }
    
    var body: some View {
        
        ZStack {
            
            if status {
                NavigationView {
                    Home()
                    
                        .navigationBarTitle("Каталог", displayMode: .inline)
                        .navigationBarItems(
                            leading:
                                
                                Button(action: {
                                    try? Auth.auth().signOut()
                                    withAnimation {status = false}
                                }) {
                                    HStack {
                                        
                                        Image(systemName: "chevron.left")
                                        
                                        Text("Выход")
                                    }
                                    .font(.body)
                                    .foregroundColor(colorScheme == .dark ? .white : .white) },
                            
                            trailing:
                                
                                Button(action: {
                                    withAnimation(.default) {
                                        self.show.toggle()
                                    }
                                }) {
                                    Image(systemName: "cart.fill")
                                        .font(.title2)
                                        .foregroundColor(colorScheme == .dark ? .white : .white)
                                })
                }
                .navigationViewStyle(StackNavigationViewStyle())
                
            }
            else {
                
                NavigationView {
                    Login()
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                }
                .navigationViewStyle(StackNavigationViewStyle())
            }
            
            if self.show {
                
                GeometryReader { proxy in
                    VStack {
                        CartView()
                    }
                    .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                }
                
                .background(
                    Color.black.opacity(0.55)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                self.show.toggle()
                            }
                        }
                )
            }
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) {
                (_) in
                
                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                
                self.status = status
            }
        }
    }
}
