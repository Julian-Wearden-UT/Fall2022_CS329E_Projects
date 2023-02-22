//  Project: WeardenJulian-HW3
//  EID: jfw864
//  Course: CS329E
//  TextChangeVC.swift
//  WeardenJulian-HW3
//
//  Created by Julian Wearden on 9/23/22.
//

import UIKit

class TextChangeVC: UIViewController {

    @IBOutlet weak var inputText: UITextField!
    
    var delegate: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //When button clicked, change text to whatever in input field
    @IBAction func Save(_ sender: Any) {
        let otherVC = delegate as! TextChanger
        otherVC.changeText(newText: inputText.text!)
    }

}
