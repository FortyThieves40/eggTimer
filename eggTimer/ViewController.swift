//
//  ViewController.swift
//  eggTimer
//
//  Created by carole lang on 10/14/16.
//  Copyright © 2016 Dana Young. All rights reserved.
//
//Need to add check again hitting zero

import UIKit
import AVFoundation

class ViewController: UIViewController {


    @IBOutlet weak var timerLabel: UILabel!
    
    var timer = Timer()
    // counter to ensure no more than one timer is running at any given point
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
            if convertedTimer >= 1 {
                if minusTenSecPushed == true, addTenSecPushed == false {
                    // added if to account to below zero issue
                    if convertedTimer > 10 {
                        minusTenSecPushed = false
                        convertedTimer -= 10
                        
                    }
                    else {
                        // add end timer func here
                        minusTenSecPushed = false
                        endOfTimerEvent()
                        return
                    }
                }
                else if minusTenSecPushed == false, addTenSecPushed == true{
                    addTenSecPushed = false
                    convertedTimer += 10
                
                }
                else{
                    convertedTimer -= 1
                }
                let newString:String! = "\(convertedTimer)"
                timerLabel.text = newString
            }
            else if convertedTimer <= 0{
                endOfTimerEvent()
            }
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
    
    // call inside of timeTick
    func endOfTimerEvent(){
        
        if numberOfTimers == 1 {
            timer.invalidate()
            numberOfTimers = 0
            //add sound event on end of alarm
        }
        
        timerLabel.text! = "0"
        timerLabel.blink()
        let when = DispatchTime.now() + 3 // change 3 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            print("stop blinking")
            self.timerLabel.stopBlink()
        }
        
        let setLabelDelay = DispatchTime.now() + 3.5 // change 3.5 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: setLabelDelay) {
            print("bring back 0")
            self.timerLabel.alpha = 1.0
        }
    }
    
    
    @IBAction func startTimer(_ sender: AnyObject) {

        if numberOfTimers < 1 {
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
            if convertedTimer >= 10 {
                convertedTimer -= 10
                let newString:String! = "\(convertedTimer)"
                timerLabel.text = newString
            }
            else if convertedTimer >= 1, convertedTimer <= 9{
                endOfTimerEvent()
            }
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

extension UILabel {
    func blink() {
            self.textColor = UIColor.red
            self.alpha = 0.0;
            UIView.animate(withDuration: 0.5,
            delay: 0.0,
            options: [.curveEaseInOut, .autoreverse, .repeat],
            animations: { [weak self] in self?.alpha = 1.0 },
            completion: { [weak self] _ in self?.alpha = 0.0 })
    }
}

extension UILabel {
    func stopBlink() {
        layer.removeAllAnimations()
        self.textColor = UIColor.black
    }
}


