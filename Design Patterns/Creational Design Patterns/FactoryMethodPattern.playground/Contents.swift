import UIKit

// MARK: Factory Method

/*
 
 MARK: - Defination:
 
 The Factory Method Design Pattern is a creational design pattern that provides an interface for creating objects but lets subclasses alter the type of objects that will be created. Instead of directly instantiating objects using init, the factory method delegates the responsibility of object creation to a method, which can be overridden by subclasses.
 
 Factory Method ek aisa design pattern hai jo humein naye objects banane ka tareeqa deta hai bina yeh bataye ke kaunsi class ka object banega. Isme ek method faisla karta hai ke kis qisam ka object banaya jaye, input ya condition ke mutabiq.

 Aasan Alfaaz mein:
 Yeh aise hai jaise ek restaurant mein aap order dete hain (method ko call karte hain), aur restaurant khud faisla karta hai ke aapke order ke mutabiq kis qisam ka khana (object) banega.
 
 MARK: - Advantages:
 
 1- Flexibility: Allows the creation of objects without specifying the exact class.
 2- Scalability: Makes it easy to introduce new types without modifying existing code.
 3- Encapsulation: Encapsulates the object creation logic in one place.
 
 MARK: - Disadvantages:
 
 1- Increased Complexity: Adds an extra layer of abstraction, which might be unnecessary for simple use cases.
 
 2- Subclassing Requirement: Requires subclasses to implement the factory method, which can make the code harder to manage.
 
 substitue is dependency injection
 
 class DrawingApp {
     private let shape: Shape
     
     init(shape: Shape) {
         self.shape = shape
     }
     
     func draw() {
         shape.draw()
     }
 }

 // Provide the dependency externally:
 let app = DrawingApp(shape: Circle())
 app.draw()
 
 Advantages:

 No factory needed; simplifies code.
 Easily testable and promotes loose coupling
 
 */

import Foundation

// Step 1: Define a common interface or superclass
protocol Animal {
    func speak() -> String
}

// Step 2: Create concrete implementations
class Dog: Animal {
    func speak() -> String {
        return "Woof!"
    }
}

class Cat: Animal {
    func speak() -> String {
        return "Meow!"
    }
}

// Step 3: Create a Factory Protocol
protocol AnimalFactory {
    func createAnimal() -> Animal
}

// Step 4: Implement Factory Method in Subclasses
class DogFactory: AnimalFactory {
    func createAnimal() -> Animal {
        return Dog()
    }
}

class CatFactory: AnimalFactory {
    func createAnimal() -> Animal {
        return Cat()
    }
}

// Usage
let dogFactory: AnimalFactory = DogFactory()
let dog = dogFactory.createAnimal()
print(dog.speak())  // Output: "Woof!"

let catFactory: AnimalFactory = CatFactory()
let cat = catFactory.createAnimal()
print(cat.speak())  // Output: "Meow!"


