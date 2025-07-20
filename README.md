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

✅ 2. Advanced UIKit + UI Management
Diffable Data Sources

Compositional Layout

Dynamic Cell Heights

Advanced AutoLayout (Constraints Priority, hugging/compression)

Custom Transitions & Animations

Accessibility & Dark Mode Support

✅ 3. Memory Management (ARC)
Strong, Weak, Unowned

Retain Cycles

Memory Leaks (using Instruments)

[weak self] inside closures

✅ 4. Multithreading & Concurrency
GCD (DispatchQueue, DispatchGroup, DispatchWorkItem)

Operation & OperationQueue

Thread Safety

async/await (Swift 5.5+)

Actor (Swift Concurrency)

✅ 5. Design Patterns in iOS
Har interview mein ek na ek poocha jata hai:

MVC, MVP, MVVM, MVVM+C

Singleton

Delegate

Observer (NotificationCenter)

Factory

Builder

Coordinator Pattern (Very Common)

Dependency Injection

✅ 6. Data Persistence
UserDefaults

Codable

FileManager

CoreData (Fetch, Insert, Delete, Relationships, NSPredicate)

Realm (optional, if asked)

Keychain (for secure storage)

✅ 7. Networking
URLSession (DataTask, UploadTask)

Codable with JSON

Alamofire (usage & pros/cons)

Combine (for newer Swift versions)

API Error Handling

Retry logic, Exponential Backoff

Request Throttling

SSL Pinning (Security)

✅ 8. SwiftUI (if job demands)
Views, Modifiers, State Management

Binding, ObservedObject, EnvironmentObject

NavigationStack

List, LazyVStack/HStack

Combine with SwiftUI

✅ 9. Testing
Unit Testing (XCTest)

UI Testing (XCUI)

Dependency Injection for Testing

Mocking/Stubbing

Code Coverage Tools

✅ 10. Architecture & Code Quality
Clean Architecture

SOLID Principles

DRY/KISS/YAGNI

Modularisation

Feature Flags

Code Review Best Practices

Project Structure & Foldering

✅ 11. App Lifecycle & Background Tasks
App States (active, background, suspended)

SceneDelegate vs AppDelegate

Background Fetch

Push Notifications & Remote Notification handling

Silent Pushes

✅ 12. Security
Keychain

Biometric Auth (FaceID/TouchID)

HTTPS, App Transport Security

SSL Pinning

Jailbreak Detection (Basic level)

✅ 13. Instruments & Performance
Time Profiler

Memory Graph

Zombie Objects

FPS Monitoring

Leaks Detection

Battery Usage Optimization

✅ 14. App Store & Deployment
Code Signing, Provisioning Profiles

.ipa, TestFlight

App Store Review Guidelines

App Size Optimization

Build Phases, Schemes, Configurations

✅ 15. Version Control (Git)
Rebase vs Merge

Branching Strategy (Git Flow)

Pull Requests & Code Review

Git Hooks (optional but advanced)

✅ 16. Soft Skills / HR Round
Projects you’re proud of

Handling conflicts with team

Code review feedback response

Why you want to switch?

Future goals?

Time management / task estimation

✅ 17. System Design (For senior-level roles)
How would you design:

Instagram Feed?

Offline-first App?

Chat App?

File Upload App?

Consider:

Caching Strategy

Data Sync

Scalable Architecture

✅ 18. Bonus: iOS Interview Questions (MCQ or Theory Style)
What is the difference between @escaping and @autoclosure?

How does weak self prevent retain cycles?

Why use protocol-oriented programming?

Difference between value type and reference type?

How ARC works in Swift?

Diffable Data Source vs Traditional Source

URLSession vs Alamofire?

---------------------------------------

✅ Objective-C Topics to Cover for iOS Interviews
🔹 1. Objective-C Basics
Objective-C file types: .h, .m, .mm

Class structure: Interface & Implementation

Properties (@property, @synthesize, @dynamic)

Instance and class methods (- vs +)

Import vs Include (#import, #include)

id, instancetype, self, super

Data types: NSString, NSArray, NSDictionary, etc.

🔹 2. Memory Management
ARC (Automatic Reference Counting)

Manual Retain Release (MRC) – just basic idea

Keywords: strong, weak, assign, copy, retain

Retain cycles and how to avoid them

🔹 3. Messaging System
objc_msgSend

[object method] – dynamic message dispatch

Difference from Swift's static dispatch

🔹 4. Categories and Extensions
Category syntax

Why use categories?

Limitations (e.g. can't add properties)

Class Extensions (private methods)

🔹 5. Protocols and Delegates
Protocol declaration and conformance

@optional, @required

How delegation works

Weak delegate to avoid retain cycles

🔹 6. Blocks (Closures in ObjC)
Block syntax

__strong vs __weak inside blocks

Passing blocks as parameters

Block retain cycles (__weak / __block usage)

🔹 7. Selectors and Runtime
What is a Selector (SEL)

performSelector, respondsToSelector

@selector(methodName)

Dynamic method resolution

🔹 8. KVC & KVO
Key-Value Coding (valueForKey, setValue:forKey)

Key-Value Observing (observeValueForKeyPath)

Use in data binding / table reloads

🔹 9. NS Class Family
NSString / NSMutableString

NSArray / NSMutableArray

NSDictionary / NSMutableDictionary

NSNumber, NSValue

NSData, NSDate, NSURL

🔹 10. Bridging with Swift
Bridging Header

Calling ObjC from Swift

Calling Swift from ObjC (@objc, @objcMembers)

NS_ASSUME_NONNULL_BEGIN & nullability annotations

🔹 11. Multithreading in ObjC
GCD in Objective-C syntax

NSOperation & NSOperationQueue

🔹 12. Error Handling
NSError objects

try/catch in ObjC

Method returning with NSError **

🔹 13. Runtime & Introspection
isKindOfClass, isMemberOfClass

respondsToSelector

objc runtime functions (optional)

🔹 14. Design Patterns in ObjC
Singleton (dispatch_once)

Delegate

Observer (NSNotificationCenter)

MVC

🔹 15. Project Structure
How to add Objective-C files to a Swift project

Using .pch files (Precompiled Headers)

Framework imports in ObjC

Optional (Nice to Know)
Method Swizzling (Advanced runtime)

objc_setAssociatedObject

NSProxy (Advanced Proxy pattern)

Macros & Constants
