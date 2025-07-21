//
//  ObjectOrientedProgramming.swift
//  InterviewLearning
//
//  Created by Awais Aslam on 7/14/25.
//

import Foundation

// MARK: - ✅ What is OOP?

/*
 Object-Oriented Programming (OOP) is a way to structure code using objects.
 These objects are created from classes and contain:

 - Data (properties)
 - Behavior (methods)

 🔑 4 Pillars of OOP:
 1. Encapsulation – Hides internal details, exposes only what's necessary.
 2. Inheritance – One class inherits from another.
 3. Polymorphism – Same method behaves differently in different classes.
 4. Abstraction – Shows essential features, hides complex ones.
*/

// MARK: - ✅ What is Class and Object?

/*
 Class: A blueprint for creating objects. Defines properties and methods.
 Object: An instance of a class. Represents a real-world entity.
*/

// MARK: - ✅ Class, Struct, Actor Difference

/*
 Class  → A reference type that supports inheritance and is used when you want shared, mutable state.
 
 🔹 Reference Types:
 - Classes, Actors
 - Stored as references (pointers).
 - When you assign or pass to a function, it points to the same object in memory.
 
 /*
  class PersonClass {
      var name: String
      init(name: String) {
          self.name = name
      }
  }

  let p3 = PersonClass(name: "Sara")
  let p4 = p3
  p4.name = "Zara"

  print(p3.name)  // Zara
  print(p4.name)  // Zara
  */
 
 Struct → A lightweight value type, good for modeling simple data that doesn’t need to be shared or mutated across instances.
 
 🔹 Value Types:
 Structs, Enums, Tuples
 Copied when assigned to a new variable or passed to a function.
 Each copy is independent.
 
 /*
  struct PersonStruct {
      var name: String
  }

  var p1 = PersonStruct(name: "Awais")
  var p2 = p1
  p2.name = "Ali"

  print(p1.name)  // Awais
  print(p2.name)  // Ali
  
  struct Counter {
      var value = 0

      mutating func increment() {
          value += 1
      }
  }
  Only needed in struct to modify self.
  */
 
 Actor  → A special reference type that ensures thread-safe, isolated state — used in concurrent or async code to prevent data races.
 
        OR
  
  An actor is like a class, but it's safe to use in concurrent (multi-tasking) code. It prevents two things from changing data at the same time.
*/

// MARK: - ✅ Struct Example (Value Type)
struct PersonStruct {
    var name: String
}

// MARK: - ✅ Class Example (Reference Type)
class PersonClass {
    var name: String
    init(name: String) {
        self.name = name
    }
}

// MARK: - ✅ Actor Example (Thread-Safe Reference Type)
actor Counter {
    private var value = 0

    func increment() {
        value += 1
    }

    func getValue() -> Int {
        return value
    }
}

// MARK: - ✅ Base Class, Derived Class, Concrete, Abstract, Final

/*
 🔹 Base Class (Super/Parent Class)
 A general class that other classes can inherit from.

 🔹 Derived Class (Sub/Child Class)
 A class that inherits from another and adds/overrides behavior.

 🔹 Concrete Class
 A fully implemented class you can create objects from.

 🔹 Abstract Class (Not native in Swift)
 Conceptual only — used as a blueprint. Can be mimicked via protocols or unimplemented methods.

 🔹 Final Class
 Cannot be inherited. Use `final` keyword.
*/

class Animal {
    func makeSound() {
        print("Some sound")
    }
}

class Dog: Animal {
    override func makeSound() {
        print("Bark")
    }
}

class Car {
    func drive() {
        print("Driving...")
    }
}

final class Utility {
    func log() {
        print("Logging")
    }
}

