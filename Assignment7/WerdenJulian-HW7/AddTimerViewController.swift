// Project: WeardenJulian-HW7
// EID: jfw864
// Course: CS329E
//
//  AddTimerViewController.swift
//  WerdenJulian-HW7
//
//  Created by Julian Wearden on 10/31/22.
//

import UIKit

class AddTimerViewController: UIViewController {

    @IBOutlet weak var timeText: UITextField!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var eventText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Save values entered to Timer array
    @IBAction func saveButton(_ sender: Any) {
        let eventContent:String = eventText.text!
        let locationContent:String = locationText.text!
        let timeContent:Int = Int(timeText.text!) ?? 0  //Default is 0 if no value entered
        // If didn't enter a value
        if (eventContent == "" || locationContent == ""){
            let controller = UIAlertController(
                title: "Missing Field",
                message: "One or more fields are empty",
                preferredStyle: .alert)
            controller.addAction(UIAlertAction(
                title: "Ok",
                style: .default))
            present(controller, animated: true)
        }
        // else create Timer 
        else{
            let newTimer:Timer = Timer(event:eventContent , location:locationContent , remainingTime:timeContent)
            Timers.append(newTimer)
        }
    }
    
}
