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
        
//        self.slider.minimumValue = 10;
//        self.slider.maximumValue = 100;
//
//        let engine = self.engineFactory.prepareEngine()
//        engine?.sendCommand(command: .on)
//        engine?.sendCommand(command: .start)
//        
//        _ = engine?.setPower(percentage: 10)

        let capital = 20000
        let percent = 7
        var result = capital
        let yearlyPlus = 200 * 12
        let years = 33

        for i in 1...years {
            result += yearlyPlus
            let value = calculatePercentage(value: Double(result), percentageVal: Double(percent))
            result += Int(value)
            print("Preresult after", i, "years ->", result, "(where", percent,"% value is:", value,")")
        }

        print("Total Brutto result after", years, "years +", yearlyPlus, "every year and percent", percent, "is: ", result)

        let bruttoRes = (result - capital - years*yearlyPlus)
        let taxVal = calculatePercentage(value: Double(bruttoRes), percentageVal: 25)
        let nettoRes = result - Int(taxVal)

        print("Total tax: ",taxVal)
        print("Total Netto result after", years, "years +", yearlyPlus, "every year and percent", percent, "is: ", nettoRes)
        
        let acc = capital + years*yearlyPlus
        print("Or if just accumulate:", acc)
        print("Difference between investing and accumulating: ", nettoRes - acc)
        // Do any additional setup after loading the view.
    }
    

    //Calucate percentage based on given values
    public func calculatePercentage(value:Double,percentageVal:Double)->Double{
        let val = value * percentageVal
        return val / 100.0
    }

    @IBAction func sliderValueChanged(sender: UISlider) {
        _ = self.engineFactory.prepareEngine()?.setPower(percentage: sender.value)
    }
}

