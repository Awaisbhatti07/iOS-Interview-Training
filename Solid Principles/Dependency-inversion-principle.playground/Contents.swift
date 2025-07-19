import UIKit

//MARK: - Dependency inversion principle

/* -> The Dependency Inversion Principle (DIP) states that high-level modules should not depend on low-level modules. Instead, they should both depend on abstractions. In other words, you should depend on interfaces, not implementations. */

// -> Bad Example:

// Low-level class: Dog
class Dog1 {
    func bark() {
        print("Woof!")
    }
}

// Low-level class: Cat
class Cat1 {
    func meow() {
        print("Meow!")
    }
}

// High-level class: AnimalSoundMaker
class AnimalSoundMaker1 {
    let dog: Dog1
    let cat: Cat1
    
    init(dog: Dog1, cat: Cat1) {
        self.dog = dog
        self.cat = cat
    }
    
    func makeDogSound() {
        dog.bark()
    }
    
    func makeCatSound() {
        cat.meow()
    }
}

// As you see the “AnimalSoundMaker” is a high-level class that directly depends on the “Dog” and “Cat” classes, which are low-level classes representing specific animals. “AnimalSoundMaker” has separate methods for making dog and cat sounds (makeDogSound() and makeCatSound()), and it directly invokes methods on “Dog” and “Cat” instances. As a result, any change or addition to animal types (adding a new animal like a bird) would require modifications to the “AnimalSoundMaker” class, making it less flexible and harder to maintain.

// -> Good Example:

// Abstraction: Animal
protocol Animal {
    func makeSound()
}

// Low-level class: Dog
class Dog: Animal {
    func makeSound() {
        print("Woof!")
    }
}

// Low-level class: Cat
class Cat: Animal {
    func makeSound() {
        print("Meow!")
    }
}

// High-level class: AnimalSoundMaker
class AnimalSoundMaker {
    let animal: Animal
    
    init(animal: Animal) {
        self.animal = animal
    }
    
    func performSound() {
        animal.makeSound()
    }
}

var dog = Dog()
var animalSoundObj = AnimalSoundMaker(animal: dog)
print(animalSoundObj.performSound())
