//  Project: WeardenJulian-HW2
//  EID: jfw864
//  Course: CS329E

//  ViewController.swift

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    //Input Fields
    @IBOutlet weak var userIDField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    //Status Label
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userIDField.delegate = self
        passwordField.delegate = self
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

    // Action when button is pressed
    @IBAction func buttonPressed(_ sender: Any) {
        
        let userInput = userIDField.text!
        let passwordInput = passwordField.text!
        // Login Successful
        if ((userInput != "") && (passwordInput != "")){
            statusLabel.text = "\(userInput) logged in"
        }
        //Login Failed
        else{
            statusLabel.text = "Invalid login"
        }
        
        
    }
}

