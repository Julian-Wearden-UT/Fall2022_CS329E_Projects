//  Project: WeardenJulian-HW6
//  EID: jfw864
//  Course: CS329E
//
//  LoginViewController.swift
//  WeardenJulian-HW5
//
//  Created by Julian Wearden on 10/24/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class LoginViewController: UIViewController {

    var signIn: Bool = true //True if signing in, false is signing up
    @IBOutlet weak var segCtrl: UISegmentedControl!
    @IBOutlet weak var userIDInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var confirmPasswordInput: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var statusField: UILabel!
    @IBOutlet weak var confirmPasswordField: UILabel!
    var userID:String = ""
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set default values
        confirmPasswordField.isHidden = true;
        confirmPasswordInput.isHidden = true;
        loginButton.setTitle("Sign In", for: .normal)
        signIn = true
        passwordInput.isSecureTextEntry = true
        confirmPasswordInput.isSecureTextEntry = true
        statusField.text = "Status"
        
        //Perform segue whenever status of authenitcation changes
        handle = Auth.auth().addStateDidChangeListener() {
            auth, user in
            if user != nil{
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                self.userIDInput.text = nil
                self.userID = ""
                self.passwordInput.text = nil
                self.confirmPasswordInput.text = nil
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        statusField.text = "Status"
    }
    
    // Decide whether to show login or signup page
    @IBAction func loginOrSignup(_ sender: Any) {
        switch segCtrl.selectedSegmentIndex{
        case 0: //Sign in
            confirmPasswordField.isHidden = true;
            confirmPasswordInput.isHidden = true;
            loginButton.setTitle("Sign In", for: .normal)
            signIn = true
            statusField.text = "Status"
            break
        case 1: //Sign up
            confirmPasswordField.isHidden = false;
            confirmPasswordInput.isHidden = false;
            loginButton.setTitle("Sign Up", for: .normal)
            signIn = false
            statusField.text = "Status"
            break
        default:
            break
        }
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        // Convert user ID to email address
        if(!userIDInput.text!.contains("@")){
            userID = userIDInput.text! + "@user.com"
        }
        else{
            userID = userIDInput.text!
        }
        
        //Sign in
        if signIn{
            Auth.auth().signIn(withEmail: userID, password: passwordInput.text!) {
                authResult, error in
                if let error = error as NSError? {
                    self.statusField.text = "\(error.localizedDescription)"
                } else {
                    self.statusField.text = "Success"
                }
            }
        }
        // Sign Up
        else {
            // Passwords don't match
            if(passwordInput.text! != confirmPasswordInput.text!){
                statusField.text = "Passwords do not match"
            }
            //Passwords match, create user and sign in
            else{
                Auth.auth().createUser(withEmail: userID, password: passwordInput.text!){authResult, error in
                    if let error = error as NSError? {
                        self.statusField.text = "\(error.localizedDescription)"
                    } else {
                        self.statusField.text = "Success"
                    }
                }
                
            }
        }
    }

}
