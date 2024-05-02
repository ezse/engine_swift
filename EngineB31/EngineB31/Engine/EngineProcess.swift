//
//  EngineProcess.swift
//  EngineB31
//
//  Created by Egor Zemlyanskiy on 17.04.2024.
//

import Foundation

class EngineProcess: Thread {

    private var cylinders: [Cylinder] = []
    private var outcomePower: Float = 0
    private var loopCycle : Double = 500
    private var powerPercentage: Float = 0

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
    
    public func updatePower(_ percentage: Float) {
        self.powerPercentage = percentage
    }
    
    func getCurrentPower () -> Float {
        return self.outcomePower
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

                // For a constant cycle time, we calculate the wait time depending on the execution time
                let sleepTime = (loopCycle / 1000) - executionTime
                if sleepTime > 0 && self.isCancelled == false {
                    EngineProcess.sleep(forTimeInterval: sleepTime)
                }
            }
        }
    }
    
    private func executeCylinderCycle() {
        
        let queue = OperationQueue()
        weak var weakSelf = self
        //??? TODO
        for cylinder in cylinders {
           queue.addOperation {
               weakSelf?.outcomePower += cylinder.runNextCycle(fuelAmount: weakSelf?.powerPercentage ?? 0) ?? 0
           }
        }
        queue.waitUntilAllOperationsAreFinished()
        print("total outcomePower from cylinders -> ", weakSelf?.outcomePower ?? 0)
        weakSelf?.outcomePower = 0
    }
}
