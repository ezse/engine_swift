//
//  Engine.swift
//  EngineB31
//
//  Created by Egor Zemlyanskiy on 16.04.2024.
//

import Foundation

enum EngineType {
    case diesel, benzin, elektro
}

struct EngineConfiguration {
    let cylinderCount: Int
    let type: EngineType
    let minimumPowerPercentage: Float
}

class Engine {
    
    private var status: EngineStatus = .off
    private var powerPercentage: Float = 0
    private let config: EngineConfiguration
    private let cycindersCount: ClosedRange<Int>
    private var cylinders: [Cylinder] = []
    private var process: EngineProcess?

    init(withConfiguration: EngineConfiguration) {
        
        self.config = withConfiguration
        self.cycindersCount = 1...withConfiguration.cylinderCount
        
        let values: [CylinderCycle] = CylinderCycle.allCases.map { $0 }
        for number in cycindersCount {
            
            var val = number
            if number > values.count {
                val = number - values.count
            }

            val -= 1
            let cyl = Cylinder(currentCycle: values[val], 
                               fuelCount: self.config.minimumPowerPercentage)
            self.cylinders.append(cyl)
        }
    }

    func off() {
        self.status = .off
        self.process?.cancel()
        self.process = nil
    }

    func on() {
        self.status = .on
        self.process = EngineProcess(cylinders: self.cylinders, 
                                     powerPercentage: self.powerPercentage)
    }

    func start() {
        self.status = .running
        self.process?.start()
    }

    func stop() {
        self.status = .stopped
    }

    func ignitionOn() {
        self.status = .ignitionOn
    }

    func ignitionOff() {
        self.status = .ignitionOff
    }

    func setPower(percentage: Float) -> Float {
        
        self.powerPercentage = percentage
        self.process?.updatePower(self.powerPercentage)
        return self.powerPercentage
    }

    func getStatus() -> EngineStatus {
        self.status
    }
}
