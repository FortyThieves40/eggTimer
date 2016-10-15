//
//  ViewController.swift
//  eggTimer
//
//  Created by carole lang on 10/14/16.
//  Copyright © 2016 Dana Young. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var timerLabel: UILabel!
    
    var timer = Timer()
    var numberOfTimers = 0
    
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
            convertedTimer -= 1
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
    }
    

    @IBAction func addTenSec(_ sender: AnyObject) {
    }
    
    
    @IBAction func resetTimerButton(_ sender: AnyObject) {
        
        resetTimer()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

