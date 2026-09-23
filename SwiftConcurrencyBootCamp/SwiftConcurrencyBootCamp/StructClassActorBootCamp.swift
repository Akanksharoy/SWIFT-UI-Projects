//
//  StructClassActorBootCamp.swift
//  SwiftConcurrencyBootCamp
//
//  Created by Akanksha on 21/09/26.
//

/*
 
 Links:
 https://blog.onewayfirst.com/ios/posts/2019-03-19-class-vs-struct/
 https://stackoverflow.com/questions/24217586/structure-vs-class-in-swift-language
 https://medium.com/@vinayakkini/swift-basics-struct-vs-class-31b44ade28ae
 https://stackoverflow.com/questions/24217586/structure-vs-class-in-swift-language/59219141#59219141
 https://stackoverflow.com/questions/27441456/swift-stack-and-heap-understanding
 https://stackoverflow.com/questions/24232799/why-choose-struct-over-class/24232845
 https://www.backblaze.com/blog/whats-the-diff-programs-processes-and-threads/
 https://medium.com/doyeona/automatic-reference-counting-in-swift-arc-weak-strong-unowned-925f802c1b99
 
 VALUE TYPES:
 - Struct, Enum, String, Int, etc.
 - Stored in the Stack
 - Faster
 - Thread safe!
 - When you assign or pass value type a new copy of data is created
 
 REFERENCE TYPES:
 - Class, Function, Actor
 - Stored in the Heap
 - Slower, but synchronized
 - NOT Thread safe (by default)
 - When you assign or pass reference type a new reference to original instance will be created (pointer)
 
 - - - - - - - - - - - - - -
 
 STACK:
 - Stores Value types
 - Variables allocated on the stack are stored directly to the memory, and access to this memory is very fast
 - Each thread has it's own stack!
 
 HEAP:
 - Stores Reference types
 - Shared across threads!
 
 - - - - - - - - - - - - - -
 
STRUCT:
 - Based on VALUES
 - Can be mutated
 - Stored in the Stack!
 
CLASS:
 - Based on REFERENCES (INSTANCES)
 - Stored in the Heap!
 - Inherit from other classes
 
ACTOR:
 - Same as Class, but thread safe!
 
 - - - - - - - - - - - - - -
 
Structs: Data Models, Views
Classes: ViewModels
Actors: Shared 'Manager' and 'Data Stores'

 */

import SwiftUI

struct StructClassActorBootCamp: View {
    var body: some View {
        Text("Hello World")
            .onAppear {
                runTest()
            }
    }
}

#Preview {
    StructClassActorBootCamp()
}
// struct have defaultn initializers
struct MyStruct {
    var title:String
}
// but class do not get default memberwise initializers

extension StructClassActorBootCamp {
    private func runTest() {
        print("test started")
        actorTest1()
    }
    private func structTest1() {
        let objA = MyStruct(title: "starting title")
        print("Object A: \(objA.title)")
        // passed the values of obj a to obj b, we are copying the values to obj b. we are not referencing to the same obj reference
        var objB = objA
        // here the whole previous instance is discarded and new struct is created with new values
        objB.title = "changed title"
        
        print("Object B: \(objB.title)")
        print("Object A: \(objA.title)")
    }
    
    private func classTest1() {
        let objA = MyClass(title: "starting title class")
        print("Object A class: \(objA.title)")
        
        //notice this is let but in case of struct this is var
        let objB = objA
        //here we are not changing the object, but we are changing the title of the object
        objB.title = "changed title class"
        
        print("Object B: \(objB.title)")
        print("Object A: \(objA.title)")
        
    }
    private func actorTest1() {
        Task {
            let objA = MyActor(title: "starting actor class")
            await print("Object A actor: \(objA.title)")
            
            //notice this is let but in case of struct this is var
            let objB = objA
            //here we are not changing the object, but we are changing the title of the object
            await objB.updateTitle(newTitle: "changed title actor")
            
            await print("Object B: \(objB.title)")
            await print("Object A: \(objA.title)")
        }
        
        
    }
}

struct CustomStruct {
    let title:String
    
    func updateTitle(newTitle: String) -> CustomStruct {
        return CustomStruct(title: newTitle)
    }
}

struct MutatingStruct {
    private(set) var title:String
    
    init(title:String) {
        self.title = title
    }
    
    mutating func updateTitle(newTitle:String) {
        self.title = newTitle
    }
}

extension StructClassActorBootCamp {
    private func structTest2() {
        print("Struct test 2")
        
        var struct1 = MyStruct(title: "Title1")
        print("Struct1: ", struct1.title)
        struct1.title = "Title2"
        print("Struct1: ", struct1.title)
        
        var struct2 = CustomStruct(title: "Title1")
        print("Struct2: ", struct2.title)
        struct2 = CustomStruct(title: "Title2")
        print("Struct2: ", struct2.title)
        
        var struct3 = CustomStruct(title: "Title1")
        print("Struct3: ", struct3.title)
        struct3 = struct3.updateTitle(newTitle: "Title2")
        print("Struct3: ", struct3.title)
        
        var struct4 = MutatingStruct(title: "Title1")
        print("Struct4: ", struct4.title)
        struct4.updateTitle(newTitle: "Title2")
        print("Struct4: ", struct4.title)
    }
}

class MyClass {
    var title:String
    init(title: String) {
        self.title = title
    }
    func updateTitle(newTitle:String){
        title = newTitle
    }
}

actor MyActor {
    var title:String
    init(title: String) {
        self.title = title
    }
    func updateTitle(newTitle:String){
        title = newTitle
    }
}

extension StructClassActorBootCamp {
    private func classTest2() {
        print("Class test 2")
        
        var class1 = MyClass(title: "Title1")
        print("Class1: ", class1.title)
        class1.title = "Title2"
        print("Class1: ", class1.title)
        
        let class2 = MyClass(title: "Title1")
        print("class 2:", class2.title)
        class2.updateTitle(newTitle: "Title2")
        print("class 2:", class2.title)

    }
}