/*
 // MARK: - 🔑 Access Levels in Swift (from most open to most restricted):
 
 🔹 1. open
 - Can be accessed and subclassed outside the module (framework, app).
 - Only used for frameworks.
 
 open class Animal {
     open func sound() {
         print("Generic sound")
     }
 }

 🔹 2. public
 Can be accessed outside the module, but cannot be subclassed or overridden outside.
 public class Vehicle {
     public func start() {
         print("Vehicle started")
     }
 }

 🔹 3. internal (default)
 Accessible within the same module/app, not outside.
 class Student {
     func study() {
         print("Studying")
     }
 }

 🔹 4. fileprivate
 Accessible only inside the same file.
 fileprivate class Helper {
     func doWork() {
         print("File-private work")
     }
 }

 🔹 5. private
 Accessible only inside the same scope/block (like a class or struct).
 class BankAccount {
     private var balance = 1000

     func showBalance() {
         print("Balance: \(balance)")
     }
 }
 */

/*
 
 MARK: - ✅ Final, Static, and Class Keywords in Swift
 
 🔹 final
 Use when you want to lock a class or method to prevent inheritance.
 final class Logger {
     func logMessage() {
         print("Final class cannot be subclassed")
     }
 }

 class Animal {
     final func sound() {
         print("Final method cannot be overridden")
     }
 }

 🔹 static
 Defines a method/property on the type itself, not an instance.
 Cannot be overridden in subclasses.
 
 class Math {
     static func square(_ x: Int) -> Int {
         return x * x
     }
 }

 let result = Math.square(4)  // Output: 16
 
 🔹 class (used with methods/properties)
 Defines a type-level method like static, but can be overridden in subclasses.
 
 class Shape {
     class func describe() {
         print("I'm a shape")
     }
 }

 class Circle: Shape {
     override class func describe() {
         print("I'm a circle")
     }
 }

 Shape.describe()   // I'm a shape
 Circle.describe()  // I'm a circle

 Summary:
 Use static when you don’t want to allow overriding.

 Use class when you want to allow subclasses to override.

 Use final when you want to prevent both subclassing or overriding.
 */

// MARK: - ✅ Can You Call Base Class Method Without Instantiating?

/*
 Yes, if:
 - The method is marked as `static`
 - Or the method is accessed through a subclass
*/

// MARK: - ✅ Access Modifiers

/*
 Yes, if:
 - The method is marked as `static`
 - Or the method is accessed through a subclass
*/

// MARK: - ✅ Encapsulation

/*
 Encapsulation = Hiding internal data + exposing only needed info using Access Modifiers

 ✅ How to Achieve:
 - Keep properties `private`
 - Use public getter/setter methods

 ✅ Benefits:
 - Protects data
 - Easier to update code later
 - Encourages clean and reusable code
*/

class Student {
    private var name: String = ""

    func getName() -> String {
        return name
    }

    func setName(_ newName: String) {
        if !newName.isEmpty {
            name = newName
        }
    }
}

// MARK: - ✅ Inheritance

/*
 Inheritance = Inheritance allows one class to reuse and extend the properties and methods of another class.
 
 ➡️ In Swift, a class can inherit from another class (called the superclass) to avoid code duplication and share functionality.

 ✅ Purpose of Usage:
 - Code Reusability – Share common behavior among multiple classes.
 - Polymorphism Support – Use a parent type to refer to child instances (useful in OOP design).
 
 ✅ How to Achieve:
 - Keep properties `private`
 - Use public getter/setter methods

 ✅ Advantages:
 - Reuse existing code (DRY principle)
 - Easier to maintain and extend
 - Encourages hierarchy and logical grouping

 ❌ Disadvantages:
 - Tight coupling (child depends on parent)
 - Can lead to complex, hard-to-manage hierarchies
 - Not as flexible as composition in some cases
*/

class Vehicle {
    func startEngine() {
        print("Engine started")
    }
}

class Car2: Vehicle {
    func playMusic() {
        print("Playing music")
    }
}

// MARK: - ✅ Polymorphism

