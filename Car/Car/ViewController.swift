//
//  ViewController.swift
//  Car
//
//  Created by Egor Zemlyanskiy on 16.04.2024.
//

import UIKit

class ViewController: UIViewController {

    private let engineFactory: EngineFactory = EngineFactory()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let engine = self.engineFactory.prepareEngine()
        engine?.sendCommand(command: .on)
        engine?.sendCommand(command: .start)
        
        engine?.setPower(percentage: 10)
        // Do any additional setup after loading the view.
    }
}

