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
            guard let text = textLabel.text else { return 0 }
            return Double(text) ?? 0
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
            
            if isNumberAdded, let text = textLabel.text {
                textLabel.text = text + number
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
        
        if secondOperand == 0 {
            textLabel.text = OperationError.divideByZero.errorDescription
        } else if isOperandAdded, (firstOperand != 0 || secondOperand != 0) {
            
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
            
            if secondOperand < 0 {
                textLabel.text = OperationError.sqrtOfNegative.errorDescription
            } else {
                let nthRoot = Operads(rawValue: signOperand)
                let res = nthRoot?.usedOperation(numOne: firstOperand, numTwo: secondOperand)
                guard let text = res else {return}
                textLabel.text = findPoint(str: "\(text)")
                
            }
        }
        
        if isPowAdded {
            let nthRoot = Operads(rawValue: signOperand)
            let res = nthRoot?.usedOperation(numOne: firstOperand, numTwo: secondOperand)
            guard let text = res else {return}
            textLabel.text = findPoint(str: "\(text)")
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
        
        if outTheRange(num: resultOperation) {
            textLabel.text = OperationError.trigonometricError.errorDescription
        } else {
            let sinus = sin(resultOperation * Double.pi / 180)
            resultOperation = sinus
        }
    }
    
    @IBAction func touchCosButton(_ sender: UIButton) {
        
        if outTheRange(num: resultOperation) {
            textLabel.text = OperationError.trigonometricError.errorDescription
        } else {
        let cosinus = cos(resultOperation * Double.pi / 180)
        resultOperation = cosinus
        }
    }
    
    @IBAction func touchCtgButton(_ sender: UIButton) {
        
        if (firstOperand != 0 || firstOperand != 180 || firstOperand != 360),
           !outTheRange(num: firstOperand) {
            let sinus = sin(resultOperation * Double.pi / 180)
            let cosinus = cos(resultOperation * Double.pi / 180)
            resultOperation = cosinus / sinus
        } else {
            textLabel.text = OperationError.trigonometricError.errorDescription
        }
    }
    
    @IBAction func touchTgButton(_ sender: UIButton) {
            
        if (firstOperand != 90 || firstOperand != 270),
           !outTheRange(num: firstOperand) {
            let sinus = sin(resultOperation * Double.pi / 180)
            let cosinus = cos(resultOperation * Double.pi / 180)
            resultOperation = sinus / cosinus
        } else {
            textLabel.text = OperationError.trigonometricError.errorDescription
        }
    }
    
    @IBAction func touchXpov2Button(_ sender: UIButton) {
        resultOperation = pow(resultOperation, 2)
        isNumberAdded = false
    }
    
    @IBAction func touchEButton(_ sender: UIButton) {
        resultOperation = 2.71828182845905
        isNumberAdded = false
    }
    
    @IBAction func TouchPiButton(_ sender: UIButton) {
        resultOperation = Double.pi
        isNumberAdded = false
    }
    
    @IBAction func touchSqrtButton(_ sender: UIButton) {
        if firstOperand < 0 {
            resultOperation = sqrt(resultOperation)
            isNumberAdded = false
        } else {
            textLabel.text = OperationError.sqrtOfNegative.errorDescription
        }
    }
    
    @IBAction func touchXSqrtYButton(_ sender: UIButton) {
            
            guard let text = sender.currentTitle else {return}
            signOperand = text
            firstOperand = resultOperation
            isSqrtAdded = true
            isNumberAdded = false

    }
    
    @IBAction func touchXPovYButton(_ sender: UIButton) {
        
        guard let text = sender.currentTitle else {return}
        signOperand = text
        firstOperand = resultOperation
        isPowAdded = true
        isNumberAdded = false
    }
    
    func outTheRange(num: Double) -> Bool {
        return (num <= 0 || num >= 360) ? true : false
    }
    
}



