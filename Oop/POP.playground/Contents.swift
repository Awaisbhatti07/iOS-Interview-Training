//
//  ObjectOrientedProgramming.swift
//  InterviewLearning
//
//  Created by Awais Aslam on 7/14/25.
//

import Foundation

// MARK: - ✅ What is Protocol-Oriented Programming (POP)?

/*
 Protocol-Oriented Programming is a programming paradigm that uses protocols (similar to interfaces) to define blueprints for functionality. Instead of focusing on class inheritance, it emphasizes composition over inheritance.

 Apple introduced POP in Swift to promote building flexible and reusable code using protocols, protocol extensions, and value types (like struct and enum), instead of relying solely on classes and inheritance.

 🔑 Key Concepts in POP
 Concept    Description
 protocol    Defines a blueprint of methods, properties, etc.
 protocol extension    Adds default implementations to protocols.
 composition over inheritance    Encourages using multiple protocols instead of subclassing.
 value semantics    POP prefers struct (value type) over class (reference type).
 
 ✅ Why Use Protocol-Oriented Programming?
     Better modularity (you can build small, reusable pieces)
     Avoids tight coupling between types
     Encourages value types (safer, thread-friendly)
     Makes code easier to test and reason about
*/

// MARK: - ✅ Simple Step-by-Step POP Example

/*
 Let’s say you’re building a system where different types of vehicles can drive and honk.
*/

//Step 1: Define a protocol
protocol Drivable {
    var speed: Int { get set }
    func drive()
}

// Step 2: Extend the protocol with default behavior
extension Drivable {
    func drive() {
        print("Driving at \(speed) km/h")
    }
}

// Step 3: Create types (structs) that conform to the protocol
struct Car: Drivable {
    var speed: Int
}

struct Bike: Drivable {
    var speed: Int
}

//Step 4: Use the types
let myCar = Car(speed: 100)
myCar.drive()
// Output: Driving at 100 km/h

let myBike = Bike(speed: 50)
myBike.drive()
// Output: Driving at 50 km/h

// ➡️ You didn’t have to write drive() in each struct — it’s inherited from the protocol extension.

//✅ Protocol with Associated Type
protocol DataStore {
    associatedtype DataType
    func save(data: DataType)
}

struct StringStore: DataStore {
    func save(data: String) {
        print("Saved string: \(data)")
    }
}

//✅ Combining Multiple Protocols (Composition)
// ➡️ This is protocol composition — you can build flexible types without inheritance.
protocol Flyable {
    func fly()
}

protocol Swimmable {
    func swim()
}

struct Duck: Flyable, Swimmable {
    func fly() {
        print("Duck flying")
    }
    
    func swim() {
        print("Duck swimming")
    }
}

/*
 
 ✅ Difference from OOP (Object-Oriented Programming)
 Feature    OOP (Class-based)    POP (Protocol-based)
 Inheritance    Single inheritance    Protocol composition
 Base Type    Class    Struct / Enum / Class
 Code Reuse    Subclassing    Protocol Extensions
 Mutation Behavior    Reference type    Value type
 Apple Recommendation    Less preferred    Preferred in Swift
 
 */

// MARK: - ✅ POP Interview Questions with Answers
/*
 
 Q1: What is Protocol-Oriented Programming in Swift?
 A: POP is a paradigm where protocols and protocol extensions are used to design flexible, modular code. It encourages using value types (struct) and composition instead of class inheritance.

 Q2: What is the benefit of using protocol extensions?
 A: Protocol extensions allow you to provide default method implementations, which makes code reuse easier and reduces boilerplate.

 Q3: How does POP differ from OOP?
 A: OOP focuses on class hierarchies and inheritance, while POP uses protocols and value types for flexibility and code reuse through composition.

 Q4: Can structs conform to protocols in Swift?
 A: Yes, unlike many languages, Swift allows structs, classes, and enums to conform to protocols, making protocols very flexible.

 Q5: What are associated types in protocols?
 A: Associated types act as placeholders within protocols that can be defined when conforming to the protocol. They enable generic functionality.
 
 Example:

 protocol Container {
     associatedtype Item
     func add(item: Item)
 }
 
 */
