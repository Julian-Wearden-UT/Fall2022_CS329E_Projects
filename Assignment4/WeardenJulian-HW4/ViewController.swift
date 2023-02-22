//
//  Project: WeardenJulian-HW4
//  EID: jfw864
//  Course: CS329E
//
//  ViewController.swift
//  WeardenJulian-HW4
//
//  Created by Julian Wearden on 10/3/22.
//

import UIKit

public let operands = ["Add", "Subtract", "Multiply", "Divide"]

let operandCellIdentifier = "operandCell"
let calculatorSegueIdentifier = "CalculatorSegueIdentifier"

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // Set number of cells for table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operands.count   // One cell for each operand
    }
    
    // Set value of each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: operandCellIdentifier, for: indexPath)
        cell.textLabel?.text = operands[row]    //Set cell label to one of the operands
        
        return cell
    }
    
    // Segue to calculator
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == calculatorSegueIdentifier,
           let destination = segue.destination as? CalcViewController,
           let opIndex = tableView.indexPathForSelectedRow?.row {
            destination.opChosen = operands[opIndex]    // Pass opChosen value so calculator knows chosen value
        }
    }

}

