//
//  ViewController.swift
//  CalculatorV2
//
//  Created by Viacheslav Markov on 12.09.2020.
//  Copyright © 2020 Viachslav Markov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet var allButton: [UIButton]!
    
    var firstOperand = 0.0
    var secondOperand = 0.0
    var resultOperation: Double {
        get {
            return Double(textLabel.text ?? "") ?? 0
        }
        
        set {
            textLabel.text = findPoint(str: String(newValue))
            isNumberAdded = false
        }
    }
    
    var isPointAdded = false
    var isNumberAdded = false
    var isOperandAdded = false
    
    var isEquallyAdded = false
    var isSqrtAdded = false
    var isPowAdded = false
    
    var signOperand = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.layer.cornerRadius = 30
        textLabel.layer.masksToBounds = true
        
        let radius: CGFloat = 20
        
        for item in allButton {
            item.layer.cornerRadius = radius
            item.layer.masksToBounds = true
        }
    }
    
    @IBAction func touchButtonPressed(_ sender: UIButton) {
        
        let number = sender.currentTitle!
        
        if textLabel.text!.count < 15 {
            
            if isNumberAdded {
                textLabel.text = textLabel.text! + number
            } else {
                if number == "0" {
                    textLabel.text = number
                    isNumberAdded = false
                } else {
                    textLabel.text = number
                    isNumberAdded = true
                }
            }
        }
    }
    
    @IBAction func touchButtonPoint(_ sender: UIButton) {
        
        if !isPointAdded, !isNumberAdded {
            textLabel.text = "0."
            isNumberAdded = true
            isPointAdded = true
        } else if !isPointAdded, isNumberAdded {
            textLabel.text! += "."
            isPointAdded = true
        }
    }
    
    @IBAction func touchButtonEqually(_ sender: UIButton) {
        
        secondOperand = resultOperation
        
        if isOperandAdded, (firstOperand != 0 || secondOperand != 0) {
            
            let sign = Operads(rawValue: signOperand)
            
            guard let res = sign?.usedOperation(numOne: firstOperand, numTwo: secondOperand)
            else { return }
            
            textLabel.text = findPoint(str: "\(res)")
            
            isNumberAdded = false
            isPointAdded = false
            
            secondOperand = 0
            firstOperand = 0
        }
        
        if isSqrtAdded {
            let nthRoot = pow(secondOperand, (1/firstOperand))
            textLabel.text = findPoint(str: "\(nthRoot)")
        }
        
        if isPowAdded {
            let nthRoot = pow(firstOperand, secondOperand)
            textLabel.text = findPoint(str: "\(nthRoot)")
        }
    }
    
    @IBAction func touchButtonOperation(_ sender: UIButton) {
        
        firstOperand = resultOperation
        
        signOperand = sender.currentTitle!
        
        isNumberAdded = false
        isPointAdded = false
        isOperandAdded = true
    }
    
    @IBAction func touchClearButtom(_ sender: UIButton) {
        
        firstOperand = 0
        secondOperand = 0
        resultOperation = 0
        
        isNumberAdded = false
        isPointAdded = false
        isOperandAdded = false
        
        signOperand = ""
        textLabel.text = "0"
    }
    

func findPoint(str: String) -> String {
        
    var value = ""
        
    let valueArray = str.components(separatedBy: ".")
    if valueArray[1] == "0" {
        value = "\(valueArray[0])"
    } else {
        value = str
    }
        
    value = countNumber(str: value)
        
    return value
}

func countNumber(str: String) -> String {
    return String(str.prefix(20))
}
    
    @IBAction func touchPlusMinusButton(_ sender: UIButton) {
        resultOperation = -resultOperation
    }
    
    @IBAction func touchPercentButton(_ sender: UIButton) {
        if firstOperand == 0 {
            resultOperation = secondOperand / 100
        } else {
            secondOperand = firstOperand * secondOperand / 100
        }
        isNumberAdded = false
    }
    
    @IBAction func touchSinButton(_ sender: UIButton) {
        let sinus = sin(resultOperation * Double.pi / 180)
        resultOperation = sinus
//        print(sinus)
    }
    
    @IBAction func touchCosButton(_ sender: UIButton) {
        let cosinus = cos(resultOperation * Double.pi / 180)
        resultOperation = cosinus
    }
    
    @IBAction func touchCtgButton(_ sender: UIButton) {
        let sinus = sin(resultOperation * Double.pi / 180)
        let cosinus = cos(resultOperation * Double.pi / 180)
        resultOperation = cosinus / sinus
    }
    
    @IBAction func touchTgButton(_ sender: Any) {
        let sinus = sin(resultOperation * Double.pi / 180)
        let cosinus = cos(resultOperation * Double.pi / 180)
        resultOperation = sinus / cosinus
    }
    
    @IBAction func touchXpov2Button(_ sender: UIButton) {
        resultOperation = pow(resultOperation, 2)
    }
    
    @IBAction func touchEButton(_ sender: UIButton) {
        resultOperation = 2.71828182845905
    }
    
    @IBAction func TouchPiButton(_ sender: UIButton) {
        resultOperation = Double.pi
    }
    
    @IBAction func touchSqrtButton(_ sender: UIButton) {
        resultOperation = sqrt(resultOperation)
    }
    
    @IBAction func touchXSqrtYButton(_ sender: UIButton) {
        firstOperand = resultOperation
        isSqrtAdded = true
        isNumberAdded = false
    }
    
    @IBAction func touchXPovYButton(_ sender: UIButton) {
        firstOperand = resultOperation
        isPowAdded = true
        isNumberAdded = false
    }
    
}



