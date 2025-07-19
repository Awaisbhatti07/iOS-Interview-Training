import UIKit

// MARK: - Strategy pattern

/* -
 🧠 What is the Strategy Design Pattern?
 Definition:
 Strategy Pattern is a behavioral design pattern that lets you define a family of algorithms (strategies), put each of them in a separate class, and make them interchangeable at runtime.
 
 🔧 Why Use Strategy Pattern?
 Sometimes, you have a class that can perform an action in multiple different ways, depending on some condition (like user choice or app state). Instead of writing if-else or switch in one class, you move those different logics into separate strategy classes.

 This makes your code:
    - Clean
    - Easy to test
    - Easy to add or change behavior (without touching the core logic)
 
 ✅ Advantages
  - Open/Closed Principle: You can add new strategies without changing old code.
  - No long if-else chains.
  - Easier to test each strategy separately.
  - Reusable strategy classes.

 ❌ Disadvantages
  - More files/classes (each strategy is a separate class).
  - Can be overkill for very simple behavior.

 */

// ✅ Step 1: Protocols
protocol TaxStrategy {
    func calculateTax(for amount: Double) -> Double
}

protocol TaxDescription {
    func taxInfo() -> String
}

class PakistanTax: TaxStrategy, TaxDescription {
    func calculateTax(for amount: Double) -> Double {
        return amount * 0.17
    }
    
    func taxInfo() -> String {
        return "Pakistan - 17% GST"
    }
}

// ✅ Step 2: Strategies per Country
class USATax: TaxStrategy, TaxDescription {
    func calculateTax(for amount: Double) -> Double {
        return amount * 0.10
    }
    
    func taxInfo() -> String {
        return "USA - 10% Sales Tax"
    }
}

class SaudiArabiaTax: TaxStrategy, TaxDescription {
    func calculateTax(for amount: Double) -> Double {
        return 0
    }
    
    func taxInfo() -> String {
        return "Saudi Arabia - No Tax"
    }
}

// ✅ Step 3: BillCalculator Context
class BillCalculator {
    private var taxStrategy: TaxStrategy & TaxDescription

    init(taxStrategy: TaxStrategy & TaxDescription) {
        self.taxStrategy = taxStrategy
    }

    func setStrategy(_ strategy: TaxStrategy & TaxDescription) {
        self.taxStrategy = strategy
    }

    func calculateTotal(for amount: Double) {
        let tax = taxStrategy.calculateTax(for: amount)
        let total = amount + tax
        print("Strategy: \(taxStrategy.taxInfo())")
        print("Original: \(amount), Tax: \(tax), Total: \(total)\n")
    }
}

let pakistan = PakistanTax()
let usa = USATax()
let saudi = SaudiArabiaTax()

let calculator = BillCalculator(taxStrategy: pakistan)
calculator.calculateTotal(for: 1000)

calculator.setStrategy(usa)
calculator.calculateTotal(for: 1000)

calculator.setStrategy(saudi)
calculator.calculateTotal(for: 1000)

/*
 
 Output Below
 
 Strategy: Pakistan - 17% GST
 Original: 1000.0, Tax: 170.0, Total: 1170.0

 Strategy: USA - 10% Sales Tax
 Original: 1000.0, Tax: 100.0, Total: 1100.0

 Strategy: Saudi Arabia - No Tax
 Original: 1000.0, Tax: 0.0, Total: 1000.0

 
 */
