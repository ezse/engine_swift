//
//  EngineProcess.swift
//  EngineB31
//
//  Created by Egor Zemlyanskiy on 17.04.2024.
//

import Foundation

class EngineProcess: Thread {

    private var cylinders: [Cylinder] = []
    private var outcomeRPM: Float = 0
    private var loopCycle : Double = 500
    private var powerPercentage: Float = 0
    private var onRPMUpdated: ((Float) -> Void)?
    private var onCylinderStatesUpdated: (([CylinderCycle]) -> Void)?
    private let constantRPMVal: Float = 40.0

    public init(cylinders: [Cylinder], powerPercentage: Float) {

        self.cylinders = cylinders
        self.powerPercentage = powerPercentage

        super.init()

        // Set the Name of the Thread
        self.name = "EngineProcess_Thread"

        // Try to set the priority and QoS of this thread
        self.qualityOfService = QualityOfService.userInteractive
        self.threadPriority = 1.0
    }
    
    func subsribeToRPMChanges(_ handler: @escaping (Float) -> Void) {
        self.onRPMUpdated = handler
    }
    
    func subscribeToCylinderStatesUpdates(_ handler: @escaping ([CylinderCycle]) -> Void) {
       self.onCylinderStatesUpdated = handler
    }

    public func updatePower(_ percentage: Float) {
        self.powerPercentage = percentage
    }
    
    func getCurrentPower () -> Float {
        return self.outcomeRPM
    }

    override func main() { // Thread's starting point
        autoreleasepool {
           
            while self.isCancelled == false {
                let loopStartTime = Date()

                // Execute all instantiated cooking process handlers
                self.executeCylinderCycle()

                let loopEndTime = Date()
                // Calculate the runtime of the loop
                let executionTime = loopEndTime.timeIntervalSince(loopStartTime)

                // For a not constant cycle time, we calculate the wait time depending on the execution time and given powerPercentage
                let tik = Double(constantRPMVal * powerPercentage)
                
                let sleepTime = (loopCycle / tik) - executionTime
                if sleepTime > 0 && self.isCancelled == false {
                    EngineProcess.sleep(forTimeInterval: sleepTime)
                }
            }
        }
    }
    
    private func executeCylinderCycle() {
        
        let queue = OperationQueue()
        weak var weakSelf = self
        
        var cylinderCycles: [CylinderCycle] = []

        for cylinder in cylinders {
           queue.addOperation {
               weakSelf?.outcomeRPM += cylinder.runNextCycle(fuelAmount: weakSelf?.powerPercentage ?? 0) ?? 0
           }
        }
        queue.waitUntilAllOperationsAreFinished()
        print("total outcomeRPM from cylinders -> ", weakSelf?.outcomeRPM ?? 0)
       
        let cylinders = weakSelf?.cylinders ?? []

        var cylinderStates = ""
        for (index, cylinder) in cylinders.enumerated() {
            cylinderStates.append("cylinder \(index) -> \(cylinder.getCurrentCycle())\n" )
            cylinderCycles.append(cylinder.getCurrentCycle())
        }
        
        weakSelf?.onRPMUpdated?(weakSelf?.outcomeRPM ?? 0)
        weakSelf?.onCylinderStatesUpdated?(cylinderCycles)
        print(cylinderStates)
        weakSelf?.outcomeRPM = 0
    }
}
