//
//  MainView.swift
//  Car
//
//  Created by Egor Zemlyanskiy on 27.11.2024.
//

import SwiftUI

struct MainView: View {
    @State private var sliderValue: Float = 10.0
    @State private var enginePowerLabel: String = "Engine InCome Power: 10%"
    @State private var engineRPMLabel: String = "RPM: "
    @State private var cylinders: [CylinderState] = []
    private let engineFactory = EngineFactory()
    private let cylinderCycleConverter = CylinderCycleConverter()
   
    var body: some View {
        VStack {
            Text(enginePowerLabel)
                .font(.headline)
                .padding()

            Slider(value: $sliderValue, in: 10...100, step: 1)
                .padding()
                .onChange(of: sliderValue, initial: true) { newValue, initial in
                    updateEnginePower(to: newValue)
                }

            Text(engineRPMLabel)
                .font(.headline)
                .padding()

            HStack {
                ForEach(0..<cylinders.count, id: \.self) { index in
                    CylinderView(index: index, state: $cylinders[index])
                }
            }
            .frame(height: 200)
        }
        .onAppear {
            setupEngine()
        }
    }

    private func setupEngine() {
        guard let engine = engineFactory.prepareEngine() else { return }
        engine.sendCommand(command: .on)
        engine.sendCommand(command: .start)
        _ = engine.setPower(percentage: sliderValue)
        enginePowerLabel = "Engine Power: \(Int(sliderValue))%"

        engine.subsribeToRPMChanges { rpm in
            engineRPMLabel = "RPM: \(Int(rpm))"
        }
        
        engine.subsribeToCylinderStates { receivedCycles in
            cylinders = cylinderCycleConverter.convert(baseStatuses: receivedCycles)
        }
    }
    
    

    private func updateEnginePower(to value: Float) {
        _ = engineFactory.prepareEngine()?.setPower(percentage: value)
        enginePowerLabel = "Engine Power: \(Int(value))%"
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
