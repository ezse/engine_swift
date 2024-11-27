//
//  CylinderConverter.swift
//  Car
//
//  Created by Egor Zemlyanskiy on 27.11.2024.
//
import APICarParts

class CylinderCycleConverter {
    func convert(baseStatuses: [APICylinderStatus]) -> [CylinderState] {
        
        var res: [CylinderState] = []
        
        for status in baseStatuses {
            
            var element: CylinderState = .fuelCompression
            switch status {
            case .fuelCombustion:
                element = .fuelCombustion
            case .gasExhaust:
                element = .gasExhaust
            case .fuelIntake:
                element = .fuelIntake
            case .fuelCompression:
                element = .fuelCompression
            }
            res.append(element)
        }
        return res
    }
}
