//
//  EngineDataViewModel.swift
//  Car
//
//  Created by Egor Zemlyanskiy on 22.04.2024.
//

import Foundation

class EngineDataViewModel {
    private let engineProviding: EngineProviding
    
    init(engineProviding: EngineProviding) {
        self.engineProviding = engineProviding
    }

    func performEnginePreparation() -> Engine? {
        
        let engine = engineProviding.prepareEngine() as? Engine
        return engine
    }
}
