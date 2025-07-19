import UIKit

//MARK: - Open–closed principle

/* -> Every class, structure, and so on should open for extension but close for modification. Swift has powerful features that align with this principle, one of which is the Extension feature. For instance, if we want to add functionality to the native String structure that Swift provides but don’t have access to modify the String’s code directly, Swift offers us Extensions to add that functionality. When working with custom types, we have the ability to modify the code. However, it’s essential to always keep the Open/Closed principle in mind, avoid common mistakes, and take care when handling our custom types. Also, the Protocols keep the Open/Close principle. */

//Example with Native Type
extension Int {
    func multipleInt(of number: Int) -> Int {
        return self * number
    }
    
    func isNegative() -> Bool {
        if self < 0 {
            return true
        }
        return false
    }
}

let intValue = 99

print(intValue.multipleInt(of: 10)) // 990
print(intValue.isNegative()) // false

//Example with Custome Type

// Bad Example
class Cat1 {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func animalInfo() -> String {
        return "I am Cat and name is \(self.name)"
    }
}

class Fish1 {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func animalInfo() -> String {
        return "I am fish and name is \(self.name)"
    }
}

class AnimalsInfo1 {
    func printData() {
        let cats = [Cat1(name: "Luna"), Cat1(name: "Tina"), Cat1(name: "Moon")]
        
        for cat in cats {
            print(cat.animalInfo())
        }
        
        let fishes = [Fish1(name: "Ishxan"), Fish1(name: "Karas"), Fish1(name: "Sterlec"), Fish1(name: "fish")]
        for fish in fishes {
            print(fish.animalInfo())
        }
    }
}

let infoOfAnimals1 = AnimalsInfo1()
infoOfAnimals1.printData()


// Good Example
protocol Info {
    func animalInfo() -> String
}

class Cat: Info {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func animalInfo() -> String {
        return "I am Cat and name is \(self.name)"
    }
}

class Fish: Info {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func animalInfo() -> String {
        return "I am fish and name is \(self.name)"
    }
}

class AnimalsInfo {
    func printData() {
        let animalsInfo: [Info] = [
                                Cat(name: "Luna"),
                                Cat(name: "Tina"),
                                Cat(name: "Moon"),
                                Fish(name: "Ishxan"),
                                Fish(name: "Karas"),
                                Fish(name: "Sterlec"),
                                Fish(name: "fish")
                            ]
        
        for info in animalsInfo {
            print(info.animalInfo())
        }
    }
}

let infoOfAnimals = AnimalsInfo()
infoOfAnimals.printData()
