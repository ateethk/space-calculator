//
//  ViewController.swift
//  calculator
//
//  Created by Ateeth Kosuri on 8/20/16.
//  Copyright © 2016 Ateeth Kosuri. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLabel: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftString = ""
    var rightString = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLabel.text = runningNumber
    }
    
    @IBAction func onDividePress(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPress(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPress(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualsPress(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                
                rightString = runningNumber
                runningNumber = ""
            
                if currentOperation == Operation.Multiply {
                result = "\(Double(leftString)! * Double(rightString)!)"
                } else if currentOperation == Operation.Divide {
                result = "\(Double(leftString)! / Double(rightString)!)"
                } else if currentOperation == Operation.Add {
                result = "\(Double(leftString)! + Double(rightString)!)"
                } else if currentOperation == Operation.Subtract {
                result = "\(Double(leftString)! - Double(rightString)!)"
                }
            
                leftString = result
                outputLabel.text = result
                
            }
            
            currentOperation = op
            
        }
        else {
            leftString = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    @IBAction func clearPressed(sender: AnyObject) {
        runningNumber = ""
        leftString = ""
        rightString = ""
        currentOperation = Operation.Empty
        outputLabel.text = ""
    }
    

}

