import UIKit

var greeting = "Hello, playground"

var names = ["John", "Aman", "Fig", "Ram", "Sachin", "Akanksha", "Ankur"]
//closure syntax
let reversedNames = names.sorted { (name1:String, name2:String) -> Bool in
    return name1 > name2
}

print(reversedNames)

//function that takes a closure
func somefuncThatTakesAClosure(closure:()->Void) {
    
}
/*closure expression

{ (parameters) -> ReturnType in
    Statements
    
}*/

let sayHello:()->Void = {
    print("say hello")
}

print(sayHello())


// Closure take one parameter and return 1 parameter
let value: (Int) -> Int = { (value1: Int) -> Int in
    return value1
}

print(value(10))

let add: (Int, Int) -> Int = {
    (number1: Int, number2: Int) -> Int in
    
    return number1 + number2
}

print(add(10,20))


func makeSquareOff(digit: Int, onCompletion:(Int) -> Void) {
    let square = digit*digit
    onCompletion(square)
}

makeSquareOff(digit: 9, onCompletion: {
    (value: Int) -> Void in
    
    print("square of 9 is \(value)")
})

makeSquareOff(digit: 18) {
    value in
    
    print("square of 18 is \(value)")
}

let digitsList = [1, 2, 3, 4, 5]

let sum = digitsList.reduce(0) { (value1: Int, value2:Int) -> Int in
    return value1+value2
}
print("Sum \(sum)")
