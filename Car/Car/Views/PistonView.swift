//
//  PistonView.swift
//  Car
//
//  Created by Egor Zemlyanskiy on 27.11.2024.
//

import SwiftUI
struct PistonView: View {
    @Binding var position: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.red)
            .frame(width: 40, height: 20)
            .offset(y: position)
            .animation(.easeInOut(duration: 1), value: position)
    }
}

