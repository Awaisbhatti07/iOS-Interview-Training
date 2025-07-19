import UIKit

// MARK: - Builder Design Pattern in Swift

/*
 
 Builder Pattern means:
 "Creating a complex object step-by-step."
 Just like making a burger or pizza — you add one thing at a time, and when everything is ready, you get the final object.
 
 🔧 Why Use Builder Pattern?
 - Agar aap ke paas aik object hai jisme:
 - Bohat saare optional fields hain
 - Different configurations chahiye hoti hain
 - Aap nahi chahte ke init(...) ke andar 10-15 parameters pass karo
 - To aap Builder pattern ka use karte ho taake:
 - Code clean ho
 - Readable ho
 - Mistake na ho wrong parameter order ki wajah se
 
 ✅ Advantages:
 - Easy to build step by step    You can customize object without big init
 - Avoids long confusing constructors    No more init(name: "", age: 0, email: nil, address: nil...)
 - Fluent interface (chain style)    Looks like: .setName(...).setAge(...)
 - Object is safe and complete before use    No half-made object
 
 ❌ Disadvantages:
 - More boilerplate code    Separate builder class needed
 - Not useful for small/simple objects    Overkill for basic data models
 
 
 
 🔄 Real-Life Example:
 Imagine you're ordering from Pizza Hut:
 First, you choose the base size
 Then you add cheese
 Then toppings
 Then maybe extra sauce
 Only when all parts are added — your custom pizza is ready.
 This is exactly what Builder Pattern does!
 
 */

/*
 🧠 Builder Pattern vs init()
 🔴 Problem with init:
 Socho aap ke paas ye initializer hai:
 */

struct User {
    var name: String
    var age: Int
    var email: String?
    var phone: String?
    var address: String?
}

// Agar aap initializer banate ho:
// init(name: String, age: Int, email: String?, phone: String?, address: String?)

/*
 Toh:
 
 User ko yaad rakhna padega kaunsa parameter kis order mein hai
 
 Bohat saare parameters optional hain
 
 Readability khatam ho jati hai
 
 ✅ Solution: Builder Pattern
 Builder pattern allow karta hai:
 
 Step by step fields set karo
 
 Clear code likho
 
 Mistakes avoid karo
 
 init() ke overloads ya optional chaos se bach jao
 
 🔧 So Builder Pattern Object banaata hai, init ke bajaye
 Yes! Builder pattern object banata hai — lekin direct init() call nahi karne deta.
 Wo build() ke andar init call karta hai — taake user ka kaam asaan ho jaye.
 
 */

// ✅ Let’s fix the example accordingly
// 🔄 More Realistic Version with init() Usage Inside build()
struct Pizza {
    var size: String
    var cheese: Bool
    var pepperoni: Bool
    var mushrooms: Bool
}

// ✅ PizzaBuilder — Ab init use ho raha hai!
class PizzaBuilder {
    private var size: String = "Small"
    private var cheese: Bool = false
    private var pepperoni: Bool = false
    private var mushrooms: Bool = false
    
    func setSize(_ size: String) -> PizzaBuilder {
        self.size = size
        return self
    }
    
    func addCheese() -> PizzaBuilder {
        self.cheese = true
        return self
    }
    
    func addPepperoni() -> PizzaBuilder {
        self.pepperoni = true
        return self
    }
    
    func addMushrooms() -> PizzaBuilder {
        self.mushrooms = true
        return self
    }
    
    func build() -> Pizza {
        // ✅ Now we use init() only once, safely
        return Pizza(
            size: size,
            cheese: cheese,
            pepperoni: pepperoni,
            mushrooms: mushrooms
        )
    }
}

// ✅ Use it:
let pizza = PizzaBuilder()
    .setSize("Large")
    .addCheese()
    .addMushrooms()
    .build()

print(pizza)
