//
//  Cylinder.swift
//  EngineB31
//
//  Created by Egor Zemlyanskiy on 16.04.2024.
//

import Foundation

enum CylinderCycle: String, CaseIterable  {
    case fuelIntake, fuelCompression, fuelCombustion, gasExhaust
}

class Cylinder {
    
    private var currentCycle: CylinderCycle
    private let capacity: Float = 0.5
    private var fuelCount: Float = 0
    private var compressedRatio: Float = 0

    init(currentCycle: CylinderCycle, fuelCount: Float) {
        self.currentCycle = currentCycle
        
        if self.currentCycle == .fuelIntake {
            self.fuelCount = fuelCount
        }
    }

    private func calculateTorque() -> Float {
        var res: Float = 0.0
        res = self.fuelCount * self.capacity * 100 * self.compressedRatio
        return res
    }

    func getCapacity() -> Float {
        return self.capacity
    }
    
    func fuelIntake(value: Float) {
        self.fuelCount += value
    }

    private func fuelCompression() {
        self.compressedRatio = 4
    }

    private func fuelCombustion() -> Float {

        let torque = self.calculateTorque()
        self.fuelCount = 0
        return torque
    }

    func getCurrentCycle() -> CylinderCycle {
        return self.currentCycle
    }

    func runNextCycle(fuelAmount: Float) -> Float? {
        
        var nextCycle: CylinderCycle = self.currentCycle
        var torque: Float? = nil

        switch self.currentCycle {
        case .fuelIntake:
            nextCycle = .fuelCompression
        case .fuelCompression:
            nextCycle = .fuelCombustion
        case .fuelCombustion:
            nextCycle = .gasExhaust
        case .gasExhaust:
            nextCycle = .fuelIntake
        }

        switch nextCycle {
        case .fuelIntake:
            self.fuelIntake(value: fuelAmount)
        case .fuelCompression:
            self.fuelCompression()
        case .fuelCombustion:
            torque = self.fuelCombustion()
        case .gasExhaust:
            self.gasExhaust()
        }
        
        self.currentCycle = nextCycle

        return torque
    }

    private func gasExhaust() {
        self.compressedRatio = 0
    }
}
