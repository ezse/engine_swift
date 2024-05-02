//
//  EngineStatus.swift
//  EngineB31
//
//  Created by Egor Zemlyanskiy on 16.04.2024.
//

import Foundation

enum EngineStatus {
    case running,
         stopped,
         on,
         off,
         ready,
         notReady,
         error,
         warning,
         ignitionOn,
         ignitionOff
}
