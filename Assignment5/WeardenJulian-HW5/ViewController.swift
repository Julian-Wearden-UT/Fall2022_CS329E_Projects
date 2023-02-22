//  Project: WeardenJulian-HW5
//  EID: jfw864
//  Course: CS329E
//
//  ViewController.swift
//  WeardenJulian-HW5
//
//  Created by Julian Wearden on 10/14/22.
//

import UIKit

//Protocol to add pizza
protocol PizzaAdder{
    func addPizza(newPizza: PizzaOrder)
}

let SegueIdentifier = "SegueIdentifier"
let CellIdentifier = "CellIdentifier"
var pizzaOrders:[PizzaOrder] = []   //Holds pizzas made

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PizzaAdder {
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    // Set number of cells for table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzaOrders.count  // One cell for each operand
    }
    
    // Set value of each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        cell.textLabel?.numberOfLines = 5 // Allow 5 rows of text in field
        cell.textLabel?.text = pizzaOrders[row].getPizzaOrderTable()   //Set cell to string of order
        
        return cell
    }
    
    //Go to segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier,
           let nextVC = segue.destination as? PizzaCreationViewController{
            nextVC.delegate = self  //So we can call protocol funcs
        }
    }
    
    //Add pizza to orders list
    func addPizza(newPizza: PizzaOrder) {
        pizzaOrders.append(newPizza)    //Add pizza to list
        self.tableView.reloadData() //Update table data
    }
    
}

