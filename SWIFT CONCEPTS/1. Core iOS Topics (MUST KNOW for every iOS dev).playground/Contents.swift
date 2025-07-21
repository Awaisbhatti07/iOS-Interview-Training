import Foundation
import UIKit

/*
 
 ✅ 1. Core iOS Topics (MUST KNOW for every iOS dev)
 
 🧠 Swift Language Mastery
 Value Types vs Reference Types
 ARC (Automatic Reference Counting)
 Struct vs Class
 Closures (capturing values, escaping/non-escaping)
 Protocols, Protocol Inheritance
 Property Observers (willSet/didSet)
 Computed vs Stored Properties
 Generics
 Result Type & Error Handling
 Typealias, Enum with Associated Values

 📲 UIKit Fundamentals
 View Lifecycle
 UIView, UIViewController
 AutoLayout (Programmatic + Storyboard)
 TableView / CollectionView
 Custom Cells
 NavigationController, TabBarController, Modals
 Gesture Recognizers
 UIScrollView & Pagination
 
 */

// MARK: - 1. Value Types vs Reference Types
/*
 Explanation:

 Value Types (e.g., structs, enums): When assigned or passed, a copy is created. Changes to the copy don’t affect the original.
 Reference Types (e.g., classes): Only a reference (pointer) to the object is passed. Changes to the reference affect the original object.
 Why it matters: Value types are safer for data isolation, while reference types are useful for shared state.
 */

// Struct (Value Type)
struct Point {
    var x: Int
    var y: Int
}
var point1 = Point(x: 10, y: 20)
var point2 = point1 // Creates a copy
point2.x = 30
print(point1.x) // Output: 10 (original unchanged)
print(point2.x) // Output: 30

// Class (Reference Type)
class Person {
    var name: String
    init(name: String) { self.name = name }
}
let person1 = Person(name: "Alice")
let person2 = person1 // Points to same object
person2.name = "Bob"
print(person1.name) // Output: Bob (original changed)
print(person2.name) // Output: Bob

// MARK: - 2. ARC (Automatic Reference Counting)
/*
 Explanation:

 ARC automatically manages memory for objects by tracking how many references (pointers) point to an object. When no references exist, the object is deallocated.
 Strong: Default reference, keeps the object alive.
 Weak: Doesn’t keep the object alive, prevents retain cycles (used with optional types).
 Unowned: Like weak but assumes the object always exists, non-optional.
 
 We use the weak keyword in Swift to avoid strong reference cycles (retain cycles) in memory management.
 🔄 What is a strong reference cycle?
 In Swift, when two objects hold strong references to each other, they keep each other alive in memory — even if there are no other references to them. This leads to a memory leak because they can never be deallocated.
 */

class User {
    var name: String
    weak var friend: User? // Weak to avoid retain cycle
    init(name: String) { self.name = name }
    deinit { print("\(name) deallocated") }
}
var user1: User? = User(name: "Alice")
var user2: User? = User(name: "Bob")
user1?.friend = user2
user2?.friend = user1
user1 = nil // Alice deallocated
user2 = nil // Bob deallocated
// Output: Alice deallocated, Bob deallocated

// MARK: - 3. Struct vs Class
/*
 Explanation:

 Struct: Value type, no inheritance, ideal for simple, immutable data (e.g., coordinates, settings).
 Class: Reference type, supports inheritance, used for complex objects with shared state (e.g., view controllers).
 When to use: Use structs for data models, classes for objects needing identity or inheritance.
 */

// Struct
struct Rectangle {
    var width: Double
    var height: Double
    func area() -> Double { width * height }
}
var rect = Rectangle(width: 5, height: 10)
print(rect.area()) // Output: 50.0

// Class
class Vehicle {
    var brand: String
    init(brand: String) { self.brand = brand }
    func drive() { print("\(brand) is driving") }
}
class Car: Vehicle {} // Inheritance
let car = Car(brand: "Toyota")
car.drive() // Output: Toyota is driving

