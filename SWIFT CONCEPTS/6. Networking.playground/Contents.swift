import UIKit

// MARK: - Networking
/*
 
 URLSession (DataTask, UploadTask)

 Codable with JSON

 Alamofire (usage & pros/cons)

 Combine (for newer Swift versions)

 API Error Handling

 Retry logic, Exponential Backoff

 Request Throttling

 SSL Pinning (Security)
 
 */

 // MARK: - URLSession:

/*
 
 Used for: Making HTTP requests natively.
 📌 URLSession.dataTask (GET, POST)
 
 let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
 let task = URLSession.shared.dataTask(with: url) { data, response, error in
     if let data = data {
         let users = try? JSONDecoder().decode([User].self, from: data)
         print(users ?? [])
     } else {
         print("❌ Error: \(error?.localizedDescription ?? "Unknown")")
     }
 }
 task.resume()

 let request = URLRequest(url: URL(string: "https://api.example.com/upload")!)
 let fileData = Data() // your file data here

 let task = URLSession.shared.uploadTask(with: request, from: fileData) { data, response, error in
     if let error = error {
         print("Upload failed: \(error)")
     }
 }
 task.resume()

 ✅ Pros
 Native, no dependency

 Great with Codable, Combine

 Fine control over caching, timeout, headers

 ❌ Cons
 Verbose syntax

 No built-in retries, error formatting, JSON handling abstraction
 
 */

// MARK: - Codable with JSON:

/*

 Used with URLSession to parse JSON into Swift structs.
 
 struct User: Codable {
     let name: String
     let email: String
 }

 let user = try JSONDecoder().decode(User.self, from: jsonData)

 ✅ Interview Tip: Explain how Codable combines both Encodable + Decodable.
 
 Codable is a type alias in Swift that combines two proto
 typealias Codable = Encodable & Decodable
 
 So when you declare a model as Codable, you're telling the compiler:
 “This model can both encode itself into formats like JSON (Encodable) and decode itself from them (Decodable).”
 
*/

// MARK: - Alamofire

/*

 Third-party HTTP library for cleaner syntax and powerful features.
 
 import Alamofire

 AF.request("https://api.example.com/users")
   .validate()
   .responseDecodable(of: [User].self) { response in
     switch response.result {
     case .success(let users):
         print(users)
     case .failure(let error):
         print("Request failed: \(error)")
     }
 }

*/

// MARK: - Combine (Networking + Reactive Programming)

