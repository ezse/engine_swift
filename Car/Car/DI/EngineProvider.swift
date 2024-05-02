//
//  DependecyInjector.swift
//  Car
//
//  Created by Egor Zemlyanskiy on 17.04.2024.
//

import Foundation
import APICarParts
import EngineB31

protocol EngineProviding {
    func prepareEngine() -> APIEngineInterface?
}

class EngineProvider: EngineProviding {
    func prepareEngine() -> APIEngineInterface? {
        let engine = EngineB31()
        return engine
    }
}

class MockedEngineProvider: EngineProviding {
    func prepareEngine() -> APIEngineInterface? {
        return nil
    }
}

// Engine impl wrapper
protocol Engine: APIEngineInterface{}
extension EngineB31: Engine{}
