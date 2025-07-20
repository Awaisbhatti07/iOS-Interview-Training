import UIKit

// MARK: - 1. Memory Management (ARC)
/*
 
 🔹 What is ARC?
 ARC (Automatic Reference Counting) is how Swift manages memory.
 It keeps track of how many things are using an object. When no one’s using it, the object is automatically removed from memory.
 
 */

// MARK: - 2. Strong, Weak, and Unowned References
/*
 
 🔹 1. Strong Reference (Default)
     This means: The object stays in memory as long as this reference exists.
     It increases the ARC count.
     Most properties are strong by default.

 class Person {
     var phone: Phone? // Strong by default
 }

 class Phone {
     var model = "iPhone"
 }

 let person = Person()
 person.phone = Phone() // Phone stays in memory because person owns it
 
 🔹 2. Weak Reference
 The object can be removed from memory, and this reference becomes nil.
 (Used to avoid memory leaks.)
 
 It doesn’t increase ARC count.
 It automatically becomes nil if the object is destroyed.
 Must be optional (?).

 class Person {
     weak var phone: Phone? // Won’t keep phone alive
 }

 class Phone {
     var model = "iPhone"
 }

 var p: Person? = Person()
 var ph: Phone? = Phone()

 p?.phone = ph

 ph = nil // Now phone inside person is also nil
 🧠 Real-Life Analogy:
 Weak is like saying: “I know that guy, but I won’t stop him from leaving.”

 🔹 3. Unowned Reference
     The object can be removed, but this reference doesn’t become nil —
     it crashes if object is already gone.

     Doesn’t increase ARC count (like weak).
     But crashes if the object is deallocated and then accessed.
     Not optional.

 class Person {
     unowned var phone: Phone // Must always exist
     init(phone: Phone) {
         self.phone = phone
     }
 }

 class Phone {
     var model = "iPhone"
 }
 
 🔁 Summary (1-liner):
 Strong → Keeps the object alive
 Weak → Doesn’t keep it alive, becomes nil when deallocated
 Unowned → Doesn’t keep it alive, but expects it will never be nil
 
 */

// MARK: - 3. Retain Cycle (Common Memory Bug)
/*
 
 Happens when two objects hold strong references to each other, so they never get deallocated — causing a memory leak.
 
 class A {
     var b: B?
 }

 class B {
     var a: A?
 }
 
 ✅ Fix it by making one reference weak or unowned.
 
 ✅ Memory Leaks (How to Check)
 A leak is when memory is not freed because of a retain cycle.

 👀 Use Xcode Instruments → Leaks Tool to find objects that are not deallocating.
 
 */

// MARK: - 4. [weak self] in Closures
/*
 
 Closures capture variables strongly by default, including self.
 If you don’t use [weak self], it can cause a retain cycle.
 
 class MyVC: UIViewController {
     func loadData() {
         fetchData { [weak self] result in
             self?.updateUI()  // self is weak here
         }
     }
     
    // Always use [weak self] inside closures if the closure lives longer than the object — like in async calls, timers, animations, etc.
 }

 */