/*
 Polymorphism = Polymorphism means "many forms" — It allows objects of different classes to be treated as if they are of the same superclass type, and the correct method is called based on the actual object at runtime.
 
    OR
 
 Polymorphism = Polymorphism lets you write one function call that can behave differently depending on the object — even if they share the same base class.
 
 👉 Basically: One interface, many implementations.
 
 👉 Matlab:
    Tum SonyTV ya SamsungTV dono ko TV (parent class) type ke object ki tarah treat kar sakte ho.

 let tv: TV = SonyTV()
 Yahan tv ka type TV hai, lekin actual object SonyTV hai.

 ✅ 2. Purpose of Usage
 - Write flexible and reusable code
 - Call subclass methods using a superclass reference
 - Helps with code generalization, especially in arrays, functions, protocols, etc.
 
 ✅ 3. How to Achieve Polymorphism in Swift
    There are two types of polymorphism in Swift:
        - Compile-time (Static) – via method overloading (limited in Swift)
        - Runtime (Dynamic) – via method overriding + superclass reference

    To fully achieve runtime polymorphism, you need:

    -Inheritance
    -Method overriding
    -Superclass reference or type (or protocol)

 ✅ 4. Advantages & Disadvantages
 ✅ Advantages:
   - Code becomes more abstract and reusable
   - Easier to extend behavior in future
   - Improves maintainability

 ❌ Disadvantages:
     - Can be hard to trace which method gets called at runtime
 
 ❓ Interview Trick Question You Were Asked
 "Kya sirf overriding likhne se polymorphism ho jati hai?"

 Correct response:

 ❌ Nahi, sirf override likhne se polymorphism nahi hoti.

 ✅ Polymorphism tab hoti hai jab superclass ka reference ya type use kar ke subclass ka object call ho — aur method runtime pe resolve ho.

 So yes, overriding is necessary, but not sufficient.

 Full runtime polymorphism =
 🔹 Inheritance +
 🔹 Method overriding +
 🔹 Superclass (or protocol) reference

 🔄 Real-Life Feel:
 Same tarah:
    - Aik manager sab employees ko "do work" bolta hai
    - Designer design karta hai
    - Developer code karta hai
    - Tester test karta hai
    - Sabko doWork() bola — lekin kaam alag alag → Polymorphism
 
 -> Next ye dekhna hai k polymoriphisam via protocol base
 
*/

// Superclass - Remote knows how to press power button
class TV {
    func pressPowerButton() {
        print("TV is turning ON/OFF")
    }
}

// Subclass - Sony TV ka apna behavior
class SonyTV: TV {
    override func pressPowerButton() {
        print("Sony TV Power toggled")
    }
}

// Subclass - Samsung TV ka apna behavior
class SamsungTV: TV {
    override func pressPowerButton() {
        print("Samsung TV Power toggled")
    }
}

/*
 
 // MARK: - ✅ Abstraction
 Abstraction means hiding the complex implementation details and only showing the essential features of an object or functionality.

 🧠 Think of it like using a TV remote — you press the button to change the channel, but you don't know or care how the circuit inside works.
 
 ✅ 2. Purpose of Usage
 To simplify complex systems.

 To allow programmers to work with high-level logic without worrying about low-level code.

 To ensure separation of concerns — so that logic and usage stay independent.

 ✅ 3. Why We Use It
 We use abstraction to:

 Hide complexity: Users don’t need to know how something works, only how to use it.

 Reduce code duplication: Share interfaces or base behavior.

 Improve code maintainability: Changing the internal logic doesn’t affect users of that abstraction.

 Enable polymorphism: Treat different types with a common interface.

 ✅ 4. Advantages and Disadvantages
 ✅ Advantages:
 Feature    Description
 🔹 Simplification    Makes code easier to understand and maintain.
 🔹 Reusability    Shared functionality across multiple classes.
 🔹 Flexibility    Internal logic can be changed without affecting external usage.
 🔹 Security    Hides sensitive or complex data from outside access.

 ❌ Disadvantages:
 Feature    Description
 ⚠️ Overhead    May introduce more layers or files.
 ⚠️ Too much abstraction    Can make debugging harder or code harder to trace.
 ⚠️ Learning curve    Beginners may find abstract layers confusing initially.
 
 */