// MARK: - 4. Closures (Capturing Values, Escaping/Non-Escaping)
/*
 Explanation:

 A closure is just a block of code that you can:
 - Save in a variable
 - Pass to a function
 - Run later
 Think of it like a small function that can remember things from where it was created.
 
 - Capturing Values: Closures can use variables from outside their scope, with strong or weak references to avoid retain cycles.
 - Escaping: Closure is stored for later execution (e.g., async tasks).
 - Non-Escaping: Closure is executed immediately within the function.
 
 */

// Simple
let sayHello = {
    print("Hello!")
}

sayHello() // prints: Hello!

// Capturing Values
// Closures can remember variables from outside their block.
var name = "Ali"
let greet = {
    print("Hello, \(name)")
}

greet() // prints: Hello, Ali

name = "Bilal"
greet() // prints: Hello, Bilal

// Retain Cycle Problem (with Closures)
class MyClass {
    var name = "Awais"

    func printName() {
        // weak self = kamzor rishtey se yaad rakhna
        someFunction {
            [weak self] in
            print(self?.name ?? "No name")
        }
    }

    func someFunction(closure: () -> Void) {
        closure()
    }
}

// Escaping Closures
/*
 An escaping closure means:
 "I will run this code later, not now."
 It escapes the function and is used asynchronously.
 */
func fetchData(completion: @escaping () -> Void) {
    // Imagine network call
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        completion() // run closure after 2 seconds
    }
}

// Non-Escaping Closures
/*
 A non-escaping closure means:
 "I will run this code right now, inside the function."
 */
func doSomething(task: () -> Void) {
    task() // runs immediately
}

doSomething {
    print("Doing something now!")
}

// MARK: - 5. Protocols & Protocol Inheritance
/*
 
 Explanation:

 Protocols define a blueprint of methods/properties that types (classes, structs, enums) can adopt.
 Protocol Inheritance: A protocol can inherit from another, combining requirements.
 Used for defining shared behavior across types.
 
 */
protocol Namable {
    var name: String { get }
}
protocol Describable: Namable {
    func describe() -> String
}
struct Dog: Describable {
    var name: String
    func describe() -> String { "Dog named \(name)" }
}
let dog = Dog(name: "Buddy")
print(dog.describe()) // Output: Dog named Buddy

// MARK: - 6. Property Observers (willSet/didSet)
/*
 
 Explanation:

 Property observers monitor changes to a property’s value.
 willSet: Called before the value changes.
 didSet: Called after the value changes.
 Useful for triggering actions when properties change.
 */

struct Temperature {
    var celsius: Double {
        willSet { print("Will change to \(newValue)°C") }
        didSet { print("Changed from \(oldValue)°C") }
    }
}
var temp = Temperature(celsius: 25)
temp.celsius = 30
// Output:
// Will change to 30.0°C
// Changed from 25.0°C

// MARK: - 7. Computed vs Stored Properties
/*
 
 Explanation:

 - Stored Properties: Hold actual data (e.g., a variable).
 - Computed Properties: Calculate their value dynamically using a getter (and optional setter).
 - Computed properties are useful for derived values.
 */

struct Circle {
    // Stored Property
    var radius: Double
    
    // Computed Property
    var area: Double {
        get { 3.14 * radius * radius }
        set { radius = sqrt(newValue / 3.14) }
    }
}
var circle = Circle(radius: 5)
print(circle.area) // Output: 78.5
circle.area = 314
print(circle.radius) // Output: 10.0

// MARK: - 8. Generics
/*
 
 Explanation:

 - Stored Properties: Hold actual data (e.g., a variable).
 - Computed Properties: Calculate their value dynamically using a getter (and optional setter).
 - Computed properties are useful for derived values.
 */

func swapValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}
var x = 5, y = 10
swapValues(&x, &y)
print(x, y) // Output: 10 5

