//
//  HigherOrderfunctions.swift
//  SwiftfulThinkingContLearning
//
//  Created by Akanksha on 08/07/26.
//

let numbers = [1,6,3,4,5,10,2,11,9,16,24]

let sortedArray = numbers.sorted(by: {(firstNumber:Int, secondNumber:Int ) -> Bool in
    return firstNumber < secondNumber
})
