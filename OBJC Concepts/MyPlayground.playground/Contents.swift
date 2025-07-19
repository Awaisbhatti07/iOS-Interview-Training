import UIKit

/*
 
 MARK: - ---------------- References ------------------
 
 https://coderpad.io/interview-questions/objective-c-interview-questions/
 
 https://www.devopsschool.com/blog/top-50-objective-interview-questions-and-answers/
 
 
 MARK: - Explain the concept of properties in Objective-C.
 
 In Objective-C, properties provide a convenient way to encapsulate the state of an object and define the getter and setter methods to access and modify that state. They are declared using the @property syntax and can have attributes like nonatomic, strong, weak, etc.
 
 In Objective-C, atomic and nonatomic are used to describe how properties are handled when they are accessed by multiple threads. Here’s the difference in simple words:

 Atomic:
 1- Ensures thread safety for property access.
 2- Only one thread can read or write to the property at a time.
 3- It’s the default behavior if you don’t specify nonatomic.
 4- Slower because it adds a lock/unlock mechanism for every access.
 5- Example: Useful if you want the value to always be consistent when accessed by multiple threads.
 
 Nonatomic:
 1- Does not ensure thread safety.
 2- Multiple threads can read/write the property at the same time.
 3- Faster because there’s no locking involved.
 
 Example: Useful for properties where performance is critical, and you handle thread safety elsewhere.
 
 @property (atomic, strong) NSString *name;  // Thread-safe
 @property (nonatomic, strong) NSString *name;  // Faster, not thread-safe

 Key Takeaway:
 1- Use atomic if you need thread safety and consistency for property access.
 2- Use nonatomic if you care about speed and can manage thread safety manually.
 
 readonly: Indicates that the property can be read but not written to. The compiler generates a getter method but no setter method.
 
 readwrite: Indicates that the property can be both read and written to. This is the default attribute if none is specified.
 
 nonatomic: Specifies that the property is not thread-safe and can be accessed from multiple threads simultaneously without synchronization. It improves performance but can lead to data corruption in a multithreaded environment.
 
 atomic: Specifies that the property is thread-safe and ensures that access is synchronized. It provides data integrity in a multithreaded environment but can impact performance.
 
 weak: Specifies a weak reference to the property. The reference is automatically set to nil when the referenced object is deallocated. It helps to avoid strong reference cycles.
 
 strong/retain: Specifies a strong reference to the property, retaining the referenced object. The reference count of the object is increased.
 
 copy: Specifies that the property should make a copy of the assigned value when set. It is commonly used for NSString and block properties to ensure immutability and avoid mutability issues.
 
 getter=/setter=: Allows customizing the getter and setter method names for the property.
 
 
 // MARK: - Explain class definition in Objective-C?
 
 A class definition begins with the keyword @interface followed by the interface (class) name, and the class body, closed by a pair of curly braces.  In Objective-C, all classed are retrieved from the base class called NSObject. It gives basic methods like memory allocation and initialization.
 
 // MARK: - When would you use NSArray and NSMutableArray?

 NSArray: You will use an NS array when data in the array don’t change. For example, the company name you will put in NS Array so that no one can manipulate it.
 
 NSMutableArray: This array will be used in an array when data in an array will change. For instance, if you are passing an array to function and that function will append some elements in that array then you will choose NSMutable Array.
 
 // MARK: - Explain how the class “IMPLEMENTATION” is represented in Objective-C?
 
 In Objective-C the class “ IMPLEMENTATION” is represented with @implementation directive and ends with @end.
 
 // MARK: - What is id?
 
 id is a pointer to any type, but unlike void * it always points to an Objective-C object. For example, you can add anything of type id to an NSArray, but those objects must respond to retain and release .
 
 // MARK: - Does Objective-C have function overloading?
 
 objective-C does not support method overloading, so you have to use different method names.
 
 // MARK: - What is the role of the @autoreleasepool
 
 The @autoreleasepool block in Objective-C is used to manage the autorelease pool, which is responsible for managing autoreleased objects. Autoreleased objects are those whose memory will be automatically released at the end of the current run loop iteration.
 
 */
