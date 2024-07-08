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

    @IBOutlet weak var capitalView: UIView!
    @IBOutlet weak var capitalTextField: UITextField!
    @IBOutlet weak var percentTextField: UITextField!
    @IBOutlet weak var eurProYearTextField: UITextField!
    @IBOutlet weak var numberOfYearTextField: UITextField!
    @IBOutlet weak var capitalResultView: UITextView!
    
    @IBAction func pressCalculate() {
        let capital = Int(self.capitalTextField.text ?? "0") ?? 0
        let percent = Int(self.percentTextField.text ?? "0") ?? 0
        var result = capital
        let yearlyPlus = (Int(self.eurProYearTextField.text ?? "0") ?? 0) * 12
        let years = Int(self.numberOfYearTextField.text ?? "0") ?? 0

        var resString = ""
        for i in 1...years {
            result += yearlyPlus
            let value = calculatePercentage(value: Double(result), percentageVal: Double(percent))
            result += Int(value)
            print("Preresult after", i, "years ->", result, "(where", percent,"% value is:", value,")")
        }
        
        resString.append("Total Brutto result after \(years) years + \(yearlyPlus) every year and percent \(percent) is: \(result))\n\n")
       
        print("Total Brutto result after", years, "years +", yearlyPlus, "every year and percent", percent, "is: ", result)

        let bruttoRes = (result - capital - years*yearlyPlus)
        let taxVal = calculatePercentage(value: Double(bruttoRes), percentageVal: 26)
        let nettoRes = result - Int(taxVal)

        print("Total tax: ",taxVal)
        resString.append("Total tax:  \(taxVal)\n\n")
       
        
        print("Total Netto result after", years, "years +", yearlyPlus, "every year and percent", percent, "is: ", nettoRes)
        resString.append("Total Netto result after \(years) years + \(yearlyPlus) every year and percent \(percent) is: \(nettoRes)\n\n")
       
        let acc = capital + years*yearlyPlus
        print("Or if just accumulate:", acc)
        resString.append("Or if just accumulate: \(acc)\n\n")
        
        print("Difference between investing and accumulating: ", nettoRes - acc)
        resString.append("Difference between investing and accumulating: \( nettoRes - acc)\n\n")
        
        capitalResultView.text = resString
    }

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

