//
//  ViewController.swift
//  eggTimer
//
//  Created by carole lang on 10/14/16.
//  Copyright © 2016 Dana Young. All rights reserved.
//
//Need to add check again hitting zero

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var timerLabel: UILabel!
    
    var timer = Timer()
    var numberOfTimers = 0
    
    //adding bools to have deduction happen in timerTick if timer is active to avoid overwritting current value inside of timerLabel
    var addTenSecPushed = false
    var minusTenSecPushed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    deinit {
        timer.invalidate()
    }
    
    func timerTick(){
        
        //print("A second has passed...")
        if (timerLabel.text != nil){
            
            var convertedTimer = Int(timerLabel.text!)!
            if minusTenSecPushed == true, addTenSecPushed == false {
                convertedTimer -= 10
                minusTenSecPushed = false
            }
            else if minusTenSecPushed == false, addTenSecPushed == true{
                convertedTimer += 10
                addTenSecPushed = false
            }
            else{
                convertedTimer -= 1
            }
            let newString:String! = "\(convertedTimer)"
            timerLabel.text = newString

        }
        else {
            resetTimer()
        }
    }
    
    func resetTimer(){
        
        timer.invalidate()
        timerLabel.text! = "210"
        numberOfTimers = 0
        
    }
    
    @IBAction func startTimer(_ sender: AnyObject) {

        if numberOfTimers < 1{
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.timerTick), userInfo: nil, repeats: true)
        }
        numberOfTimers = 1
    }
    
    
    @IBAction func pauseTimer(_ sender: AnyObject) {
        timer.invalidate()
        numberOfTimers = 0
    }

    
    @IBAction func minusTenSec(_ sender: AnyObject) {
        
        if numberOfTimers == 1 {
            minusTenSecPushed = true
        }
        else {
            var convertedTimer = Int(timerLabel.text!)!
            convertedTimer -= 10
            let newString:String! = "\(convertedTimer)"
            timerLabel.text = newString
        }
        
    }
    

    @IBAction func addTenSec(_ sender: AnyObject) {
        
        if numberOfTimers == 1 {
            addTenSecPushed = true
        }
        else {
            var convertedTimer = Int(timerLabel.text!)!
            convertedTimer += 10
            let newString:String! = "\(convertedTimer)"
            timerLabel.text = newString
        }
        
    }
    
    
    @IBAction func resetTimerButton(_ sender: AnyObject) {
        
        resetTimer()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

