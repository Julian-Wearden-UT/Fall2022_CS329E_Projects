//  Project: WeardenJulian-HW3
//  EID: jfw864
//  Course: CS329E
//  ViewController.swift
//  WeardenJulian-HW3
//
//  Created by Julian Wearden on 9/23/22.
//

import UIKit

//Protocol to change text
protocol TextChanger{
    func changeText(newText:String)
}

//Protocol to change color
protocol ColorChanger{
    func changeColor(newColor: UIColor)
}

class ViewController: UIViewController, TextChanger, ColorChanger {
    @IBOutlet weak var mainTextField: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        mainTextField.text = "Text goes here"
    }
    
    //Go to segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ColorSegue",
           let nextVC = segue.destination as? ColorChangeVC{
            nextVC.delegate = self  //So we can call protocol funcs
        }
        else if segue.identifier == "TextSegue",
                let nextVC = segue.destination as? TextChangeVC{
            nextVC.delegate = self  //So we can call protocol funcs
        }
    }
    
    //Set new background color of text
    func changeColor(newColor: UIColor) {
        mainTextField.backgroundColor = newColor
    }
    
    //Change text contents
    func changeText(newText: String) {
        mainTextField.text = newText
    }

}

