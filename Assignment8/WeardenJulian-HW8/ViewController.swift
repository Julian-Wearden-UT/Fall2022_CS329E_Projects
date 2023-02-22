//  Project: WeardenJulian-HW8
//  EID: jfw864
//  Course: CS329E
//
//  ViewController.swift
//  WeardenJulian-HW8
//
//  Created by Julian Wearden on 11/5/22.
//

import UIKit

class ViewController: UIViewController {

    var button: UIButton!
    var button1: UIButton!
    var currentImage:Bool! //True if image1, false if image2
    var count:Int = 0   //Button clicked count
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Enable notifications for the user
        allowNotifications()
        
        //Set background of view to UT blue
        view.backgroundColor = UIColor(red:51/255.0, green:63/255.0, blue:72/255.0, alpha:1)
        
        //Create button programatically
        button = UIButton(type: .custom)
        button.frame = CGRect(x:0, y:0, width:view.bounds.width, height:view.bounds.height) //Full screen button
        if let image1: UIImage = UIImage(named: "ut.png"){  //Initialize to first image
            button.setImage(image1, for: .normal)
            currentImage = true
        }
        button.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)   //Center button
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)   //On action
        self.view.addSubview(button)    // dd to view
    }
    
    // Ask the user if they will allow notifications
    func allowNotifications(){
        UNUserNotificationCenter.current().requestAuthorization(options:[.alert,.badge,.sound]) {
            granted, error in
            if granted {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    @objc func buttonPressed(sender: UIButton!){
        animateOut()    //Fade out old image & fade in new image
        self.count += 1 //Button clicked
        if (self.count % 4 == 0){   //If multiple of 4, send notification
            notification()
        }
        
    }
    
    // Animate image out
    func animateOut(){
        UIButton.animate(
            withDuration: 1.0,
            delay: 0.0,
            options: .curveEaseOut,
            animations: {self.button.alpha = 0.0},
            completion: { _ in
                self.switchImage()
                self.animateIn()
            })
    }
    
    //Animate image in
    func animateIn(){
        UIButton.animate(
            withDuration: 1.0,
            delay: 0.0,
            options: .curveEaseIn,
            animations: {self.button.alpha = 1.0},
            completion: nil)
    }
    
    //Switch between the two images
    func switchImage(){
        if(currentImage){
            if let image2: UIImage = UIImage(named: "uttower.png"){
                button.setImage(image2, for: .normal)
                currentImage = false
            }
        }
        else{
            if let image1: UIImage = UIImage(named: "ut.png"){
                button.setImage(image1, for: .normal)
                currentImage = true
            }
        }
    }
    
    //Create and send notification
    func notification(){
        // create content
        let content = UNMutableNotificationContent()
        content.title = "Click Count"
        content.subtitle = "Runs every 4 clicks"
        content.body = "You have clicked \(self.count) times"
        content.sound = UNNotificationSound.default
        
        // create trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 8, repeats: false)
        
        // combine it all into a request
        let request = UNNotificationRequest(identifier: "myNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    

}

