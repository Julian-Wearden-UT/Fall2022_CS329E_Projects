//  Project: WeardenJulian-HW6
//  EID: jfw864
//  Course: CS329E
//
//  ViewController.swift
//  WeardenJulian-HW5
//
//  Created by Julian Wearden on 10/14/22.
//

import UIKit
import FirebaseAuth
import CoreData

//Protocol to add pizza
protocol PizzaAdder{
    func addPizza(newPizza: PizzaOrder)
}


let SegueIdentifier = "SegueIdentifier"
let CellIdentifier = "CellIdentifier"

//var pizzaOrders:[NSManagedObject] = []
// For core data
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PizzaAdder {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //pizzaOrders = getAllOrders()
        //clearCoreData()
    }
    
    func clearCoreData() {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Order")
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = context.fetch(request) as? [NSManagedObject]
            
            if fetchedResults!.count > 0 {
                for result:AnyObject in fetchedResults! {
                    context.delete(result as! NSManagedObject)
                    print("\(result.value(forKey: "userOrder")!) has been deleted")
                }
            }
            saveContext()
            
        } catch {
            // if an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
    }
    
    func storeOrder(currOrder: PizzaOrder) {
        let currOrderString = currOrder.getPizzaOrderTable()
        
        let order = NSEntityDescription.insertNewObject(forEntityName: "Order", into: context)
        
        order.setValue(currOrderString, forKey: "userOrder")
        
        // commit the changes
        saveContext()
    }
    
    func getAllOrders() ->[NSManagedObject]{
        //Create array from coredata stored orders
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Order")
        var fetchedResults:[NSManagedObject]? = nil

        // Fetch All Orders
        do {
            try fetchedResults = context.fetch(request) as? [NSManagedObject]
        } catch {
            // if an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        return (fetchedResults)!
    }
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // Set number of cells for table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Order")
        var numberOfResults:Int = 0

        do{
            numberOfResults = try context.count(for: request)

        }
        catch{
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
        }

        return numberOfResults  // One cell for each operand
        //return pizzaOrders.count
    }
    
    // Set value of each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fetchedResults = getAllOrders()
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        cell.textLabel?.numberOfLines = 5 // Allow 5 rows of text in field
//        let orderForCell = fetchedResults[row].value(forKey: "userOrder") as! PizzaOrder
//        cell.textLabel?.text = orderForCell.getPizzaOrderTable()   //Set cell to string of order
        cell.textLabel?.text = fetchedResults[row].value(forKey: "userOrder") as? String

        return cell
//        let order = pizzaOrders[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
//        cell.textLabel?.numberOfLines = 5
//        let orderForCell = order.value(forKey: "userOrder") as? PizzaOrder
//        cell.textLabel?.text = orderForCell?.getPizzaOrderTable()
//        return cell
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
        storeOrder(currOrder: newPizza)    //Add pizza to list
        self.tableView.reloadData() //Update table data
    }
    
    //Swipe delte pizza from UITableView
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            let fetchedResults = getAllOrders()
            context.delete(fetchedResults[indexPath.row])
            saveContext()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Logout
    @IBAction func logoutButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true)
            
        } catch {
            print("Sign out error")
        }
    }
    
    
}

