import UIKit

// MARK: - Singleton Design Pattern in Swift

/*
 
 The Singleton pattern ensures that a class has only one instance and provides a global point of access to it. It's useful for scenarios where exactly one object is needed to coordinate actions (e.g., a shared network manager or a database connection).
 
// MARK: - Advantages
 
 1- Single Instance: Ensures only one instance exists, saving memory and avoiding redundant objects.
 2- Global Access: Easy to access from anywhere in the app via Singleton.shared.
 3- Controlled Access: Centralized control ensures consistent behavior throughout the app.

 // MARK: - Disadvantages
 
 1- Global State Risks: Sharing state globally can make debugging harder.
 2- Testing Difficulties: Singleton dependencies can make unit testing more complex.
 3- Overuse: If used excessively, it can lead to tight coupling and reduced flexibility in the code.
 
 */

class Singleton {
    static let shared = Singleton() // The single instance

    private init() { } // Private initializer prevents others from creating instances

    func doSomething() {
        print("Singleton instance is working!")
    }
}

// Usage:
Singleton.shared.doSomething()
