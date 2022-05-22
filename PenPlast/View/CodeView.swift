//
//  CodeView.swift
//  PenPlast
//
//  Created by Вячеслав Квашнин on 22.05.2022.
//

import SwiftUI

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
