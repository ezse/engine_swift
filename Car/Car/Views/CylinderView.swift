//
//  CylinderView.swift
//  Car
//
//  Created by Egor Zemlyanskiy on 27.11.2024.
//

import SwiftUI

enum CylinderState: String, CaseIterable {
    case fuelCombustion = "🔥" //Combustion
    case gasExhaust = "💨" //Exhaust
    case fuelIntake = "⛽" //Intake
    case fuelCompression = "🌀" //Compression
    
    var color: Color {
        switch self {
        case .fuelCombustion: return .red
        case .gasExhaust: return .blue
        case .fuelIntake: return .green
        case .fuelCompression: return .orange
        }
    }
    var pistonPositionRange: (CGFloat, CGFloat) {
        switch self {
        case .fuelCompression:
            return (0.2, 0.3)
        case .fuelCombustion:
            return (0.6, 0.2)
        case .fuelIntake:
            return (0.2, 0.3)
        case .gasExhaust:
            return (0.8, 0.4)
        }
    }
}

struct CylinderView: View {
    let index: Int
    @Binding var state: CylinderState
    @State private var pistonPosition: CGFloat = 0
    private let cylinderHeight: CGFloat = 120
    private let pistonHeight: CGFloat = 20
    
    var body: some View {
        VStack {
            ZStack {
             
                RoundedRectangle(cornerRadius: 10)
                    .fill(state.color.opacity(0.7))
                    .frame(width: 60, height: cylinderHeight)
                
                PistonView(position: $pistonPosition)
                    .frame(width: 40, height: pistonHeight)
                    .offset(y: pistonPosition)
            }
            
            Text(state.rawValue)
                .font(.subheadline)
                .padding(4)
                .background(state.color)
                .cornerRadius(8)
                .foregroundColor(.white)
        }
        .padding()
        .frame(width: 100, height: 180)
        .onChange(of: state, initial: true) { newState, initial in
            updatePistonPosition(for: newState)
        }
        .onAppear {
            updatePistonPosition(for: state)
        }
    }
    
    
    private func updatePistonPosition(for state: CylinderState) {
        let range = state.pistonPositionRange
        
        let startPosition = cylinderHeight * range.0
        let endPosition = cylinderHeight * range.1
      
        pistonPosition = startPosition - (pistonHeight*2)
        
        withAnimation(.easeInOut(duration: 2.0)) {
            pistonPosition = endPosition - (pistonHeight*2)
        }
    }
}