// MARK: - Abstraction using Protocol

// 1. Define an abstract layer (Protocol)
protocol Vehicle1 {
    func startEngine()
    func stopEngine()
}

// 2. Concrete implementation (Real car logic)
class Car1: Vehicle1 {
    func startEngine() {
        print("Car engine started with key ignition.")
    }

    func stopEngine() {
        print("Car engine stopped.")
    }
}

// 3. Another implementation
class ElectricScooter: Vehicle1 {
    func startEngine() {
        print("Scooter started with electric power.")
    }

    func stopEngine() {
        print("Scooter stopped.")
    }
}

// Other Example
// Abstract layer (protocol)
protocol PaymentMethod {
    func makePayment(amount: Double)
}

// Credit Card Payment
class CreditCardPayment: PaymentMethod {
    func makePayment(amount: Double) {
        print("Processing credit card payment of $\(amount)...")
        // Complex logic hidden: API call, card validation etc.
    }
}

// PayPal Payment
class PayPalPayment: PaymentMethod {
    func makePayment(amount: Double) {
        print("Redirecting to PayPal for payment of $\(amount)...")
        // Hidden: OAuth, redirect, confirm payment
    }
}

// Apple Pay Payment
class ApplePayPayment: PaymentMethod {
    func makePayment(amount: Double) {
        print("Paying $\(amount) using Apple Pay...")
        // Hidden: Touch ID, Face ID, wallet checks
    }
}

// Checkout system using abstraction
class Checkout {
    var paymentMethod: PaymentMethod

    init(paymentMethod: PaymentMethod) {
        self.paymentMethod = paymentMethod
    }

    func processPayment(for amount: Double) {
        paymentMethod.makePayment(amount: amount)
    }
}

/*
 
 MARK: - ✅ What is Composition over Inheritance?
 
 Composition means building a class by combining smaller parts (objects or behaviors), instead of inheriting from another class.
 
 🧠 In simple words:

 "A class has something" instead of "is something."
 
 ✅ Why Prefer Composition?
 Because inheritance has limitations:

 Tight coupling: Subclass depends on superclass behavior.

 Fragile hierarchy: One change in parent affects all children.

 Inflexibility: Swift doesn't support multiple inheritance.

 Code reuse: Harder to reuse just one behavior.

 Composition is:

 Modular

 Reusable

 Easier to test

 Better for separation of concerns
 
 🧠 Interview Tip:
 If asked:

 ❓"Why would you choose composition over inheritance?"

 Say:

 I prefer composition because it promotes flexibility and loose coupling. Instead of forcing a class into a hierarchy it may not belong in, I can build behavior with protocols, mix them as needed, and maintain better separation of concerns.
 
 */

// 📌 Example: Inheritance (not ideal)
class Bird {
    func fly() {
        print("Flying...")
    }
}

class Penguin: Bird {
    // ❌ Problem: Penguins can't fly, but inherit fly()
}

// ✅ Better Design: Composition
protocol Flyable {
    func fly()
}

protocol Swimmable {
    func swim()
}

extension Flyable {
    func fly() {
        print("Flying...")
    }
}

extension Swimmable {
    func swim() {
        print("Swimming...")
    }
}

class Eagle: Flyable { }

class Penguin2: Swimmable { }

class Duck: Flyable, Swimmable { }

/*
 
 MARK: - ✅ What is Dependency Injection (in Simple Words)?
 
 Dependency Injection means giving an object what it needs to work — instead of the object creating it by itself.
 
 🧠 Easy way to remember:
 "Don’t cook your own food — get it delivered."

 The object doesn’t make its own tools — they are provided from outside. This keeps your code cleaner and easier to test.
 
 */

// 1. Define Protocol (Abstraction)
protocol Notifier {
    func send(message: String)
}

