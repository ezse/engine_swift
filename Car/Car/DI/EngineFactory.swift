//
//  EngineFactory.swift
//  Car
//
//  Created by Egor Zemlyanskiy on 22.04.2024.
//

import Foundation

class EngineFactory {
    
    private var engine: Engine?
    
    func prepareEngine() -> Engine? {

        if let engine = self.engine {
            return engine
        } else {
           
            let engineProvider = EngineProvider()
            let dataViewModel = EngineDataViewModel(engineProviding: engineProvider)
            let engine = dataViewModel.performEnginePreparation()
            self.engine = engine
            return engine
        }
    }
}