/*

 Combine is a framework by Apple that helps you manage asynchronous code (like API calls, timers, text field inputs) using Publishers and Subscribers.

     Handle asynchronous code
     Chain events
     React to user input
     Handle networking, timers, and UI bindings in a declarative way
 
 🔑 Combine Main Components
 
 Publisher    Something that sends data over time, like a text field or API.
 Subscriber    Something that receives the data and reacts to it.
 Operators    Steps that change or filter the data (like map, filter).
 Subject    Special publisher you control manually (PassthroughSubject, CurrentValueSubject)
 @Published    SwiftUI property that auto-updates UI when value changes.
 AnyCancellable    A token that stores your subscription and cancels it when no longer needed.
 
 ✅ Basic Combine Flow
 
 URLSession.shared.dataTaskPublisher(for: URL(string: "https://api.example.com/users")!)
     .map(\.data)
     .decode(type: [User].self, decoder: JSONDecoder())
     .receive(on: RunLoop.main)
     .sink(receiveCompletion: { completion in
         switch completion {
         case .finished: print("✅ Done")
         case .failure(let error): print("❌ Error: \(error)")
         }
     }, receiveValue: { users in
         print("Users:", users)
     })
     .store(in: &cancellables)
 
 🔁 Important Combine Operators
 
 Operator    What It Does
 
 map    Transforms value / Change each value (like uppercase a string).
 filter    Filters values based on condition / Skip values that don’t match a condition.
 debounce    Waits before emitting (good for search) / Wait before sending value (e.g., 0.5 sec after typing stops).
 throttle    Limits frequency of emissions / Limit how often values are sent.
 retry(_:)    Automatically retry on failure / Try again if something fails.
 catch    Handles errors by switching to backup logic / Handle an error by switching to backup logic.
 flatMap    Flattens nested publishers / Combine nested publishers into one stream.
 combineLatest    Combines values from two publishers / v
 
 
 🎯 Subjects in Combine (Very Important for Interviews)
 1️⃣ PassthroughSubject 📍 Use for: Button taps, notifications, one-time events
     Does not hold any value
     Sends new values manually
     Sends only new values, doesn't remember old ones.
 
 ✅ Use case: Button taps, fire-once actions
 let subject = PassthroughSubject<String, Never>()
 subject.sink { print("🔔", $0) }.store(in: &cancellables)
 subject.send("Hello") // Emits only to active subscribers

 2️⃣ CurrentValueSubject 📍 Use for: Keeping shared state like login status
     Holds the latest value
     New subscribers immediately receive the last value
     Remembers latest value and sends it to any new subscriber.
 
 ✅ Use case: Track shared state (e.g. user login state)
 let subject = CurrentValueSubject<String, Never>("Initial")
 subject.send("Updated")
 subject.sink { print("🟢", $0) }.store(in: &cancellables)
 // Output: 🟢 Updated
 
 3️⃣ @Published
 Used in SwiftUI + ViewModel
 Works like CurrentValueSubject under the hood
 Auto-publishes changes of a property

 class MyViewModel: ObservableObject {
     @Published var name: String = "Awais"
 }
 
 💥 Combine Interview Questions (Most Common)
     What is Combine?
     A framework for handling async and event-driven code using publishers and subscribers.

     What is a Publisher and Subscriber?
     A Publisher emits values, and a Subscriber reacts to them.

     What is @Published?
     A property wrapper that automatically emits changes to SwiftUI views.
 
 🔹 Intermediate
 
 What is PassthroughSubject vs CurrentValueSubject?
     Passthrough: emits only new values, doesn’t store anything.
     CurrentValue: stores current value, sends latest to new subscribers.

 What is AnyCancellable?
    A token to manage the lifecycle of Combine subscriptions. You must store it to keep the subscription alive.

 How to cancel Combine subscriptions?
    Use cancellable.cancel() or store in a Set<AnyCancellable>.

 How do you handle errors in Combine?
    Using .catch or checking the .failure in .sink(receiveCompletion:).

 How do you retry network calls in Combine?
    publisher
        .retry(3)
        .catch { error in Just([]) }
 
 How does Combine handle threading?
    receive(on:) moves execution to desired thread (like RunLoop.main for UI).
 
     What is .sink in Combine?    .sink is used to subscribe to a publisher. It lets you receive values and completion events. It returns an AnyCancellable.
     What is receiveValue in .sink?    The closure that handles the actual data from the publisher (e.g., decoded API response).
     What is receiveCompletion in .sink?    A closure that is called when the stream is either finished or failed (used to handle errors or finish event).
     What is receive(on:)?    It changes the thread where the subscriber receives data. Mostly used to update UI on the main thread.
     What is .subscribe(on:)?    It defines which thread the publisher runs on, e.g., background for networking.
     What is Future in Combine?    A Future is a one-time publisher that emits a single value or error, usually used for async operations like an API or database fetch.
     How does Future differ from normal Publisher?    Future emits just one value and then completes. Other publishers may emit multiple values over time.
     What is a Promise in Combine?    It's a closure inside Future that you call to either succeed or fail with a value. You complete the future manually.
     Example of Future + Promise?    See below:
     Future<String, Error> { promise in
     if success { promise(.success("Done")) } else { promise(.failure(MyError)) }
     }
     When to use Future?    When wrapping non-Combine async APIs (e.g., using completion handlers) inside Combine flow.
     Can .sink fail silently?    Yes. If you don't handle receiveCompletion, you may miss error handling, so both closures are important.
     What's the difference between .sink and .assign?    .sink lets you perform custom logic, .assign just sets the value to a property.
     Why store .sink() in AnyCancellable?    To retain the subscription; otherwise, it will cancel immediately.
     What happens if you don’t store your subscription?    The publisher will cancel immediately, and you won’t receive any values.

     Publisher    Emits values
     Subscriber    Receives values
     PassthroughSubject    Send manual events (tap, alert)
     CurrentValueSubject    Share current state
     @Published    SwiftUI + ObservableObject
     map, filter, etc.    Chain transformations
     debounce, throttle    Reduce frequency
     retry, catch    Error recovery
     AnyCancellable    Manage memory
*/

// MARK: - HTTP Methods – Explained for iOS Interviews

/*

 📌 What Are HTTP Methods?
    HTTP Methods define what kind of action you want to perform on a resource (API endpoint) — such as reading, creating, updating, or deleting data.
 
 🔹 1. GET – Fetch data
     📦 Use case: Get list of users, product details, etc.
     🔐 Often includes query parameters.
     📡 Usually doesn't have a body.
 
    AF.request("https://api.example.com/users", method: .get)
 
 🔹 2. POST – Send (create) new data
     📦 Use case: Login, register, create order
     🔐 Often sends body in JSON format
     💾 Creates a new resource
 
    AF.request("https://api.example.com/login", method: .post, parameters: body, encoding: JSONEncoding.default)

 
 🔹 3. PUT – Update (replace) existing data
     📦 Use case: Update full profile or record
     💾 Replaces entire resource
 
 AF.request("https://api.example.com/users/1", method: .put, parameters: updatedData)
 
 🔹 4. PATCH – Partial update
     📦 Use case: Update just one field (e.g., user’s email only)
     🔄 More efficient than PUT
 
 AF.request("https://api.example.com/users/1", method: .patch, parameters: ["email": "new@email.com"])

 
 🔹 5. DELETE – Remove data
    📦 Use case: Delete a user, remove a product, etc.
 
 AF.request("https://api.example.com/users/1", method: .delete)

 Q1. What’s the difference between GET and POST?    GET is used to fetch data (read-only), while POST is used to send data (create new resource).
 Q2. When would you use PUT vs PATCH?    Use PUT when replacing the full resource, PATCH when updating only specific fields.
 Q3. Can a GET request have a body?    Technically yes, but it's discouraged. Parameters should be in URL.
 Q4. Is DELETE request safe?    No, because it modifies server state. Only GET is considered safe and idempotent.
 Q5. Are HTTP methods case-sensitive?    No, get, GET, Get are treated the same. But best practice is uppercase.
*/
