//  Project: WeardenJulian-HW5
//  EID: jfw864
//  Course: CS329E
//
//  PizzaOrder.swift
//  WeardenJulian-HW5
//
//  Created by Julian Wearden on 10/14/22.
//

import Foundation

class PizzaOrder{
    
    var size:String = "small";
    var crust:String = "";
    var cheese:String = "";
    var meat:String = "";
    var veggies:String = "";
    
    //Base constructor
    func PizzaOrder(){
    }
    
    //Constructor
    func PizzaOrder(size:String , crust:String, cheese:String, meat:String, veggies:String){
        self.size = size
        self.crust = crust
        self.cheese = cheese
        self.meat = meat
        self.veggies = veggies
    }
    
    //Get order as string for initial field text format
    func getPizzaOrder() -> String{
        let output:String = "One \(self.size) pizza with: \n"
                            + "  \(self.crust) crust \n"
                            + "  \(self.cheese) cheese \n"
                            + "  \(self.meat) \n"
                            + "  \(self.veggies)"
        return output
    }
    
    //Get order as string for table text format
    func getPizzaOrderTable() -> String{
        let output:String = "\(self.size) \n"
                    + "  \(self.crust) crust \n"
                    + "  \(self.cheese) cheese \n"
                    + "  \(self.meat) \n"
                    + "  \(self.veggies)"
        return output;
    }
    
    //Return true if pizza fully created
    func pizzaCreated() -> Bool{
        return (self.size != "") && (self.crust != "") && (self.cheese != "") && (self.meat != "") && (self.veggies != "")
    }
    
    //Get missing item from pizza
    func getMissing() -> String{
        if(self.size == ""){
            return "Please select a size"
        }
        else if(self.crust == ""){
            return "Please select a crust type"
        }
        else if(self.cheese == ""){
            return "Please select a cheese type"
        }
        else if(self.meat == ""){
            return "Please select a meat"
        }
        else if(self.veggies == ""){
            return "Please select a veggie"
        }
        else{
            return "Unknown Error"
        }
    }
    
}