// 2. Concrete implementations
class EmailNotifier: Notifier {
    func send(message: String) {
        print("📧 Email sent: \(message)")
    }
}

class SMSNotifier: Notifier {
    func send(message: String) {
        print("📱 SMS sent: \(message)")
    }
}

// 3. Class that depends on Notifier
class AlertService {
    private let notifier: Notifier   // 🧩 Dependency

    // Dependency Injection via initializer
    init(notifier: Notifier) {
        self.notifier = notifier
    }

    func triggerAlert() {
        notifier.send(message: "Warning! Battery low.")
    }
}


// MARK: - 🔄 Testing Examples
struct ObjectOrientedProgramming {

    static func testStruct() {
        var person1 = PersonStruct(name: "Awais")
        var person2 = person1  // Copy is made

        person2.name = "Bob"

        print("Person1:", person1.name)  // Output: Awais
        print("Person2:", person2.name)  // Output: Bob
    }

    static func testClass() {
        let person3 = PersonClass(name: "Alice")
        let person4 = person3  // Same reference

        person4.name = "Bob"

        print("Person3:", person3.name)  // Output: Bob
        print("Person4:", person4.name)  // Output: Bob
    }

    static func testActor() {
        let counter = Counter()

        Task {
            await counter.increment()
            let current = await counter.getValue()
            print("Counter:", current)
        }
    }

    static func testEncapsulation() {
        let student = Student()
        student.setName("Alice")
        print("Student Name:", student.getName())  // Output: Alice
    }
    
    static func testInheritance() {
        let myCar = Car2()
        myCar.startEngine()
        myCar.playMusic()
    }
    
    static func testRunTimePolymorphism() {
        // Remote ke pass TV ka reference hai, lekin actual TV model alag ho sakta hai
        let myTV1: TV = SonyTV()
        let myTV2: TV = SamsungTV()

        myTV1.pressPowerButton()  // Output: Sony TV Power toggled
        myTV2.pressPowerButton()  // Output: Samsung TV Power toggled
    }
    
    static func testAbstraction() {
        // 4. Usage
        func startAnyVehicle(vehicle: Vehicle1) {
            vehicle.startEngine()
        }

        let myCar = Car1()
        let myScooter = ElectricScooter()

        startAnyVehicle(vehicle: myCar)
        startAnyVehicle(vehicle: myScooter)
        
        /*
         Car engine started with key ignition.
         Scooter started with electric power.
         */
    }
    
    static func testAbstraction2(){
        
        // Usage
        let creditCard = CreditCardPayment()
        let paypal = PayPalPayment()
        let applePay = ApplePayPayment()

        let checkout1 = Checkout(paymentMethod: creditCard)
        checkout1.processPayment(for: 100.0)

        let checkout2 = Checkout(paymentMethod: paypal)
        checkout2.processPayment(for: 250.0)

        let checkout3 = Checkout(paymentMethod: applePay)
        checkout3.processPayment(for: 59.99)

        /*
         Processing credit card payment of $100.0...
         Redirecting to PayPal for payment of $250.0...
         Paying $59.99 using Apple Pay...
         */
    }
    
    static func testComposition() {
        let eagle = Eagle()
        eagle.fly()  // ✅ Flying...

        let penguin = Penguin2()
        penguin.swim()  // ✅ Swimming...

        let duck = Duck()
        duck.fly()   // ✅ Flying...
        duck.swim()  // ✅ Swimming...
    }
    
    static func testDependencyInjcection() {
        let emailService = AlertService(notifier: EmailNotifier())
        emailService.triggerAlert()
        // Output: 📧 Email sent: Warning! Battery low.

        let smsService = AlertService(notifier: SMSNotifier())
        smsService.triggerAlert()
        // Output: 📱 SMS sent: Warning! Battery low.
        
        /*
         
         🧠 Easy way to remember:
         "Don’t cook your own food — get it delivered."

         The object doesn’t make its own tools — they are provided from outside. This keeps your code cleaner and easier to test.
         
         */
    }
}
