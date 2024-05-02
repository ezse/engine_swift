//
//  EngineStatusConverter.swift
//  EngineB31
//
//  Created by Egor Zemlyanskiy on 16.04.2024.
//

import Foundation
import APICarParts

class EngineStatusConverter {
    
    func convert(baseStatus: APIEngineStatus) -> EngineStatus {
        
        switch baseStatus {
        case .running:
            return .running
        case .stopped:
            return .stopped
        case .on:
            return .on
        case .off:
            return .off
        case .ready:
            return .ready
        case .notReady:
            return .notReady
        case .error:
            return .error
        case .warning:
            return .warning
        }
    }
    
    func convert(status: EngineStatus) -> [APIEngineStatus] {
        
        switch status {
        case .running:
            return [.running]
        case .stopped:
            return [.stopped, .ready]
        case .on:
            return [.on]
        case .off:
            return [.off]
        case .ready:
            return [.ready]
        case .notReady:
            return [.notReady]
        case .error:
            return [.error]
        case .warning:
            return [.off]
        case .ignitionOn:
            return [.ready]
        case .ignitionOff:
            return [.notReady]
        }
    }
}
