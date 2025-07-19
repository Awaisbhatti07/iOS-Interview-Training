import UIKit

//MARK: - Interface segregation principle

/* -> The Interface Segregation Principle states that users should not depend on interfaces or functionality they don’t need. It advises against providing overly complex or hard-to-understand interfaces. The interface should be easy and should not contain complex elements that the user cannot understand or use. */

// -> Bad Example
protocol Animals1 {
    func eat()
    func fly()
    func swim()
}

class Flamingo1: Animals1 {
    func eat() {
        print("I can eat")
    }
    
    func fly() {
        print("I can fly")
    }
    
    func swim() {
        print("I can swim")
    }
}

class Dogs1: Animals1 {
    func eat() {
        print("I can eat")
    }
    
    func fly() {
        print("I cannot fly")
        fatalError()
    }
    
    func swim() {
        print("I cannot swim")
        fatalError()
    }
}

// As you can see, the ‘Flamingo’ and ‘Dogs’ classes conform to the ‘Animals’ protocol. However, the ‘Dogs’ class, which cannot fly and swim, has been overloaded with unnecessary functionality. This approach is not recommended. I’ve provided a simple example, but you can apply the same evaluation to your UIKit classes to determine if you are overloading them.


// -> Good Example
protocol Flyable {
    func fly()
}

protocol Swimmable {
    func swim()
}

protocol Feedable {
    func eat()
}

class Flamingo: Flyable, Swimmable, Feedable  {
    func eat() {
        print("I can eat")
    }
    
    func fly() {
        print("I can fly")
    }
    
    func swim() {
        print("I can swim")
    }
}

class Dogs: Feedable {
    func eat() {
        print("I can eat")
    }
}

//I’ve created three separate protocols to eliminate unnecessary overloading. The Flamingo can fly, swim, and eat for that reason the “Flamingo” class conforms to three protocols those are “Flyable”, “Swimmable”, and “Feedable” but the “Dogs” cannot fly and swim for that reason the “Dogs” class to conform only “Feedable” protocol.
