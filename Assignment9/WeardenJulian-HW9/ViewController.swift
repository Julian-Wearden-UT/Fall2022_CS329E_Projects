// Project: WeardenJulian-HW9
// EID: jfw864
// Course: CS329E
//
//  ViewController.swift
//  WeardenJulian-HW9
//
//  Created by Julian Wearden on 11/11/22.
//

import UIKit

class ViewController: UIViewController {

    //  Movement thread
    let queue = DispatchQueue(label: "myQueue", qos: .userInteractive)
    
    //  Block shown on screen
    var myBlock: UIView!
    
    //  Positional variables
    var safeArea: CGRect?
    var blockX: CGFloat?
    var blockY: CGFloat?
    
    //  Flags for direction block is moving. Helps kill threads
    var movingRight: Bool?
    var movingUp: Bool?
    var movingLeft: Bool?
    var movingDown: Bool?
    
    //  Flag for block hitting edge. Helps kill threads
    var didHitEdge: Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get safe area
        self.safeArea = view.safeAreaLayoutGuide.layoutFrame
        
        //Not moving
        self.movingRight = false;
        self.movingUp = false;
        self.movingLeft = false;
        self.movingRight = false;
        
        //In center
        self.didHitEdge = false;
        
        //Block's initial x & y
        blockX = safeArea!.midX
        blockY = safeArea!.midY
        
        //Create Block
        myBlock = UIView(frame: CGRect(x: 0, y: 0, width: safeArea!.width/9, height: safeArea!.height/19))
        myBlock.backgroundColor = UIColor.green
        myBlock.center = CGPoint(x: blockX!, y: blockY!)    //Center block
        view.addSubview(myBlock)
    }

    @IBAction func recognizeTapGesture(_ sender: Any) {
        //Reset flags
        self.movingRight = false;
        self.movingUp = false;
        self.movingLeft = false;
        self.movingRight = false;
        self.didHitEdge = false;
        
        //Center block and reset color
        blockX = safeArea!.midX
        blockY = safeArea!.midY
        myBlock.center = CGPoint(x: blockX!, y: blockY!)
        myBlock.backgroundColor = UIColor.green
        
        //Move block downwards
        swipeDown(nil)
        
    }
    
    //  Action from swipe gesture to the right
    @IBAction func swipeRight(_ sender: Any?) {
        self.movingRight = true;
        self.movingUp = false;
        self.movingLeft = false;
        self.movingDown = false;
        queue.async{
            while(!self.didHitEdge! && self.movingRight!){
                usleep(300000)    //Sleep .3 seconds
                DispatchQueue.main.sync{    //Switch to main thread to update block position
                    self.move(dir: 0)
                }
            }
        }
        
    }
    
    //  Action from swipe gesture upwards
    @IBAction func swipeUp(_ sender: Any?) {
        self.movingRight = false;
        self.movingUp = true;
        self.movingLeft = false;
        self.movingDown = false;
        queue.async{
            while(!self.didHitEdge! && self.movingUp!){
                usleep(300000)    //Sleep .3 seconds
                DispatchQueue.main.sync{    //Switch to main thread to update block position
                    self.move(dir: 1)
                }
            }
        }
    }
    
    //  Action from swipe gesture to the left
    @IBAction func swipeLeft(_ sender: Any?) {
        self.movingRight = false;
        self.movingUp = false;
        self.movingLeft = true;
        self.movingDown = false;
        queue.async{
            while(!self.didHitEdge! && self.movingLeft!){
                usleep(300000)    //Sleep .3 seconds
                DispatchQueue.main.sync{    //Switch to main thread to update block position
                    self.move(dir: 2)
                }
            }
        }
    }
    
    //  Action from swipe gesture downwards
    @IBAction func swipeDown(_ sender: Any?) {
        self.movingRight = false;
        self.movingUp = false;
        self.movingLeft = false;
        self.movingDown = true;
        queue.async{
            while(!self.didHitEdge! && self.movingDown!){
                usleep(300000)    //Sleep .3 seconds
                DispatchQueue.main.sync{    //Switch to main thread to update block position
                    self.move(dir: 3)
                }
            }
        }
    }
    
    
    //  Checks whether or not the block has hit the edge
    //  and changes blocks color to red if so
    //
    //  @return true if edge hit, false otherwise
    func hitEdge() -> Bool{
        //Check if border of block has exceded border of safe area.
        //Added (or subtracted) offset accounts for any inconsistencies in block's calculated position since it is a float (fraction) of safeArea's width and heights
        if(myBlock.frame.minX <= safeArea!.minX + 1 || myBlock.frame.maxX >= safeArea!.maxX - 1 || myBlock.frame.minY <= safeArea!.minY + (safeArea!.height/19) + 1 || myBlock.frame.maxY >= safeArea!.maxY - 1){
            myBlock.backgroundColor = UIColor.red
            return true
        }
        return false
    }
    
    //  Moves the block in a specific direction and checks
    //  whether or not it hits the edge
    //
    //  @param dir Direction object is moving, where:
    //      0 = Right
    //      1 = Up
    //      2 = Left
    //      3 = Down
    func move(dir: Int){
        if(dir == 0){       //Right
            blockX! += safeArea!.width/9
        }
        else if(dir == 1){  //Up
            blockY! -=  safeArea!.height/19
        }
        else if(dir == 2){  //Left
            blockX! -=  safeArea!.width/9
        }
        else if(dir == 3){  //Down
            blockY! +=  safeArea!.height/19
        }
        myBlock.center = CGPoint(x: blockX!, y: blockY!)
        self.didHitEdge = hitEdge()
    }

}

