import UIKit

// MARK: - Observer pattern

/* -> The Observer pattern is a behavioral design pattern used in software design to allow an object (known as the subject) to maintain a list of its dependents (called observers) and notify them of any state changes, usually by calling one of their methods. This pattern promotes a one-to-many relationship between objects so that when the state of one object changes, all its dependents are informed and updated automatically. 
 
 1- Key Concepts
 SubjectProtocol: The object that holds the state and notifies observers of changes. It has methods for attaching, detaching, and notifying observers.
 ObserverProtocol: The objects that want to be notified when the subject's state changes. Each observer registers with the subject to receive updates.
 ConcreteSubject: A specific implementation of the subject that holds the actual state of interest to observers.
 ConcreteObserver: A specific implementation of an observer that reacts to changes in the subject's state.
 
 
 2- Components
 Subject Interface: Defines methods for attaching, detaching, and notifying observers.
 Observer Interface: Defines the update method that observers must implement.
 ConcreteSubject: Implements the subject interface and maintains state.
 ConcreteObserver: Implements the observer interface and reacts to updates from the subject.
 
 3- Advantages
 Decoupling: Observers are decoupled from the subject, promoting a low degree of coupling between them.
 Flexibility: You can add or remove observers at runtime without modifying the subject.
 Reusability: Observers can be reused with different subjects if they implement the same interface.
 
 4- Disadvantages
 Performance Overhead: Notifying all observers can be time-consuming if there are many observers.
 Memory Leaks: If observers are not properly detached, it can lead to memory leaks, especially in languages with manual memory management.
 Complexity: The pattern can add complexity to the code, especially with many subjects and observers.
 
 */

// Observer protocol
protocol TemperatureObserver: AnyObject {
    func update(temperature: Double)
}

// Subject Protocol
protocol TemperatureSubject: AnyObject{
    func addObserver(_ observer: TemperatureObserver)
    func removeObserver(_ observer: TemperatureObserver)
    func notifyObservers()
}

// Subject class
class TemperatureSensor: TemperatureSubject {
    private var observers = [TemperatureObserver]()
    private var currentTemperature: Double = 0.0
    
    var temperature: Double {
        get {
            return currentTemperature
        }
        set {
            currentTemperature = newValue
            notifyObservers()
        }
    }
    
    func addObserver(_ observer: TemperatureObserver) {
        observers.append(observer)
    }
    
    func removeObserver(_ observer: TemperatureObserver) {
        if let index = observers.firstIndex(where: { $0 === observer }) {
            observers.remove(at: index)
        }
    }
    
    internal func notifyObservers() {
        for observer in observers {
            observer.update(temperature: currentTemperature)
        }
    }
}

// Concrete observer classes
class Display: TemperatureObserver {
    func update(temperature: Double) {
        print("Display: The current temperature is \(temperature)°C")
    }
}

class Alarm: TemperatureObserver {
    func update(temperature: Double) {
        if temperature > 30.0 {
            print("Alarm: Temperature is above 30°C! Current temperature is \(temperature)°C")
        }
    }
}

// Usage
let sensor = TemperatureSensor()

let display = Display()
let alarm = Alarm()

sensor.addObserver(display)
sensor.addObserver(alarm)

sensor.temperature = 25.0
// Output: Display: The current temperature is 25.0°C

sensor.temperature = 35.0
// Output: Display: The current temperature is 35.0°C
// Output: Alarm: Temperature is above 30°C! Current temperature is 35.0°C

sensor.removeObserver(display)
sensor.temperature = 20.0
// Output: Alarm: Temperature is above 30°C! Current temperature is 35.0°C

sensor.removeObserver(alarm)
sensor.temperature = 25.0
// No output, as both observers have been removed



// MARK: - ( ---------------------------- SHORT EXPLANATION -------------------------)

/*
 
 The Observer design pattern is used to establish a one-to-many relationship between objects, so when one object changes its state, all its dependents (observers) are notified and updated automatically.

 Key Idea
 A Subject holds the state and notifies observers of any changes.
 Observers subscribe to the Subject and react to changes.
 
 MARK: - Advantages
 Decoupling: The subject and observers are loosely coupled; they only communicate through a protocol or interface.
 Scalability: You can add or remove observers without modifying the subject.
 Automatic Updates: Observers automatically get notified of state changes.
 
 MARK: - Disadvantages
 Complexity: Managing many observers can make the system more complex and harder to debug.
 Memory Leaks: Strong references can lead to retain cycles if not managed correctly (use weak references).
 Performance Overhead: Notifying a large number of observers can impact performance.
 
 */


// Subject
class Subject {
    private var observers: [Observer] = []
    var state: String = "" {
        didSet {
            notifyObservers()
        }
    }
    
    func addObserver(_ observer: Observer) {
        observers.append(observer)
    }
    
    func removeObserver(_ observer: Observer) {
        observers.removeAll { $0 === observer }
    }
    
    private func notifyObservers() {
        observers.forEach { $0.update(state) }
    }
}

// Observer Protocol
protocol Observer: AnyObject {
    func update(_ state: String)
}

// Concrete Observer
class ConcreteObserver: Observer {
    private let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func update(_ state: String) {
        print("\(name) received update: \(state)")
    }
}

// Usage
let subject = Subject()
let observer1 = ConcreteObserver(name: "Observer 1")
let observer2 = ConcreteObserver(name: "Observer 2")

subject.addObserver(observer1)
subject.addObserver(observer2)

subject.state = "New State!" // Notify observers
// Output:
// Observer 1 received update: New State!
// Observer 2 received update: New State!
