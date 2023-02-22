// Project: WeardenJulian-HW7
// EID: jfw864
// Course: CS329E
//
//  Timer.swift
//  WerdenJulian-HW7
//
//  Created by Julian Wearden on 10/31/22.
//

import Foundation

class Timer{
    
    // Fields for a timer
    var event:String = ""
    var location:String = ""
    var remainingTime:Int = 0
    
    //Initialize
    init(event:String, location:String, remainingTime:Int){
        self.event = event
        self.location = location
        self.remainingTime = remainingTime
    }
    
    //Decreate time by one
    func decreaseTime(){
        self.remainingTime -= 1
    }
    
    //Getters for variables
    func getEvent() -> String{
        return self.event
    }
    
    func getLocation() -> String{
        return self.location
    }
    
    func getRemainingTime() -> Int{
        return self.remainingTime
    }
    
    
    
    
    
}
