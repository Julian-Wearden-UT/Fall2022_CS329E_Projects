// Project: WeardenJulian-HW7
// EID: jfw864
// Course: CS329E
//
//  CountdownViewController.swift
//  WerdenJulian-HW7
//
//  Created by Julian Wearden on 10/31/22.
//

import UIKit

class CountdownViewController: UIViewController {

    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    var currTimer:Timer?
    var countdownActive:Bool = false    //True when countdown happening
    
    let queue = DispatchQueue(label: "myQueue", qos: .userInteractive)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        countdown()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        countdownActive = false //Stops timer
    }
    
    func initialize(){
        //Initialize field with timer vars
        eventLabel.text! = (currTimer?.getEvent())!
        locationLabel.text! = (currTimer?.getLocation())!
        remainingTimeLabel.text! = "\(currTimer?.getRemainingTime() ?? 0)"
        countdownActive = true
    }
    
    // Run timer
    func countdown(){
        queue.async{
            while(self.countdownActive && self.currTimer!.remainingTime > 0){
                sleep(1)    //Sleep one second
                self.currTimer?.decreaseTime()  //Then update timer
                DispatchQueue.main.sync{    //Switch to main thread to update label
                    self.remainingTimeLabel.text! = "\(self.currTimer?.getRemainingTime() ?? 0)"
                }
            }
        }
    }

}
