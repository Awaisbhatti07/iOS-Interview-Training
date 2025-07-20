import UIKit

// MARK: - Classes
/*
 
 Key Features:

 - Reference type: Multiple variables can reference the same instance.
 - Inheritance: Supports inheritance, enabling a hierarchy of classes.
 - ARC-managed memory: Instances are managed by Automatic Reference Counting (ARC) for memory management.
 - Mutability: Instances can be mutable or immutable (depending on whether properties are defined as let or var).
 - Identity: Classes have a unique identity (=== can be used to compare references).
 
 Use Cases:

 - When you need shared, mutable state.
 - For complex hierarchies using inheritance or polymorphism.
 - When ARC (reference counting) is needed for lifecycle management
 
 */

class Vehicle {
    var name: String
    init(name: String) {
        self.name = name
    }
}

let car1 = Vehicle(name: "Car")
let car2 = car1 // Both reference the same object
car2.name = "Truck"
print(car1.name) // Output: "Truck"


// MARK: - Structs
/*
 
 Key Features:

 - Value type: Each variable gets its own unique copy.
 - No inheritance: Cannot inherit from other structs.
 - Stack-allocated: Typically more efficient for smaller data types.
 - Copy-on-write semantics: When passed around, a new copy is created unless explicitly shared.
 - Immutability by default: Mutating a struct’s properties requires marking the method as mutating.
 
 Use Cases:

 - When you want immutability and thread safety by default.
 - For simple data models that don’t require inheritance.
 - For performance-sensitive scenarios where avoiding ARC overhead is crucial.
 
 */

struct Point {
    var x: Int
    var y: Int
    
    mutating func moveBy(dx: Int, dy: Int) {
        x += dx
        y += dy
    }
}

var point1 = Point(x: 0, y: 0)
var point2 = point1 // Copy of `point1`
point2.moveBy(dx: 5, dy: 5)
print(point1.x) // Output: 0

// MARK: - Actors

/*
 
 Key Features:

 - Reference type: Similar to classes, actors are reference types.
 - Concurrency safety: Provides a built-in way to manage data across multiple threads safely.
 - Isolation: Protects mutable state by serializing access to its properties and methods.
 - No inheritance: Does not support class-style inheritance but can adopt protocols.
 - Asynchronous interactions: Designed to be used with await.
 
 Use Cases:

 - When working with shared mutable state in concurrent environments.
 - For encapsulating state that needs to be accessed from multiple threads.
 
 */

actor BankAccount {
    private var balance: Int = 0

    func deposit(amount: Int) {
        balance += amount
    }

    func getBalance() -> Int {
        return balance
    }
}

let account = BankAccount()
Task {
    await account.deposit(amount: 100)
    print(await account.getBalance()) // Output: 100
}

// MARK: - Protocols with Associated Types

/*
 
 Protocols can declare associated types, which are placeholders for a concrete type that will be specified by the conforming type. These are useful for defining relationships between types in protocols.

 Key Features:

- Declared with the associatedtype keyword.
- Enable protocols to define flexible type relationships.
- Conforming types determine the actual type for the associated type.
 
 // MARK: - Advantages:

 1- Allow polymorphism and generality for various types that conform to the protocol.
 2- Useful for designing APIs with complex type relationships.
 
 // MARK: - Limitations:

 1- Erasure required for heterogeneous collections (Any or type erasure needed).
 2- Can't use protocols with associated types directly as the type of a variable without type erasure.
 
 */

protocol Container {
    associatedtype Item
    var items: [Item] { get }
    mutating func add(item: Item)
}

struct IntContainer: Container {
    var items = [Int]()
    mutating func add(item: Int) {
        items.append(item)
    }
}

struct StringContainer: Container {
    var items = [String]()
    mutating func add(item: String) {
        items.append(item)
    }
}
