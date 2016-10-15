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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func timerTick(){
        
        //print("A second has passed...")
        if (timerLabel.text != nil){
            
            var convertedTimer = Int(timerLabel.text!)
            convertedTimer! -= 1
            let newString = String(describing: convertedTimer)
            timerLabel.text = newString

        }
        else {
            
            timerLabel.text = "210"
        }
        
        
    }
    
    @IBAction func startTimer(_ sender: AnyObject) {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.timerTick), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func pauseTimer(_ sender: AnyObject) {
        timer.invalidate()
    }

    
    @IBAction func minusTenSec(_ sender: AnyObject) {
    }
    

    @IBAction func addTenSec(_ sender: AnyObject) {
    }
    
    
    @IBAction func resetTimer(_ sender: AnyObject) {
        
        timer.invalidate()
        timerLabel.text! = "210"
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

