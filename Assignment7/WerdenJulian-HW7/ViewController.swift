// Project: WeardenJulian-HW7
// EID: jfw864
// Course: CS329E
//
//  ViewController.swift
//  WerdenJulian-HW7
//
//  Created by Julian Wearden on 10/31/22.
//

import UIKit

let AddSegueIdentifier = "AddSegue"
let CountdownSegueIdentifier = "CountdownSegue"
let CellIdentifier = "TimerTableViewCell"
var Timers:[Timer] = []

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData() //Update table data
    }

    // Set number of cells for table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Timers.count  // One cell for each timer
    }
    
    // Set value of each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! TimerTableViewCell
        cell.eventLabel?.text = "Event           \(Timers[row].getEvent())"
        cell.locationLabel?.text = "Location      \(Timers[row].getLocation())"
        cell.remainingTimeLabel?.text = "Remaining Time(s)  \(Timers[row].getRemainingTime())"
        
        return cell
    }
    
    // Segue to countdown
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CountdownSegueIdentifier,
           let destination = segue.destination as? CountdownViewController,
           let timerIndex = tableView.indexPathForSelectedRow?.row {
            destination.currTimer = Timers[timerIndex]   // Pass timer value so countdown knows chosen value
        }
    }

}

