import UIKit

// MARK: - Abstract Factory

/*
 
 MARK: - Defination
 
 The Abstract Factory Design Pattern provides an interface for creating families of related or dependent objects without specifying their concrete classes. It is a creational design pattern that helps ensure that objects are compatible and adhere to a particular family of types.
 
 The Abstract Factory Design Pattern
 is a creational design pattern that provides an interface (or factory) to create related or dependent objects without specifying their exact concrete classes.
 
 
 Factory Method:
 Focus: Creates a single product.
 How It Works: Relies on inheritance. Subclasses override a factory method to specify the type of object that will be created.
 Use Case: When you need to delegate the instantiation of an object to subclasses.
 Example: A ShapeFactory that has methods like createCircle() or createRectangle() to create specific types of shapes.
 
 Abstract Factory:
 Focus: Creates families of related products.
 How It Works: Provides an interface to create multiple related or dependent objects without specifying their concrete classes.
 Use Case: When you need to create a group of related products that must be used together (e.g., a theme or a platform-specific GUI).
 Example: An AbstractFactory for a GUI toolkit might create both Button and Checkbox objects. Each concrete factory (e.g., WindowsFactory, MacOSFactory) creates platform-specific versions of these.
 
 Simplified Analogy:
 
 Factory Method: "Here's a machine that makes only chairs."
 Abstract Factory: "Here's a machine that makes chairs, tables, and sofas, all belonging to the same furniture style."
 
 MARK: - Advantages
 
 1- Consistency: Ensures that a family of related objects is created together.
 2- Scalability: Adding new families of products is easier since you only need to create a new factory.
 3- Separation of Concerns: The client code is isolated from the concrete implementation of the objects.
 
 Disadvantages
 
 1- Complexity: Adding layers of abstraction can make the code harder to read and maintain.
 2- Rigid Structure: Adding new product types (not families) may require changes to the abstract factory interface.
 
 */

// Abstract product protocols
protocol Chair {
    var material: String { get }
    func sitOn()
}

protocol Table {
    var shape: String { get }
    func use()
}

// Concrete product classes
class ModernChair: Chair {
    var material: String = "Plastic"
    func sitOn() {
        print("Sitting on a modern plastic chair.")
    }
}

class ModernTable: Table {
    var shape: String = "Rectangle"
    func use() {
        print("Using a modern rectangular table.")
    }
}

class VictorianChair: Chair {
    var material: String = "Wood"
    func sitOn() {
        print("Sitting on a Victorian wooden chair.")
    }
}

class VictorianTable: Table {
    var shape: String = "Oval"
    func use() {
        print("Using a Victorian oval table.")
    }
}

// Abstract factory protocol
protocol FurnitureFactory {
    func createChair() -> Chair
    func createTable() -> Table
}

// Concrete factories
class ModernFurnitureFactory: FurnitureFactory {
    func createChair() -> Chair {
        return ModernChair()
    }
    func createTable() -> Table {
        return ModernTable()
    }
}

class VictorianFurnitureFactory: FurnitureFactory {
    func createChair() -> Chair {
        return VictorianChair()
    }
    func createTable() -> Table {
        return VictorianTable()
    }
}

// Client code
func clientCode(factory: FurnitureFactory) {
    let chair = factory.createChair()
    let table = factory.createTable()
    chair.sitOn()
    table.use()
}

// Usage
print("Modern Furniture:")
clientCode(factory: ModernFurnitureFactory())

print("\nVictorian Furniture:")
clientCode(factory: VictorianFurnitureFactory())

/*
 
 MARK: - Explanation of Code
 
 Abstract Products: Chair and Table define the interfaces that all concrete products must implement.
 Concrete Products: ModernChair, ModernTable, VictorianChair, VictorianTable are specific implementations of the abstract products.
 Abstract Factory: FurnitureFactory defines methods to create abstract products (Chair and Table).
 Concrete Factories: ModernFurnitureFactory and VictorianFurnitureFactory create specific product families (modern or Victorian).
 Client Code: Works with factories and products through their abstract interfaces, ensuring flexibility and scalability.
 
 */
