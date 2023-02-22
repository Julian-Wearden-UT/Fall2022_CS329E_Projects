//  Project: WeardenJulian-HW5
//  EID: jfw864
//  Course: CS329E
//
//  PizzaCreationViewController.swift
//  WeardenJulian-HW5
//
//  Created by Julian Wearden on 10/14/22.
//

import UIKit

class PizzaCreationViewController: UIViewController {

    @IBOutlet weak var segCtrl: UISegmentedControl!
    var currentPizza:PizzaOrder = PizzaOrder()
    var delegate: UIViewController!
    @IBOutlet weak var outputPizza: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPizza = PizzaOrder() //Create new pizza
        outputPizza.text = "" //Make sure output text is nothing at first
    }
    
    // Segmented VC manager
    @IBAction func setPizzaSize(_ sender: Any) {
        switch segCtrl.selectedSegmentIndex{
        case 0:
            self.currentPizza.size = "small"
            break
        case 1:
            self.currentPizza.size = "medium"
            break
        case 2:
            self.currentPizza.size = "large"
            break
        default:
            self.currentPizza.size = "small"
            break
        }
    }
    
    //Alert for crust
    @IBAction func setCrust(_ sender: Any) {
        let controller = UIAlertController(
            title: "Select crust",
            message: "Choose a crust type:",
            preferredStyle: .alert)
        controller.addAction(UIAlertAction(
            title: "Thin crust",
            style: .default,
            handler:  {action in self.currentPizza.crust = "thin"}))
        controller.addAction(UIAlertAction(
            title: "Thick crust",
            style: .default,
            handler:  {action in self.currentPizza.crust = "thick"}))
        present(controller, animated: true)
    }
    
    //Action sheet for cheese
    @IBAction func setCheese(_ sender: Any) {
        let controller = UIAlertController(
            title: "Select cheese",
            message: "Choose a cheese type:",
            preferredStyle: .actionSheet)
        
        let regularAction = UIAlertAction(
            title: "Regular cheese",
            style: .default,
            handler: {
                (action) in self.currentPizza.cheese = "regular"})
        controller.addAction(regularAction)
        
        let noAction = UIAlertAction(
            title: "No cheese",
            style: .default,
            handler: {
                (action) in self.currentPizza.cheese = "no"})
        controller.addAction(noAction)
        
        let doubleAction = UIAlertAction(
            title: "Double cheese",
            style: .default,
            handler: {
                (action) in self.currentPizza.cheese = "double"})
        controller.addAction(doubleAction)
        
        present(controller, animated: true)
    }
    
    //Action sheet for meat
    @IBAction func setMeat(_ sender: Any) {
        let controller = UIAlertController(
            title: "Select meat",
            message: "Choose one meat:",
            preferredStyle: .actionSheet)
        
        let pepperoniAction = UIAlertAction(
            title: "Pepperoni",
            style: .default,
            handler: {
                (action) in self.currentPizza.meat = "pepperoni"})
        controller.addAction(pepperoniAction)
        
        let sausageAction = UIAlertAction(
            title: "Sausage",
            style: .default,
            handler: {
                (action) in self.currentPizza.meat = "sausage"})
        controller.addAction(sausageAction)
        
        let baconAction = UIAlertAction(
            title: "Canadian Bacon",
            style: .default,
            handler: {
                (action) in self.currentPizza.meat = "canadian bacon"})
        controller.addAction(baconAction)
        
        present(controller, animated: true)
    }
    
    //Action sheet for veggies
    @IBAction func setVeggies(_ sender: Any) {
        let controller = UIAlertController(
            title: "Select veggies",
            message: "Choose your veggies",
            preferredStyle: .actionSheet)
        
        let mushroomAction = UIAlertAction(
            title: "Mushroom",
            style: .default,
            handler: {
                (action) in self.currentPizza.veggies = "mushroom"})
        controller.addAction(mushroomAction)
        
        let onionAction = UIAlertAction(
            title: "Onion",
            style: .default,
            handler: {
                (action) in self.currentPizza.veggies = "onion"})
        controller.addAction(onionAction)
        
        let greenOliveAction = UIAlertAction(
            title: "Green Olive",
            style: .default,
            handler: {
                (action) in self.currentPizza.veggies = "green olive"})
        controller.addAction(greenOliveAction)
        
        let blackOliveAction = UIAlertAction(
            title: "Black Olive",
            style: .default,
            handler: {
                (action) in self.currentPizza.veggies = "black olive"})
        controller.addAction(blackOliveAction)
        
        let noneAction = UIAlertAction(
            title: "None",
            style: .default,
            handler: {
                (action) in self.currentPizza.veggies = "none"})
        controller.addAction(noneAction)
        
        present(controller, animated: true)
    }
    
    // Done button
    @IBAction func done(_ sender: Any) {
        // If Pizza complete
        if (currentPizza.pizzaCreated()){
            // Add pizza to pizzaOrders in main VC
            let otherVC = delegate as! PizzaAdder
            otherVC.addPizza(newPizza: self.currentPizza)
            // output to field
            outputPizza.text = currentPizza.getPizzaOrder()
            // Reset pizza so you can add another without having to return to main VC
            currentPizza = PizzaOrder()
        }
        // Else alert ingredient missing
        else{
            let controller = UIAlertController(
                title: "Missing Ingredient",
                message: currentPizza.getMissing(),
                preferredStyle: .alert)
            controller.addAction(UIAlertAction(
                title: "Ok",
                style: .default))
            present(controller, animated: true)
        }
    }
    
}
