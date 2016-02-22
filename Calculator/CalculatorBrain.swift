//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Mac-lxh on 16/1/17.
//  Copyright © 2016年 Mac-lxh. All rights reserved.
//

import Foundation
class CalculatorBrain
{
    private enum Op:Printable
    {
        case Operand(Double)
        case UnaryOperation(String,Double ->Double)
        case BinaryOperation(String,(Double,Double)->Double)
        
        var description:String{
            get{
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol,_):
                    return symbol
                case .BinaryOperation(let symbol,_):
                    return symbol
                }
            }
        }
    }
    
    private var opStack = [Op]()
    
    private var knowOps = [String:Op]()
    
    init(){
        knowOps["×"] = Op.BinaryOperation("×", *)
        knowOps["÷"] = Op.BinaryOperation("÷") {$1 / $0}
        knowOps["+"] = Op.BinaryOperation("+", +)
        knowOps["−"] = Op.BinaryOperation("−") {$1 - $0}
        knowOps["√"] = Op.UnaryOperation("√", sqrt)
    }
    
    private func evaluate(ops:[Op])-> (result:Double?,remainingOps:[Op])
    {
        if !ops.isEmpty{
            var remainingOps = ops
            let op  = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand,remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                return (operation(operand),operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result{
                    return (operation(operand1,operand2), op2Evaluation.remainingOps)
                    }
                }
            }
            
        }
        return (nil,ops)
    }
    
    func evaluate() -> Double? {
        let (result, _) = evaluate(opStack)
        print("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
    
    func pushOperand(operand:Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol:String){
        if let operation = knowOps[symbol]{
            opStack.append(operation)
        }
        return evaluate()
        
    }
    
}
