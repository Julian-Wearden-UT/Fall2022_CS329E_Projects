//  Project: WeardenJulian-HW3
//  EID: jfw864
//  Course: CS329E
//  ColorChangeVC.swift
//  WeardenJulian-HW3
//
//  Created by Julian Wearden on 9/23/22.
//

import UIKit

class ColorChangeVC: UIViewController {

    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var delegate: UIViewController!
    
    //Change color to blue
    @IBAction func Blue(_ sender: Any) {
        let otherVC = delegate as! ColorChanger
        otherVC.changeColor(newColor: UIColor.blue)
    }
    
    //Change color to red
    @IBAction func Red(_ sender: Any) {
        let otherVC = delegate as! ColorChanger
        otherVC.changeColor(newColor: UIColor.red)
    }
}
