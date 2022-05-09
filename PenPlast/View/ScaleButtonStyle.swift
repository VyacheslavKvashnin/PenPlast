//
//  ScaleButtonStyle.swift
//  PenPlast
//
//  Created by Вячеслав Квашнин on 06.07.2021.
//

import SwiftUI

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(10)
            .scaleEffect(configuration.isPressed ? 1.5 : 1)
    }
}