var str1 = "Hello", str2 = "World"
swapValues(&str1, &str2)
print(str1, str2) // Output: World Hello

// MARK: - 9. Typealias & Enum with Associated Values
/*
 
 Explanation:
    Typealias: Creates a shorter name for complex types.
 
    Enum Definition: Enum, short for enumeration, is a type in Swift used to define a group of related values in a type-safe way.
        or
    Enum is a type used to define a group of predefined values — like directions, days, or states — so I can pick one value safely from a fixed set.
 */

typealias CompletionHandler = (Bool, String) -> Void

func loginUser(completion: CompletionHandler) {
    // Do login stuff...
    completion(true, "Login successful")
}

enum Direction {
    case north
    case south
    case east
    case west
}

// Add Associated Values
enum LoginStatus {
    case success(username: String)
    case failure(error: String)
}

// MARK: - 10. Immutable vs Mutable
/*
 
 Explanation
    Immutable: A variable or object that cannot be changed after it's created. Use let in Swift. Think of it as "locked" once set.
    Mutable: A variable or object that can be changed after it's created. Use var in Swift. Think of it as "editable."
    Why it matters: Immutable is safer (prevents accidental changes), while mutable is flexible for data that needs to update.
 
 Structs are value types, so their properties can’t be changed from inside their methods unless you mark the method as mutating.
 
 struct Counter {
     var count = 0

     mutating func increment() {
         count += 1 // 🔧 modifying a property
     }

     mutating func reset() {
         count = 0
     }
 }

 */

// Immutable (let)
let userName = "Alice"
//userName = "Bob" // Error: Cannot change 'let'
print(userName) // Output: Alice

// Mutable (var)
var age = 25
age = 30 // OK: Can change 'var'
print(age) // Output: 30

// Struct with mutable/immutable properties
struct UserPerson {
    let id: Int // Immutable
    var name: String // Mutable
}
var person = UserPerson(id: 1, name: "Alice")
person.name = "Bob" // OK
//person.id = 2 // Error: Cannot change 'id'

// MARK: - 11. All Types of Optionals
/*
 
 Explanation
    
    Basic Optional (?) : A variable that may or may not have a value.
    var name: String? = "Ali"
    print(name) // Optional("Ali")

    Forced Unwrapping (!) : Forcefully get the value from an optional. ❗Be careful — crashes if value is nil.
    var name: String? = "Ali"
    print(name!) // "Ali"
 
    Optional Binding (if let / guard let) : Safely unwrap an optional — only if it has a value.
    if let actualName = name {
     print("Name is \(actualName)")
    } else {
     print("Name is nil")
    }
 
    guard let actualName = name else {
     return
    }
    print("Name is \(actualName)")
 
   Implicitly Unwrapped Optional (! after type) : Like an optional, but assumed to always have a value after being set.
   var name: String! = "Ali"
   print(name) // No need to unwrap ⚠️ Be careful — still crashes if nil
    
   Optional Chaining: Use ? to call properties/methods safely — if the value exists.
   var user: User? = User(name: "Ali")
   print(user?.name) // Prints "Ali" or nil
 
   Nil-Coalescing Operator (??): Provide a default value if optional is nil.
   let finalName = name ?? "Default Name"
 
 */

// MARK: - Layout Updates
/*
 
 Explanation
    Layout Updates in UIKit refer to updating the layout of UI elements (e.g., views, buttons) when something changes,
    like screen size, orientation, or data.

 ✅ Common Layout Update Methods – Easy Explanation
     🔹 1. setNeedsLayout()
     "This tells the system: ‘I’ve changed something; please update the layout soon.’
     It doesn’t update right away, but marks the view as needing layout on the next run cycle."

     🔹 2. layoutIfNeeded()
     "This forces the layout to update immediately if it was marked for update.
     Mostly used when we want to animate layout changes or ensure layout is fresh."

     🔹 3. setNeedsDisplay()
     "This tells the system: ‘I’ve changed how the view looks, please redraw it.’
     It's for redrawing visuals, like custom colors or shapes — not for changing layout."

     🔹 4. layoutSubviews()
     "This is a method we override in custom views to manually set frames of subviews.
     iOS automatically calls it during layout update."
 */

