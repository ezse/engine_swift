//
//  EngineInterface.swift
//  CarParts
//
//  Created by Egor Zemlyanskiy on 16.04.2024.
//

import Foundation

public enum APIEngineStatus {
    case running, stopped, on, off, ready, notReady, error, warning
}

public enum APIEngineCommand {
    case on, off, start, stop
}

public protocol APIEngineInterface {

    func sendCommand(command: APIEngineCommand)
    func getStatus() -> [APIEngineStatus]
    func setPower(percentage: Float) -> ([APIEngineStatus], Float)
}
