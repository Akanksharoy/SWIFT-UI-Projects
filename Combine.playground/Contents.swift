import UIKit

import Combine
//below sentecnce is just declaration it does not print anything
let publisher = Just("Hello World")

publisher.sink{
    receivedValue in
    print(receivedValue)
}



let subject = PassthroughSubject<String, Never>()

subject
    .sink { value in
        print(value)
    }

subject.send("Hello")

// multiple values

subject.send("Apple")

subject.send("Banana")

subject.send("Mango")


/*
 What will this print?
 import Combine

 let subject = PassthroughSubject<Int, Never>()

 subject.send(1)

 subject
     .sink {
         print($0)
     }

 subject.send(2)

 subject.send(3)
 
 Answer - 2,3
 
 Does PassthroughSubject remember old values?
 No.
 It has no memory.
 It simply waits for the next value.
 
 A PassthroughSubject does not store any values. It only forwards values to subscribers that are currently listening.
 */


import Combine

let currentValSubject = CurrentValueSubject<Int, Never>(0)

//We didn't call: subject.send(0)

currentValSubject
    .sink {
        print($0) // prints 0 Because CurrentValueSubject already owns a value.

    }

//PassthroughSubject
//Forgets everything.
//CurrentValueSubject
//Always remembers the latest value.

let passsubject = PassthroughSubject<Int, Never>()

passsubject.send(10)
passsubject.send(20)
passsubject.send(30)

passsubject.sink {
    print($0)
}

//Output: Nothing .Because it doesn't remember anything.

let currsubject = CurrentValueSubject<Int, Never>(10)

currsubject.send(20)
currsubject.send(30)

currsubject.sink {
    print($0)
}

//Output:30. Because it remembers the latest value only.

/*
 Q: When would you use CurrentValueSubject instead of PassthroughSubject?
 A strong answer:
 "Use CurrentValueSubject when you always need access to the latest state. New subscribers immediately receive the current value. Examples include login state, selected theme, network connectivity, shopping cart count, or the currently selected user."
 Notice the keyword:
 State
 CurrentValueSubject is excellent for state.
 */

 