class MyView: UIView {
    
    let button = UIButton()
    let myView = UIView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Adjust subviews
        button.frame = CGRect(x: 20, y: 20, width: 100, height: 40)
    }
    
//    myView.setNeedsLayout()       // Tells the system: please update layout soon
//    myView.layoutIfNeeded()       // Updates layout right now
}

// MARK: - What is lazy in Swift?
/*
 
 Explanation
    lazy means a property is not created (initialized) until it is used for the first time.

 ✅ Why use lazy?
    To save memory and performance
    Useful when the property is expensive to create
    Helpful when you don’t have all the info at init time


 */

class LazyViewController: UIViewController {
    
    lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.text = "Hello, Lazy World!"
        lbl.textColor = .black
        return lbl
    }()
}

// Here, label will not be created when the class is initialized. It will be created only when it's accessed, like: view.addSubview(label) // Now it's created

// MARK: - What is Delegate in Swift?
/*
 
 Explanation
    Delegate is a way to pass data or messages from one screen (object) to another, usually from child to parent. -> One-to-one communication from child to parent.

 🔧 Why use it?
     To inform parent about something that happened in the child.
     To keep code separate and clean.
     To reuse code (make components reusable).

 Why weak in delegate?
    👉 To avoid memory leaks (retain cycles) between parent and child.

 */

// MARK: - What is NotificationCenter in Swift?
/*
 
 Explanation
 You want to broadcast data or event to multiple observers.

 🔧 Why use it?
    Loose coupling (e.g., update multiple screens after login).

 */

// MARK: - KVC (Key-Value Coding) & KVO (Key-Value Observing)
/*
 
 🔹 KVC – Set/Get property using strings
     person.setValue("Ali", forKey: "name")
     let name = person.value(forKey: "name") as? String

 🔹 KVO – Observe property changes (Old way)
        A mechanism to observe property changes and perform actions automatically when values change.

 */

// -------------------------------------------------------------------------------------------------------- //

// MARK: - 📲 UIKit Fundamentals

// MARK: - 1. View Lifecycle
 
/*
 
 Explanation:

 A UIViewController has lifecycle methods that manage its view’s creation, appearance, and destruction.
 Key methods: viewDidLoad, viewWillAppear, viewDidAppear, viewWillDisappear, viewDidDisappear.
 Used to set up UI, load data, or clean up resources.

 */

class MyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View loaded")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View will appear")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("View appeared")
    }
}
// Output when view is shown:
// View loaded
// View will appear
// View appeared

// MARK: - 2. UIView & UIViewController
 
/*
 
 Explanation:

 UIView: The base class for all UI elements (e.g., buttons, labels).
 UIViewController: Manages a view hierarchy and handles user interactions.
 Together, they form the foundation of iOS UI.

 */

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 20))
        label.text = "Hello, UIKit!"
        view.addSubview(label)
    }
}
// Displays a label with "Hello, UIKit!" on the screen


// MARK: - 3. AutoLayout (Programmatic + Storyboard)
 
/*
 
 Explanation:

 AutoLayout defines flexible layouts using constraints to position/size UI elements.
 Programmatic: Create constraints in code.
 Storyboard: Visually set constraints in Interface Builder.
 Ensures UI adapts to different screen sizes.

 */

class AutoLayoutController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton()
        button.setTitle("Click Me", for: .normal)
        button.backgroundColor = .blue
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
// Centers a button on the screen

// MARK: - 4. TableView & CollectionView
 
