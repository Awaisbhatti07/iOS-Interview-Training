import UIKit

//MARK: - Liskov substitution principle

/* -> Liskov Substitution Principle (LTSY) states that when we inherit from a base class, the subclass should not modify the behavior of the base class functions. Users can utilize both the base class functionality and the child class, which inherits the base class behavior. */

// -> Bad Example
class Operators1 {
    func add(num1: Int, num2: Int) -> Int{
        return num1 + num2
    }
    
    func sub(num1: Int, num2: Int) -> Int{
        return num1 - num2
    }
}

class Calculator1: Operators1 {
    
    override func add(num1: Int, num2: Int) -> Int {
        return num1 * num2
    }
    
    override func sub(num1: Int, num2: Int) -> Int {
        return num1 + num2
    }
}

let add1 = Operators1()
print(add1.add(num1: 5, num2: 5)) // cool works -> 10

let calc1 = Calculator1()
print(calc1.add(num1: 5, num2: 5)) // not working... why? The user is angry. -> 25


// -> Good Example
class Operators {
    func add(num1: Int, num2: Int) -> Int{
        return num1 + num2
    }
    
    func sub(num1: Int, num2: Int) -> Int{
        return num1 - num2
    }
}

class Calculator: Operators {
    override func add(num1: Int, num2: Int) -> Int {
        return num1 + num2
    }
    
    override func sub(num1: Int, num2: Int) -> Int {
        return num1 - num2
    }
    
    
    func add(num1: Int, num2: Int, num3: Int) -> Int{
        return num1 + num2 + num3
    }
}

let add = Operators()
print(add.add(num1: 5, num2: 5)) // cool works -> 10

let calc = Calculator()
print(calc.add(num1: 5, num2: 5)) // cool works -> 10

// also added a new function
print(calc.add(num1: 2, num2: 5, num3: 6))
