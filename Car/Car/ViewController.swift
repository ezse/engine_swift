//
//  ViewController.swift
//  Car
//
//  Created by Egor Zemlyanskiy on 16.04.2024.
//

import UIKit

class ViewController: UIViewController {

    private let engineFactory: EngineFactory = EngineFactory()
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var enginePowerLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.slider.minimumValue = 10;
        self.slider.maximumValue = 100;

        let engine = self.engineFactory.prepareEngine()
        engine?.sendCommand(command: .on)
        engine?.sendCommand(command: .start)
        
        _ = engine?.setPower(percentage: 10)
        // Do any additional setup after loading the view.
    }

    @IBAction func sliderValueChanged(sender: UISlider) {
        _ = self.engineFactory.prepareEngine()?.setPower(percentage: sender.value)
    }
}