/*
 
 ✅ Difference Between TableView and CollectionView (iOS)
 1. Layout:
    - UITableView shows data in a single vertical column.
    - UICollectionView is more flexible — it supports multiple columns, rows, grids, and custom layouts.

 2. Scrolling Direction:
    - UITableView scrolls vertically only.
    - UICollectionView can scroll vertically or horizontally depending on the layout.

 3. Cell Types:
    - UITableViewCell is used with UITableView.
    - UICollectionViewCell is used with UICollectionView.

 4. Section Support:
    - Both support sections, but UICollectionView gives more flexibility in designing headers, footers, and custom sections.

 5. Customization:
    - UITableView is easier and quicker to set up for simple list-based UIs.
    - UICollectionView is used when you need complex or dynamic layouts like grids, carousels, or Pinterest-style layouts.

 6. Performance:
    - Both are highly optimized for performance and reusable cells.

 7. Use Case Examples:
    - Use UITableView for chat lists, settings screens, or simple data lists.
    - Use UICollectionView for photo galleries, product grids, Instagram feeds, etc.

 */


// MARK: - 5. Custom Cells
/*
 
 Explanation:

 Custom cells allow you to design reusable, styled table/collection view cells.
 Created via code or Storyboard, often with custom UI elements.

 */

// MARK: - 6. NavigationController, TabBarController, Modals
/*
 
 Explanation:
    UINavigationController: Manages a stack of view controllers (e.g., back/forward navigation).
    UITabBarController: Manages multiple view controllers with a tab bar.
    Modals: Present a view controller on top of another (e.g., alerts, forms).

 */

// MARK: - 7. Gesture Recognizers
/*
 
 Explanation:

 Gesture recognizers detect user interactions like taps, swipes, or pinches.
 Attach them to views to handle gestures.
 
 ✅ Different Types of Gestures in iOS (UIKit)
 1. Tap Gesture (UITapGestureRecognizer)
 Triggered when the user taps the screen with one or more fingers.
 👉 Example: Single tap to open, double tap to zoom.

 2. Long Press Gesture (UILongPressGestureRecognizer)
 Triggered when the user touches and holds the screen.
 👉 Example: Show options on long press (like delete or copy).

 3. Swipe Gesture (UISwipeGestureRecognizer)
 Triggered when the user swipes in a specific direction — up, down, left, or right.
 👉 Example: Swipe left to delete an item in a list.

 4. Pan Gesture (UIPanGestureRecognizer)
 Triggered when the user drags their finger across the screen.
 👉 Example: Move a view around or handle custom drag-and-drop.

 5. Pinch Gesture (UIPinchGestureRecognizer)
 Triggered when the user uses two fingers to zoom in or out (like in maps or photos).
 👉 Example: Zoom in/out on images.

 6. Rotation Gesture (UIRotationGestureRecognizer)
 Triggered when the user rotates two fingers around a point.
 👉 Example: Rotate a view or image.

 7. Screen Edge Pan Gesture (UIScreenEdgePanGestureRecognizer)
 Triggered when the user swipes in from the edge of the screen.
 👉 Example: Slide to go back or open a side menu.

 */

// MARK: - 8. UIScrollView & Pagination
/*
 
 Explanation:
     UIScrollView: Allows scrolling content larger than the screen.
     Pagination: Divides content into pages, often used with scroll views.
     Useful for galleries or onboarding screens.

 */

// MARK: - 9. AppDelegate vs SceneDelegate in iOS — Explained Simply for Interviews
/*
 
 Explanation:
     
    ✅ AppDelegate (Before iOS 13)
 
     Responsibility      Example
     App launch/setup    didFinishLaunchingWithOptions
     App goes to background/foreground    applicationDidEnterBackground
     Handling push notifications    didRegisterForRemoteNotifications
     Universal Links, etc.    Handled in AppDelegate

 ✅ SceneDelegate (iOS 13+)
 
     Responsibility    Example
     Creating UI on launch    scene(_:willConnectTo:)
     Scene enters background    sceneDidEnterBackground(_:)
     Scene becomes active/inactive    sceneDidBecomeActive(_:)
 
 */
