//
//  ViewController.swift
//  Calculator
//
//  Created by Mac-lxh on 15/12/27.
//  Copyright © 2015年 Mac-lxh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        }else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber{
            enter()
        }
        /*
        switch operation {
        case "×": preformOperation({$0*$1})
        case "÷": preformOperation({$1/$0})
        
        case "+":preformOperation({$0+$1})
            
        case "−":preformOperation({$1-$0})
            
        default:break
        */
        if  let operation = sender.currentTitle!{
            if let result = brain.performOperation(operation){
                displayValue = result
            }else{
                displayValue = 0
            }
            
        }
    }
    
    /*
    func preformOperation(operation:(Double,Double)->Double){
        if operandStack.count >= 2 {
           displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
        
    } 
    */
    
    var operandStack = Array<Double>()
    
    
    @IBAction func enter() {
        
        userIsInTheMiddleOfTypingANumber = false
      //  operandStack.append(displayValue)
      // print("operandStack = \(operandStack)")
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        }else{
            displayValue = 0
        }
    }
    
    
    var displayValue:Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
            
        }
        set{
            display.text = "\(newValue)"
            //userIsInTheMiddleOfTypingANumber = false
            
        }
        
    }
    
}

