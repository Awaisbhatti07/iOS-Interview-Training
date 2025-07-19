import UIKit

/*
 
 🧠 What is the Decorator Pattern?
 ✅ Definition:
 Decorator Pattern lets you add new behavior or features to an existing object without modifying its original structure or class.
 It wraps the original object inside another object that adds new functionality.

 🎯 Why Use Decorator Pattern?
 Imagine you want to add features to a class (like a coffee object), but:

 You don’t want to change the original class code.

 You may want to add features dynamically at runtime.

 You want to stack multiple features (like add sugar, milk, cream etc.)

 Instead of creating dozens of subclasses (CoffeeWithMilkAndSugarAndCream... 😩), we decorate the base class with different feature wrappers. ✨
 
 ✅ Advantages:
 Follows Open/Closed Principle    Add new features without modifying existing code
 More flexible than inheritance    No need for huge subclass trees
 Dynamic behavior    You can add/remove features at runtime

 ❌ Disadvantages:
 More classes    Each feature becomes a new class
 Complex to understand    Multiple layers of decorators can confuse new developers
 
 */

protocol Notifier {
    func send(message: String)
}

class BasicNotifier: Notifier {
    func send(message: String) {
        print("Sending basic message: \(message)")
    }
}

class NotifierDecorator: Notifier {
    private let wrapped: Notifier

    init(wrapped: Notifier) {
        self.wrapped = wrapped
    }

    func send(message: String) {
        wrapped.send(message: message)
    }
}

// Step 4: Extra Features (Decorators)
class EmailNotifier: NotifierDecorator {
    override func send(message: String) {
        super.send(message: message)
        print("Also sending Email: \(message)")
    }
}

class PushNotifier: NotifierDecorator {
    override func send(message: String) {
        super.send(message: message)
        print("Also sending Push Notification: \(message)")
    }
}

let basic = BasicNotifier()
// Just basic message
basic.send(message: "Hello Awais!")
// Output: Sending basic message: Hello Awais!

// Add email decorator
let email = EmailNotifier(wrapped: basic)
// Now: text + email
email.send(message: "Meeting at 5")
// Output:
// Sending basic message: Meeting at 5
// Also sending Email: Meeting at 5

// Add push notification too
let fullNotifier = PushNotifier(wrapped: email)
// Now: text + email + push
fullNotifier.send(message: "Server down!")
// Output:
// Sending basic message: Server down!
// Also sending Email: Server down!
// Also sending Push Notification: Server down!


