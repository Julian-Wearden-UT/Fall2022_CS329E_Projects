//
//  Project: WeardenJulian-HW4
//  EID: jfw864
//  Course: CS329E
//
//  CalcViewController.swift
//  WeardenJulian-HW4
//
//  Created by Julian Wearden on 10/3/22.
//

import UIKit

class CalcViewController: UIViewController{

    @IBOutlet weak var firstOperand: UITextField!
    @IBOutlet weak var secondOperand: UITextField!
    
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    var opChosen:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Change operatorLabel to converted operand before controller loads
    override func viewWillAppear(_ animated: Bool) {
        switch opChosen{
        case "Add":
            operatorLabel.text = "+"
        case "Subtract":
            operatorLabel.text = "-"
        case "Multiply":
            operatorLabel.text = "*"
        case "Divide":
            operatorLabel.text = "/"
        default:
            operatorLabel.text = "Operator"
        }
        
    }
    
    // Make keyboard go away when screen clicked pt.1
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Make keyboard go away when screen clicked pt.2
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Happens when button calculate is pressed
    @IBAction func calculateResult(_ sender: Any) {
        let number1:String = firstOperand.text!     // Holds first number as string
        let number2:String = secondOperand.text!    // Holds second number as string
        // If numbers are ints
        if let _:Int = Int(number1), let _:Int = Int(number2){
            resultLabel.text = String(calculateInt(number1: number1, number2: number2))
        }
        // If numbers are floats
        else if let _:Float = Float(number1), let _:Float = Float(number2){
            resultLabel.text = String(calculateFloat(number1: number1, number2: number2))
        }
        // Invalid character input
        else{
            resultLabel.text = "Invalid Input(s)"
        }
    }
        
    // Takes 2 numbers as strings and returns result after operation as int
    func calculateInt(number1:String, number2:String) -> Int{
        let num1:Int? = Int(number1)
        let num2:Int? = Int(number2)
        
        switch opChosen{
        case "Add":
            return num1! + num2!
        case "Subtract":
            return num1! - num2!
        case "Multiply":
            return num1! * num2!
        case "Divide":
            return num1! / num2!
        default:
            return 0
        }
    }
    
    // Takes 2 numbers as strings and returns result after operation as float
    func calculateFloat(number1:String, number2:String) -> Float{
        let num1:Float? = Float(number1)
        let num2:Float? = Float(number2)
        
        switch opChosen{
        case "Add":
            return num1! + num2!
        case "Subtract":
            return num1! - num2!
        case "Multiply":
            return num1! * num2!
        case "Divide":
            return num1! / num2!
        default:
            return 0
        }
    }

}
