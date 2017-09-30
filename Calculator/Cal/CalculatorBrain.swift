//
//  CalculatorBrain.swift
//  Cal
//
//  Created by 김예진 on 2017. 9. 28..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import Foundation


class CalculatorBrain {
    
    private var accumulator = 0.0
    
    func setOperand(operand : Double) {
        accumulator = operand
    }
    
    var operations : Dictionary<String,Operation> = [
        "AC" : Operation.Delete,
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnariOperation(sqrt),
        "cos" : Operation.UnariOperation(cos),
        "sin" : Operation.UnariOperation(sin),
        "tan" : Operation.UnariOperation(tan),
        "±" : Operation.UnariOperation({-$0}),
        "×" : Operation.BinaryOperation({$0 * $1}),
        //"×" : Operation.BinaryOperation({op1:Double,op2 : Double} -> Double in return op1 * op2),
        "÷" : Operation.BinaryOperation({$0 / $1}),
        "+" : Operation.BinaryOperation({$0 + $1}),
        "−" : Operation.BinaryOperation({$0 - $1}),
        "=" : Operation.Equals
    ]
    
    enum Operation {
        case Constant(Double)
        case UnariOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
        case Delete
    }
    
    private var pending : pendingBinaryOperationInfo?
    
    struct pendingBinaryOperationInfo {
        var binaryFunction : (Double,Double) -> Double
        var firstOperand : Double
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand,accumulator)
            pending = nil
        }
    }
    
    func performOperation(symbol : String) {
        /*
         switch(symbol) {
         case "π" : accumulator = M_PI
         case "√" : accumulator = sqrt(accumulator)
         default : break
         }
         */
        
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value) :
                accumulator = value
            case .UnariOperation(let function) :
                accumulator = function(accumulator)
            case .BinaryOperation(let function) :
                executePendingBinaryOperation()
                pending = pendingBinaryOperationInfo(binaryFunction: function,firstOperand: accumulator)
            case .Equals :
                executePendingBinaryOperation()
            case .Delete :
                accumulator = 0.0
                pending = nil
            }
        }
    }
    
    var result : Double {
        get {
            return accumulator
        }
    }
}
