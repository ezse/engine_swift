//
//  MainEngine.swift
//  EngineB31
//
//  Created by Egor Zemlyanskiy on 16.04.2024.
//

import Foundation
import APICarParts

public class EngineB31: APIEngineInterface {

    private let engineConfiguration: EngineConfiguration
    private let engine: Engine
    private let converter: EngineStatusConverter = EngineStatusConverter()

    public func sendCommand(command: APIEngineCommand) {
        switch command {
        case .on:
            self.engine.on()
        case .off:
            self.engine.ignitionOff()
            self.engine.off()
        case .start:
            self.engine.ignitionOn()
            self.engine.start()
        case .stop:
            self.engine.ignitionOff()
            self.engine.stop()
        }
    }
    
    public func getStatus() -> [APIEngineStatus] {
        
        let abstStatus = self.converter.convert(status: self.engine.getStatus())
        return abstStatus
    }
    
    public func setPower(percentage: Float) -> ([APIEngineStatus], Float) {
        
        let retPower = self.engine.setPower(percentage: percentage)
        
        let status = self.getStatus()
        
        let res: ([APIEngineStatus], Float)  = (status, retPower)
        return res
    }
    
    public init () {

        self.engineConfiguration = EngineConfiguration(cylinderCount: 4,
                                                       type: .benzin,
                                                       minimumPowerPercentage: 5)

        self.engine = Engine(withConfiguration: self.engineConfiguration)
    }
}
